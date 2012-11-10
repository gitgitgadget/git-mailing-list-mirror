From: Jason Timrod <jtimrod@yahoo.com>
Subject: git-status:  Use "-sb" options by default?
Date: Sat, 10 Nov 2012 03:04:17 -0800 (PST)
Message-ID: <1352545457.32390.YahooMailNeo@web160304.mail.bf1.yahoo.com>
Reply-To: Jason Timrod <jtimrod@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX8wj-0005A5-6U
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 12:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab2KJLJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 06:09:40 -0500
Received: from nm17-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.157]:41253 "EHLO
	nm17-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750762Ab2KJLJj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 06:09:39 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2012 06:09:39 EST
Received: from [98.139.212.151] by nm17.bullet.mail.bf1.yahoo.com with NNFMP; 10 Nov 2012 11:04:18 -0000
Received: from [98.139.212.245] by tm8.bullet.mail.bf1.yahoo.com with NNFMP; 10 Nov 2012 11:04:17 -0000
Received: from [127.0.0.1] by omp1054.mail.bf1.yahoo.com with NNFMP; 10 Nov 2012 11:04:17 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 980850.57211.bm@omp1054.mail.bf1.yahoo.com
Received: (qmail 32532 invoked by uid 60001); 10 Nov 2012 11:04:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1352545457; bh=VMWbIuMx3BJ+XNLsWxNMnh9JtL9Rv1T/mheyZsXVGH8=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=u8CTDwLLmgLfEEmapDaHxwX337LmHKiYpppeqYatGLWm0vcBJF7JdbPWByIjJOZNeXRjACO/ihQemW1hgsU1VXFEDSIE40g57CUIqG4CQzDLj9Ml0xQpZmGpgcG9p0F0xYTtkxfKDgl+XooXTrdn6A6P5zhL25pC7yJjlPUvm3A=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xvJnptTegw3tTdSEjC14nGoDSvuocaVVl742yC+ZSwiCD9t73Zt/X0rzrIM7Q4C/G76ApqQOusElNcZiDZ4qo7be6VrVSxaBljAeSt8830j7OkxiBhjP3f78NTX0KzwTU/coehgg8vBIGLma/2P76UkjZsQ1S6W/ZTNLEfXyNeI=;
X-YMail-OSG: PKlbU34VM1nZbQXavFO0wHyw5VP.tin53kK3d7niDIqtls7
 K6pnkOjS9ENqPWp2qKuedYnFMy8in1FObRulxVqewBDA8PbwG5ARydbQ2ix5
 I7F5wQm2GG2yJNy._gSZ0rcWkrsg5cgQ.zNYXj90ek0VQR2qxWgvyyBLABaf
 nex2EX53fXAbkxkqI7hM.B4kHvHiQp8vQRUqEvfjhS59a2lPkAZNSvET0K1d
 eQaDjO2yMgnurjXSqC709XKqlaTuY33k4uGxTM4pFimQeak31pEmoJxgMLY9
 ITvy5cInlOHV12v69iuHXJQxfWG5vq68bTXdqMsGGT0wDvsCtb6G_0jEigrX
 PskDO0QiEOrhqO8lfbwU.yhSqfuJsKywZh_E44uwnOd9ZrDRzpKyYiTJkDI3
 jQcsRZQr6dSXEkIvGIPZYphuL0WqvfWcCs_6h1k8-
Received: from [213.104.227.168] by web160304.mail.bf1.yahoo.com via HTTP; Sat, 10 Nov 2012 03:04:17 PST
X-Rocket-MIMEInfo: 001.001,SGksCgpJJ3ZlIGJlZW4gcm9vdGluZyBhcm91bmQgdGhlICJnaXQtY29uZmlnIiBtYW4gcGFnZSBhcyB3ZWxsIGFzIHRoZSAiZ2l0LXN0YXR1cyIgbWFuIHBhZ2UsIGJ1dCBjb3VsZG4ndCBmaW5kIHRoZSBmb2xsb3dpbmcsIHdoaWNoIHN1Z2dlc3RzIGl0J3Mgbm90ICh5ZXQpIHBvc3NpYmxlLgoKSSdtIGxvb2tpbmcgZm9yIGEgd2F5IHRvIG1ha2UgdGhlICItc2IiIG9wdGlvbnMgdG8gZ2l0LXN0YXR1cyB0aGUgZGVmYXVsdCBzb21laG93LiDCoFRoYXQgaXMsIEkgd291bGQgbGlrZSB0aGUgc2hvcnQgZm9ybSABMAEBAQE-
X-Mailer: YahooMailWebService/0.8.123.460
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209271>

Hi,

I've been rooting around the "git-config" man page as well as the "git-=
status" man page, but couldn't find the following, which suggests it's =
not (yet) possible.

I'm looking for a way to make the "-sb" options to git-status the defau=
lt somehow. =A0That is, I would like the short form of git-status to be=
 the default when typing in "git status". =A0I appreciate I am able to =
do this in an indirect way using aliases, but this is slightly suboptim=
al for me.

If this isn't possible directly, would someone mind considering this a =
feature request?

Out of interest, would this be done via the git-config system, most lik=
ely?

Thanks kindly,

Jason
