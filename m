From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 18:03:15 +0000
Message-ID: <1358359395-ner-7610@calvin>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
	<20130116160410.GC22400@sigill.intra.peff.net>
	<7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
	<CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
	<20130116171809.GA2476@farnsworth.metanate.com>
	<7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
	<20130116175057.GB27525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXKy-00024g-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab3APSDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:03:22 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:54156 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab3APSDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:03:21 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so1031882wgb.8
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:subject:to:cc:references:in-reply-to:mime-version
         :date:message-id:content-type;
        bh=EVRVPkzWyVyO+SPTof1Jugo+YFZSNTLIYTcM95uW4lo=;
        b=HZqsyKi9J5uRwXR7qnKjIX0xo3/oBkxco6tjrZJv+szR/GY79afN4XaNUbUjdiyk/M
         1g/xtsKXkqOPUlqEgvBrnjFtiUPXaGLbwDmX0wtTD1kPTehGCMMqJ49Yow11nnr3cnsb
         VjTgHp1wF89Kvw+Ftw5kMqGoDaDuqqqDLOsfUFVQqxfAAu6/lWtHXbmKHnPNFsQiGYiO
         1UqB5PeIqqfOpkO605yZJ79xDez/npOknVaeP8r4ZCU4kgqqO4ad+v5/TjwUi5Ct2MvB
         FLrawHBJZAJejEOp/rUjgMUSfpoAk2yaAEFh+xtBehWsA1Zne/bAiZj2XSobuLL5YuNp
         QClA==
X-Received: by 10.195.12.42 with SMTP id en10mr3841974wjd.24.1358359399850;
        Wed, 16 Jan 2013 10:03:19 -0800 (PST)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id dm3sm9355163wib.9.2013.01.16.10.03.17
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 10:03:18 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id C85CC112C09; Wed, 16 Jan 2013 18:03:15 +0000 (UTC)
In-Reply-To: <20130116175057.GB27525@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213784>

On Wed, 16 Jan 2013 09:50:57 -0800, Jeff King <peff@peff.net> wrote:
>   However, clang also defines __GNUC__, [...]

http://sourceforge.net/p/predef/wiki/Compilers/

    Notice that the meaning of the __GNUC__ macro has changed subtly over the
    years, from identifying the GNU C/C++ compiler to identifying any compiler
    that implements the GNU compiler extensions (...). For example, the Intel
    C++ on Linux also defines these macros from version 8.1 (...).
