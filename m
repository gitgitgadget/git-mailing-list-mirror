From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/8] t1300: style updates
Date: Wed, 24 Oct 2012 08:33:15 +0200
Message-ID: <50878BAB.60809@viscovery.net>
References: <20121023223502.GA23194@sigill.intra.peff.net> <20121023223554.GA17392@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 08:33:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQuX0-0001IF-EK
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 08:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872Ab2JXGdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 02:33:21 -0400
Received: from so.liwest.at ([212.33.55.24]:21006 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757648Ab2JXGdU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 02:33:20 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TQuWi-0004Yh-0g; Wed, 24 Oct 2012 08:33:16 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B4D691660F;
	Wed, 24 Oct 2012 08:33:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121023223554.GA17392@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208288>

Am 10/24/2012 0:35, schrieb Jeff King:
> -test_expect_success 'non-match value' \
> -	'test wow = $(git config --get nextsection.nonewline !for)'
> +test_expect_success 'non-match value' '
> +	test wow = $(git config --get nextsection.nonewline !for)
> +'

Here's a case you forgot to update to test_cmp.

> +test_expect_success 'get-regexp variable with no value' '
> +	git config --get-regexp novalue > output &&
> +	 test_cmp expect output'

And while you are here, you might want to remove this extra space. ;)

Otherwise, looks fine.

-- Hannes
