From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: Making git push output quieter
Date: Wed, 5 Aug 2009 00:20:32 +0200
Message-ID: <3af572ac0908041520l327482f1u45121b6b991a3673@mail.gmail.com>
References: <200908042327.10912.aacid@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Albert Astals Cid <aacid@kde.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYSNk-0008AV-Ch
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 00:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459AbZHDWUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 18:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933410AbZHDWUf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 18:20:35 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49261 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933185AbZHDWUe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 18:20:34 -0400
Received: by bwz19 with SMTP id 19so3358166bwz.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 15:20:33 -0700 (PDT)
Received: by 10.223.117.14 with SMTP id o14mr1292058faq.96.1249424432956; Tue, 
	04 Aug 2009 15:20:32 -0700 (PDT)
In-Reply-To: <200908042327.10912.aacid@kde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124826>

On Tue, Aug 4, 2009 at 11:27 PM, Albert Astals Cid<aacid@kde.org> wrote=
:
> Hi, at KDE we are starting to try to use git and one of the things th=
at's
> bothering me is that git push is too verbose for our scripts.
>
> We have some scripts that commit things and i get the diff of previou=
s runs,
> if there is no diff it means all worked fine, a diff means something =
i have to
> look at.
>
> Now i'm getting diffs like
>
> -Counting objects: 23, done.
> +Counting objects: 53, done.
> =A0Delta compression using up to 2 threads.
> -Compressing objects: =A0 8% (1/12) =A0 Compressing objects: =A016% (=
2/12)
> Compressing objects: =A025% (3/12) =A0 Compressing objects: =A033% (4=
/12)
> Compressing objects: =A041% (5/12) =A0 Compressing objects: =A050% (6=
/12)
> Compressing objects: =A058% (7/12) =A0 Compressing objects: =A066% (8=
/12)
> Compressing objects: =A075% (9/12) =A0 Compressing objects: =A083% (1=
0/12)
> Compressing objects: =A091% (11/12) =A0 Compressing objects: 100% (12=
/12)
> Compressing objects: 100% (12/12), done.
> -Writing objects: =A0 8% (1/12) =A0 Writing objects: =A016% (2/12) =A0=
 Writing
> objects: =A025% (3/12) =A0 Writing objects: =A033% (4/12) =A0 Writing=
 objects: =A041%
> (5/12) =A0 Writing objects: =A050% (6/12) =A0 Writing objects: =A058%=
 (7/12) =A0 Writing
> objects: =A066% (8/12) =A0 Writing objects: =A075% (9/12) =A0 Writing=
 objects: =A083%
> (10/12) =A0 Writing objects: =A091% (11/12) =A0 Writing objects: 100%=
 (12/12)
> Writing objects: 100% (12/12), 1.05 KiB, done.
> -Total 12 (delta 11), reused 0 (delta 0)
> +Compressing objects: =A0 3% (1/29) =A0 Compressing objects: =A0 6% (=
2/29)
> Compressing objects: =A010% (3/29) =A0 Compressing objects: =A013% (4=
/29)
> Compressing objects: =A017% (5/29) =A0 Compressing objects: =A020% (6=
/29)
> Compressing objects: =A024% (7/29) =A0 Compressing objects: =A027% (8=
/29)
> Compressing objects: =A031% (9/29) =A0 Compressing objects: =A034% (1=
0/29)
> Compressing objects: =A037% (11/29) =A0 Compressing objects: =A041% (=
12/29)
> Compressing objects: =A044% (13/29) =A0 Compressing objects: =A048% (=
14/29)
> Compressing objects: =A051% (15/29) =A0 Compressing objects: =A055% (=
16/29)
> Compressing objects: =A058% (17/29) =A0 Compressing objects: =A062% (=
18/29)
> Compressing objects: =A065% (19/29) =A0 Compressing objects: =A068% (=
20/29)
> Compressing objects: =A072% (21/29) =A0 Compressing objects: =A075% (=
22/29)
> Compressing objects: =A079% (23/29) =A0 Compressing objects: =A082% (=
24/29)
> Compressing objects: =A086% (25/29) =A0 Compressing objects: =A089% (=
26/29)
> Compressing objects: =A093% (27/29) =A0 Compressing objects: =A096% (=
28/29)
> =A0Compressing objects: 100% (29/29) =A0 Compressing objects: 100% (2=
9/29), done.
> +Writing objects: =A0 3% (1/29) =A0 Writing objects: =A0 6% (2/29) =A0=
 Writing
> objects: =A010% (3/29) =A0 Writing objects: =A013% (4/29) =A0 Writing=
 objects: =A017%
> (5/29) =A0 Writing objects: =A020% (6/29) =A0 Writing objects: =A024%=
 (7/29) =A0 Writing
> objects: =A027% (8/29) =A0 Writing objects: =A031% (9/29) =A0 Writing=
 objects: =A034%
> (10/29) =A0 Writing objects: =A037% (11/29) =A0 Writing objects: =A04=
1% (12/29)
> Writing objects: =A044% (13/29) =A0 Writing objects: =A048% (14/29) =A0=
 Writing
> objects: =A051% (15/29) =A0 Writing objects: =A055% (16/29) =A0 Writi=
ng objects: =A062%
> (18/29) =A0 Writing objects: =A065% (19/29) =A0 Writing objects: =A06=
8% (20/29)
> Writing objects: =A072% (21/29) =A0 Writing objects: =A075% (22/29) =A0=
 Writing
> objects: =A079% (23/29) =A0 Writing objects: =A082% (24/29) =A0 Writi=
ng objects: =A086%
> (25/29) =A0 Writing objects: =A089% (26/29) =A0 Writing objects: =A09=
3% (27/29)
> Writing objects: =A096% (28/29) =A0 Writing objects: 100% (29/29) =A0=
 Writing
> objects: 100% (29/29), 4.46 KiB, done.
> +Total 29 (delta 23), reused 0 (delta 0)
> =A0=3D> Syncing Gitorious... [OK]
> =A0To git@gitorious.org:amarok/amarok.git
> - =A0 f7863f9..f4370ae =A0HEAD -> master
> + =A0 1a1b30f..670cb0e =A0HEAD -> master
>
> That really are not a problem and are filling my diffs for no reason.=
 We could
> redirect to > /dev/null the git push command but then i would not see=
 if
> anything failed.
>
> Is it possible to make git push just output data when failing? And if=
 not do
> you think it's a worthwhile feature i can ask for? Do you have a form=
al way
> for feature requests?

Have you tried redirecting only stdout to /dev/null, and keeping
stderr to yourself ? In addition to that, exit code !=3D 0 means
something went wrong.

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
