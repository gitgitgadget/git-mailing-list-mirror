From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH] git-gui: Added support for OS X right click
Date: Sat, 4 Aug 2007 14:36:47 +0300
Message-ID: <AB48D3D9-0773-4492-A3C8-7B5992BE9E06@pp.inet.fi>
References: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi> <20070804065516.GS20052@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 13:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHHwv-0001uP-UB
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 13:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbXHDLhe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 07:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbXHDLhe
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 07:37:34 -0400
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:40559 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbXHDLhd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 07:37:33 -0400
Received: from [10.0.1.2] (GYKMMMCCXVII.dsl.saunalahti.fi [85.77.38.118])
	by gw03.mail.saunalahti.fi (Postfix) with ESMTP id F2DBB2161DA;
	Sat,  4 Aug 2007 14:37:29 +0300 (EEST)
In-Reply-To: <20070804065516.GS20052@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54824>

On Aug 4, 2007, at 09:55, Shawn O. Pearce wrote:

> I had a devil of a time applying your patch though.  git-am
> choked because the patch was whitespace damaged, and then after
> hand-correction and resuming it horribly munged your name's encoding
> in the commit.  I think there's a bug in there in git-am; I'll
> have to try to track it down.  I managed to get the patch applied
> correctly by editing the mbox file directly, so that git-am did
> not need to stop and ask me to resolve the patch.

You are right in that Mail.app seems to eat up the whitespaces in the =20
patch. I emailed the patch first to myself, and everything seemed =20
fine, should have tested it with git-am rather than eyeballing it, =20
sorry.

About the name-munging, that didn't happen for me, after i fixed the =20
spacing with Vim, the name shows up correctly in Git log. It seems =20
that the email is ISO-8859-1 encoded, I'll enforce UTF-8  encoding =20
next time if it helps, and I'll see if I can send an inlined patch =20
which works.

--
V=E4in=F6
