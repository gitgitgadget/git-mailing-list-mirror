From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t5000-tar-tree.sh failing
Date: Thu, 21 Dec 2006 18:37:52 -0500
Message-ID: <D8B2508E-D9EE-43F8-BAEE-BE7E5B446132@silverinsanity.com>
References: <20061221133746.GA13751@cepheus> <Pine.LNX.4.63.0612211458360.19693@wbgn013.biozentrum.uni-wuerzburg.de> <9A725DAA-FAA8-4779-A73D-ED117CC068C1@silverinsanity.com> <20061221185948.GA27072@informatik.uni-freiburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 00:38:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxXU8-0000mF-J8
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 00:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423130AbWLUXh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 18:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423131AbWLUXh5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 18:37:57 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:36180 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423130AbWLUXh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 18:37:57 -0500
Received: from [192.168.1.2] (cpe-66-67-221-135.rochester.res.rr.com [66.67.221.135])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id A51521FFC02B;
	Thu, 21 Dec 2006 23:37:55 +0000 (UTC)
In-Reply-To: <20061221185948.GA27072@informatik.uni-freiburg.de>
To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35093>


On Dec 21, 2006, at 1:59 PM, Uwe Kleine-Koenig wrote:

> I'm not sure if (in this case) a missing unzip should be as silent as
> you suggest.  The danger is, that s.o. makes a change, runs `make  
> test`
> and is then conviced that nothing broke.  So I think that the test
> should fail, but with a more descriptive error than it is now.
>
> The downside is, you need unzip, svn, what ever more to run the test
> suite.

I was attempting to say that if we're skipping tests we should say  
so, and not just drop them silently like the code that Johannes  
posted.  Really, I guess the ideal would be for there to be a test  
harness that would run all the tests and report skips and errors in a  
report at the end rather than in the middle.

~~ Brian
