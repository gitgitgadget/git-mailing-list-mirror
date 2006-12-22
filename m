From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Keep "git --git-dir" from causing a bus error.
Date: Fri, 22 Dec 2006 12:34:01 -0500
Message-ID: <2E577524-FAFC-4A9C-809D-B3698682FDEB@silverinsanity.com>
References: <20061222135625.GA26084@179.242.249.10.in-addr.arpa> <Pine.LNX.4.63.0612221708070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 18:34:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxoHZ-0005LC-6x
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 18:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWLVReG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 12:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWLVReG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 12:34:06 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:45920 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbWLVReE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 12:34:04 -0500
Received: from [192.168.1.2] (cpe-66-67-221-135.rochester.res.rr.com [66.67.221.135])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 4F2541FFD296;
	Fri, 22 Dec 2006 17:34:02 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.63.0612221708070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35190>


On Dec 22, 2006, at 11:08 AM, Johannes Schindelin wrote:

>> +				fprintf(stderr, "No directory given for --git-dir.\n" );
>> +				usage(git_usage_string);
>
> Usage already exits, so you do not need this:
>
>> +			} else {

I suppose not.  It came out of a) habit and b) experiments with  
things that did not exit.

~~ Brian
