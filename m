From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH] t0020-crlf: test rebase with text conversion and safecrlf
Date: Fri, 21 Jun 2013 16:24:57 +0200
Organization: OPTEYA
Message-ID: <41e212cf1702cd60114f522f96627d20@meuh.org>
References: <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
 <1371824124-4242-1-git-send-email-ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 16:25:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq2Gt-0000Sh-5c
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 16:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422960Ab3FUOY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jun 2013 10:24:58 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:64490 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422915Ab3FUOY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 10:24:58 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Uq2Gn-000Kjf-7V
	for <git@vger.kernel.org>; Fri, 21 Jun 2013 16:24:57 +0200
In-Reply-To: <1371824124-4242-1-git-send-email-ydroneaud@opteya.com>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228617>

Le 21.06.2013 16:15, Yann Droneaud a =C3=A9crit=C2=A0:
> This patch add two tests to reproduce the problems described
> in thread "git rebase fail with CRLF conversion"
>  <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
>  <http://thread.gmane.org/gmane.comp.version-control.git/228613>
>  <http://marc.info/?l=3Dgit&m=3D137182211414404&w=3D2>
>
> - Add and commit a file with CRLF,
> - Add and commit a .gitattributes with text flag for the file,
> - Convert CRLF to LF in file, commit the change,
> - Rebase the whole on top of another parent
>   The rebase currently failed.
>
> This scenario is repeated twice, first with core.safecrlf set to=20
> warn,
> a second time with core.safecrlf set to true.
>

Note: those two tests might failed as described in message

"git rebase fail with CRLF conversion"
  <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
  <http://thread.gmane.org/gmane.comp.version-control.git/228613>
  <http://marc.info/?l=3Dgit&m=3D137182211414404&w=3D2>

I haven't found a testcase to reproduce the same exact failure at will.

So this patch should probably not used asis until the two kind of=20
errors can be reproduced.

Additionnaly, It should also be tested on a CRLF system (Windows).

> git diff will also fail when core.safecrlf is set to true
> and the file is not already converted to LF.
>

It might be a test on its own.

Regards

--=20
Yann Droneaud
OPTEYA
