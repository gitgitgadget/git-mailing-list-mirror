From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default
	values for user.*
Date: Fri, 7 Mar 2008 17:41:11 +0100
Message-ID: <20080307164111.GB4899@steel.home>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com> <20080305204414.GB4877@steel.home> <8aa486160803061345k690af0dcv14fe5d62b310ad6f@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-15?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 17:59:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXfuy-0000Rz-Th
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 17:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbYCGQ65 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 11:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755531AbYCGQ65
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 11:58:57 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:32726 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbYCGQ65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 11:58:57 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtopLGF0=
Received: from tigra.home (Faaef.f.strato-dslnet.de [195.4.170.239])
	by post.webmailer.de (mrclete mo33) (RZmta 16.8)
	with ESMTP id c047e1k27GiDZL ; Fri, 7 Mar 2008 17:58:54 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D87A2277C6;
	Fri,  7 Mar 2008 17:41:11 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 55C9756D24; Fri,  7 Mar 2008 17:41:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8aa486160803061345k690af0dcv14fe5d62b310ad6f@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76501>

Santi B=E9jar, Thu, Mar 06, 2008 22:45:43 +0100:
> On Wed, Mar 5, 2008 at 9:44 PM, Alex Riesen <raa.lkml@gmail.com> wrot=
e:
> > Santi B=E9jar, Wed, Mar 05, 2008 20:18:04 +0100:
> >
> >  > @@ -171,7 +171,7 @@ static const char au_env[] =3D "GIT_AUTHOR_N=
AME";
> >  >  static const char co_env[] =3D "GIT_COMMITTER_NAME";
> >  >  static const char *env_hint =3D
> >  >  "\n"
> >  > -"*** Your name cannot be determined from your system services (=
gecos).\n"
> >  > +"*** Your name cannot be determined.\n"
> >
> >  Why not?
>=20
> Is this important? Or in another way, is this useful? The important
> thing is how you can fix it. But others think otherwise I'll change i=
t
> to explain the reason.

It is precise explanation of what happened. It could be a hint to fix
gecos field to someone. It is considered useful not to hide
information, even if you have no idea of how useful it is. Others may
be smarter than you.

It could be shortened, thopugh. Maybe remove the asterisks, and
replace "from your system services (gecos)" with a shorter (but
precise) information.

