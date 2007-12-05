From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Color support for "git-add -i"
Date: Wed, 05 Dec 2007 13:21:16 +0100
Message-ID: <475697BC.2090701@viscovery.net>
References: <7vbq95tnk7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dan Zwell <dzwell@zwell.net>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 13:21:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IztG3-0004b9-MH
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 13:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbXLEMVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 07:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbXLEMVX
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 07:21:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18635 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbXLEMVW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 07:21:22 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IztEr-00038l-C3; Wed, 05 Dec 2007 13:20:29 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CB154546; Wed,  5 Dec 2007 13:21:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vbq95tnk7.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67150>

Junio C Hamano schrieb:
> +color.interactive::
> +	When true (or `always`), always use colors in `git add
> +	--interactive`.  When false (or `never`), never.  When set to
> +	`auto`, use colors only when the output is to the
> +	terminal. Defaults to false.

Any particular reason why color.interactive = true should be different from
color.diff = true? See 57f2b842 ("color.diff = true" is not "always" anymore)

-- Hannes
