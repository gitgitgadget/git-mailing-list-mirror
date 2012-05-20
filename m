From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] l10n: de.po: translate 265 new messages
Date: Sun, 20 May 2012 22:56:10 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <1825828.hnjW9vybBO@cs-pc>
References: <1337533755-29399-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: trast@student.ethz.ch, jk@jk.gs, worldhello.net@gmail.com,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sun May 20 22:56:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWDB5-0001nd-2E
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 22:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab2ETU40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 16:56:26 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:36097 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab2ETU4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 16:56:25 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q4KKuFFL028317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 20 May 2012 22:56:15 +0200
Received: from cs-pc.localnet (e176207053.adsl.alicedsl.de [85.176.207.53])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q4KKuELr028050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 May 2012 22:56:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2012-20;
	t=1337547375; bh=VBfR/zM4AOReVTQGVG7MI3rf/Wz4Rd53aal8Sd42gWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hrTVdQJ6Xdr1vEpNy4MHtyvSYAB9Xk9uoXm91ddirD8rmSE3hceYEKNO1ct77IOlQ
	 RxpHEgPYwQTjw5O9XqsE5I4j+cMMv/CrRJ3hkHVQS3nOCS3l1tIODfBJgs5eaO/s8C
	 LInjzCg1TRPY5r3FVli0p2LJYeIFXSUlupDGw1EY=
User-Agent: KMail/4.7.3 (Linux/3.0.0-19-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <1337533755-29399-1-git-send-email-ralf.thielow@googlemail.com>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198069>

Dear Ralf,

your changes are very good. However, I just noticed one specific stylistic 
issue with the existing German translation, which you've continued in the very 
same way:

Am Sonntag, 20. Mai 2012, 19:09:15 schrieb Ralf Thielow:
> +#: help.c:214
> +msgid "git commands available from elsewhere on your $PATH"
> +msgstr "Vorhandene Git-Kommandos irgendwo in deinem $PATH"
(and several more following)

The translation (both in the existing strings and in your newly added ones) 
addresses the user as "du" instead of "Sie" (for the non-German-speaking: "du" 
is the informal addressing, "Sie" is the formal addressing). However, in 
German software there are two main rules on this: 1. Don't address the user 
directly. Rather prefer passive forms over directly addressing the person. I 
know English software is much more permissive of this one. Hence, occasionally 
the German translator should take the freedom to change the wording so that 
the addressing of the user is replaced in the translation by some passive 
wording without the addressing of the user. 2. If the addressing of the user 
is unavoidable, the text should use "Sie" instead of "du". Addressing the user 
as "du" should be constrained to audiences which for sure always address each 
other as "du", such as certain educational settings and/or games and such (and 
maybe in the Ikea-Katalog, but even there they switched from Du to Sie and 
back again several times). Please try to avoid using "du" in developer tools' 
user-visible strings. Thanks a lot!

Regards,

Christian
