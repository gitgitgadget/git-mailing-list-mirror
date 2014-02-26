From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: Re: [PATCH] commit.c: use the generic "sha1_pos" function for lookup
 sha1
Date: Wed, 26 Feb 2014 22:49:05 +0400
Message-ID: <530E3721.6010502@yandex.ru>
References: <530DBCF3.9060801@yandex.ru> <20140226104150.GD25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 20:00:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIjiK-0000U7-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 20:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbaBZS76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 13:59:58 -0500
Received: from forward17.mail.yandex.net ([95.108.253.142]:53048 "EHLO
	forward17.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbaBZS75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 13:59:57 -0500
Received: from smtp16.mail.yandex.net (smtp16.mail.yandex.net [95.108.252.16])
	by forward17.mail.yandex.net (Yandex) with ESMTP id E07FB1062035;
	Wed, 26 Feb 2014 22:49:06 +0400 (MSK)
Received: from smtp16.mail.yandex.net (localhost [127.0.0.1])
	by smtp16.mail.yandex.net (Yandex) with ESMTP id A3BB56A06F0;
	Wed, 26 Feb 2014 22:49:06 +0400 (MSK)
Received: from 212.192.143.238 (212.192.143.238 [212.192.143.238])
	by smtp16.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id KbUbLexRps-n60CTT4X;
	Wed, 26 Feb 2014 22:49:06 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 0e884e1a-eaf9-406d-a60c-af5beb55e90c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393440546;
	bh=AHnHyPjj+ShdwDi+PXcqSsFhW+d73W14Xze+HvcJtco=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=r2pkYYN4y36L7kcKcpD1QmFUcNUh0J6zzsVxVMXe3rRe7XvKQfjvUMXMl1nBRUlPI
	 G0X8pR9rxKBqy3GeTwKu3xz0Fq0gXbCWNcmCJJMXN8J7WTOCUg6a/iWl1DZFTFzlod
	 2/CyIC7pflf0nC3vJEnbOkjCphQtxyPUYRbSUe2Y=
Authentication-Results: smtp16.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140226104150.GD25711@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242747>


Thank you for your remarks.  I'll try to fix my patch and send it again.
