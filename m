From: Jeff King <peff@peff.net>
Subject: Re: make test failure with latest master
Date: Mon, 3 Dec 2007 02:35:53 -0500
Message-ID: <20071203073553.GA3614@sigill.intra.peff.net>
References: <4752A53E.4030000@gmail.com> <20071202163426.GA29781@coredump.intra.peff.net> <47533D75.1090002@gmail.com> <Pine.LNX.4.64.0712022340250.27959@racer.site> <20071203015954.GB8322@coredump.intra.peff.net> <4753B147.2050404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 08:36:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz5qj-0005aS-Jc
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 08:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbXLCHf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 02:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbXLCHf6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 02:35:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2626 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbXLCHf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 02:35:57 -0500
Received: (qmail 27082 invoked by uid 111); 3 Dec 2007 07:35:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 03 Dec 2007 02:35:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2007 02:35:53 -0500
Content-Disposition: inline
In-Reply-To: <4753B147.2050404@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66883>

On Mon, Dec 03, 2007 at 08:33:27AM +0100, Johannes Sixt wrote:

>> -	test_expect_success 'skipping cvsimport tests, cvs/cvsps not found' ''
>> +	test_expect_success 'skipping cvsimport tests, cvs not found' ''
>
> FWIW, the idiom to provide informative messages in test cases is
>
> 	say 'skipping cvsimport tests, cvs not found'
>
> This gives a distinguishing color, too.

Ah, I adapted the test from t9400, which uses expect_success. Thanks for
the tip.

-Peff
