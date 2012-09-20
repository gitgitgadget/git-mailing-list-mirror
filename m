From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v4 3/6] Color skipped tests blue
Date: Thu, 20 Sep 2012 07:48:36 +0200
Message-ID: <505AAE34.2020408@viscovery.net>
References: <20120919201326.GA23016@sigill.intra.peff.net> <1348086263-27555-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 07:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEZd8-0006d9-Ku
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 07:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab2ITFsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 01:48:45 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:15624 "EHLO
	so02.liwestmail.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751914Ab2ITFsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 01:48:45 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so02.liwestmail.local with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TEZcr-0008Cx-NS; Thu, 20 Sep 2012 07:48:37 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5397F1660F;
	Thu, 20 Sep 2012 07:48:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1348086263-27555-1-git-send-email-git@adamspiers.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206034>

Am 9/19/2012 22:24, schrieb Adam Spiers:
>  		skip)
> -			tput bold; tput setaf 2;; # bold green
> +			tput setaf 4;;            # blue

It's unreadable on black background. Keep it bold; that works on both
black and white background.

-- Hannes
