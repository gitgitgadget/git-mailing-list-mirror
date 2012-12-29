From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] do not write null sha1s to on-disk index
Date: Sat, 29 Dec 2012 02:51:32 -0800
Message-ID: <20121229105132.GA31505@elie.Belkin>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
 <20121229104247.GA30283@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 11:56:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tou5t-0002QR-0g
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 11:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab2L2Kvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 05:51:44 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:39346 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab2L2Kvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 05:51:43 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so6283740pbb.11
        for <git@vger.kernel.org>; Sat, 29 Dec 2012 02:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=j/Cjw+cEn+slvoXd93LWLSMNwd0S/7xE9Yn3uYwAt+s=;
        b=nN3FWkwNQgCJUjf97b54IqfndHF4vU9n3VaDlqcBc/Q76vt4nW8SC8MQVHm3+n8rdw
         VrSVjqyeL6/+dJPNFU86lixAX+7aNl+oZK3naVgaKX/TXzp3ZakTnh85+tSo0jyosPXE
         EJiXytDVVJSN9CWA+f0Cxs5oM0NXeAbatXiZCGVnvUuo1K1s/3QUjwUv1CX2Jur70gFW
         z5BJZQHBQfss1MNq5itETE/l/Z1RLGeXtF5z3o0r0XSKQWUqnogusDqfHpVt5unMcwwN
         DQZHCgFuSoOOlQrrlqLm0Q6eQjY0ra+RM06iDPpop5QTBTO1q51Bkl5NUsWmP+CyRA2P
         Brjg==
X-Received: by 10.68.239.99 with SMTP id vr3mr111617077pbc.154.1356778301674;
        Sat, 29 Dec 2012 02:51:41 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id qb3sm21292548pbb.35.2012.12.29.02.51.39
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Dec 2012 02:51:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121229104247.GA30283@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212307>

Jeff King wrote:

> Hrm. But your output does not say there is a conflict. It says you have
> a local modification and it does not try the merge:

That's probably operator error on my part when gathering output to
paste into the email.

In other words, nothing to see there. :)  Sorry for the confusion.

[...]
> If I try to apply it, I get a real conflict:
[...]
> Although running "git am --abort" after that does seem to produce the
> "cache entry has null sha1" error.

Yep, that is what my report should have said.

'night,
Jonathan
