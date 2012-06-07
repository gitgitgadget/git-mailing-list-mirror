From: konglu@minatec.inpg.fr
Subject: Re: rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 20:07:31 +0200
Message-ID: <20120607200731.Horde.xzrpWHwdC4BP0O3jZ46SyWA@webmail.minatec.grenoble-inp.fr>
References: <4FD0D375.9060902@web.de>
 <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD0EB76.90501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org
To: Torsten =?iso-8859-1?b?QvZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sch7U-0003Go-LG
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 20:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab2FGSHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 14:07:36 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:47735 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756531Ab2FGSHf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 14:07:35 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id E28C51A02F1;
	Thu,  7 Jun 2012 20:07:31 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Thu, 07 Jun
 2012 20:07:31 +0200
In-Reply-To: <4FD0EB76.90501@web.de>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199433>


Torsten B=F6gershausen <tboegi@web.de> a =E9crit=A0:

> Still no success :-(
> Please see below:
>
> git checkout a63d7ed3017e312ddc752ac89a7d292
> tb@birne:~/projects/git/git.git> git am --abort ; git am < =20
> 1339089425.H311811P3927.appes.lan\:2\,S
>
> Applying: rebase [-i --exec | -ix] <CMD>...
> error: patch failed: Documentation/git-rebase.txt:8
> error: Documentation/git-rebase.txt: patch does not apply
> error: patch failed: git-rebase--interactive.sh:684
> error: git-rebase--interactive.sh: patch does not apply
> error: patch failed: git-rebase.sh:3
> error: git-rebase.sh: patch does not apply
> error: patch failed: t/t3404-rebase-interactive.sh:755
> error: t/t3404-rebase-interactive.sh: patch does not apply
> Patch failed at 0001 rebase [-i --exec | -ix] <CMD>...
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort"=
=2E

On which branch are you applying the patch ? It should works on
branch master (it works for me) but it won't on branch "pu", as
it has already been queued.

Lucien Kong
