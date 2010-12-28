From: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
Subject: Re[2]: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect diff.ignoreSubmodules config variable
Date: Tue, 28 Dec 2010 15:14:09 +0300
Message-ID: <1393005584.20101228151409@mail.ru>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-3-git-send-email-zapped@mail.ru> <4D15E48A.9050805@web.de>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 28 13:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXYRW-0005pN-4B
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 13:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab0L1MOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 07:14:12 -0500
Received: from smtp7.mail.ru ([94.100.176.52]:57074 "EHLO smtp7.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab0L1MOL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 07:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=bS92pnRjRSPu34FZeIsRK7AV8cMR7pdIISkeywTQHFo=;
	b=SA4gwVvEHbKZLqTrZxofE37pGLwNI5xy8iq+Z8XpxKSleizcxovx7qya0GTxsAgGQ761IIUClJC41LQhHoL/H+jdKCP8iQKVnO7Cwy1vVMpvPRF07KOFM7rRjqGxldPw;
Received: from [85.140.53.213] (port=15903 helo=ppp85-140-53-213.pppoe.mtu-net.ru)
	by smtp7.mail.ru with asmtp 
	id 1PXYRN-0002zm-00; Tue, 28 Dec 2010 15:14:09 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <4D15E48A.9050805@web.de>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164239>

Hi, all.

Well, I rolled back my so-called patch which rose up such a
discussion, and what I did see? Annoying behaviuor is vanished and perfomance of $PS1 is
acceptable (as fast as with the "patch").
I guess, as I said, something changed in Git since I discovered
and solved the problem such a weird way.

So, it seems to me, this patch might be considered unnecessary?
