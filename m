From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 19:21:38 +0100
Message-ID: <CALWbr2yz1LsQBpHW52x-QyQA-5d+R-sMibF+ZT-H=W+0gQNcuA@mail.gmail.com>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
	<20130116160410.GC22400@sigill.intra.peff.net>
	<7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
	<CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
	<20130116171809.GA2476@farnsworth.metanate.com>
	<7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
	<20130116175057.GB27525@sigill.intra.peff.net>
	<20130116180041.GC27525@sigill.intra.peff.net>
	<20130116181203.GB2476@farnsworth.metanate.com>
	<20130116181558.GA4426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:22:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXce-0003W3-TH
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab3APSVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:21:40 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:33300 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3APSVj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:21:39 -0500
Received: by mail-ea0-f179.google.com with SMTP id i12so632535eaa.38
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 10:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mxBdvLMMvvGDhj+muqmXKtYmVe41q7nm74qLx7Ary/k=;
        b=PDkmniKZllFR84oyP4KLqqFkFNdjTChVOaGFjktUXM/U22ShnP9Bjgu09bXA654x4B
         +u/HViLZxl/8JPPqBO3BB4V6E1516qchdhC2JW0xx6c9QjGWnoLbD10H46/DlqX8iQ4W
         7xvf8x35tGYmHIKuEKItkFK2mn+/gTXpvpjOUjcv1aDFZeNBoLSP4pywZ09/in/B5TaY
         MC4ISkZ7iO5RGph5QwszQ0ZL6BRdMPPbbHXGbiPf+A0FOZXwjhedGvaNMex5PdUvX4KI
         v5pkesXavOicfK2tqUL8Go1aeCyIASvdEM9OoGpa246JhVV51tCsBPw9Vy88Zt5yidYC
         28cw==
X-Received: by 10.14.1.195 with SMTP id 43mr4696609eed.31.1358360498681; Wed,
 16 Jan 2013 10:21:38 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 16 Jan 2013 10:21:38 -0800 (PST)
In-Reply-To: <20130116181558.GA4426@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213791>

> Is it worth applying this at all, then? Or should we apply it but limit
> it with a clang version macro (they mention r163034, but I do not know
> if it is in a released version yet, nor what macros are available to
> inspect the version)?

Please also note that building with clang is not warning-free (though
I think it would be nice)
