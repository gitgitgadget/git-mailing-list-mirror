From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: make test failure with latest master
Date: Mon, 03 Dec 2007 08:33:27 +0100
Message-ID: <4753B147.2050404@viscovery.net>
References: <4752A53E.4030000@gmail.com> <20071202163426.GA29781@coredump.intra.peff.net> <47533D75.1090002@gmail.com> <Pine.LNX.4.64.0712022340250.27959@racer.site> <20071203015954.GB8322@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 08:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz5oS-0004yf-8N
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 08:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbXLCHdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 02:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbXLCHdc
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 02:33:32 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:18423 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXLCHdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 02:33:31 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iz5nF-0008S8-VD; Mon, 03 Dec 2007 08:32:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AE1976EF; Mon,  3 Dec 2007 08:33:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071203015954.GB8322@coredump.intra.peff.net>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66882>

Jeff King schrieb:
> -if ! ( type cvs && type cvsps ) >/dev/null 2>&1
> +if ! type cvs >/dev/null 2>&1
>  then
> -	test_expect_success 'skipping cvsimport tests, cvs/cvsps not found' ''
> +	test_expect_success 'skipping cvsimport tests, cvs not found' ''

FWIW, the idiom to provide informative messages in test cases is

	say 'skipping cvsimport tests, cvs not found'

This gives a distinguishing color, too.

-- Hannes
