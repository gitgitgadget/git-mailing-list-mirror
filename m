From: Michael Olson <mwolson@gnu.org>
Subject: Re: [PATCH/RFC 0/2] git-svn: Allow certain refs to be ignored
Date: Wed, 21 Apr 2010 10:02:50 -0700
Message-ID: <k2oc8b3bef91004211002t8bf17be9w4bee4e76093c8eb6@mail.gmail.com>
References: <o2xc8b3bef91004201430m10bbe060q7d8ebd3a1ac4c3bd@mail.gmail.com> 
	<7vbpddekwk.fsf@alter.siamese.dyndns.org> <m2wc8b3bef91004210931xc0a7ec58ycbf18dd37d5e98f0@mail.gmail.com> 
	<20100421165451.GA14004@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>, Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 19:03:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4dKb-00038E-DS
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 19:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552Ab0DURDP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 13:03:15 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38102 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab0DURDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 13:03:15 -0400
Received: by vws18 with SMTP id 18so141521vws.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 10:03:14 -0700 (PDT)
Received: by 10.220.81.20 with HTTP; Wed, 21 Apr 2010 10:02:50 -0700 (PDT)
X-Originating-IP: [209.104.55.5]
In-Reply-To: <20100421165451.GA14004@dcvr.yhbt.net>
X-Google-Sender-Auth: d60bb92ffb08fc1e
Received: by 10.220.123.68 with SMTP id o4mr5936686vcr.8.1271869392698; Wed, 
	21 Apr 2010 10:03:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145444>

On Wed, Apr 21, 2010 at 9:54 AM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Michael Olson <mwolson@gnu.org> wrote:
>> ^refs/remotes/((tags/)?old/myorg|old/bad_branch|old/unlabeled[^/]*|t=
ags/(old/bad_tag|releases/another_tag))$
>
> I wonder if both would be better as a series of globs would be
> easier to read (maybe more verbose to write):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ignoreRefs =3D refs/remotes/tags/old/myorg
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ignoreRefs =3D refs/remotes/old/myorg
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ignoreRefs =3D refs/remotes/old/unlabeled/=
*

That does look cleaner, and kind of reminiscent of .gitignore.

--=20
Michael Olson  |  http://mwolson.org/
