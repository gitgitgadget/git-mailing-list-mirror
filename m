From: Rene Herman <rene.herman@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 17:44:54 +0200
Message-ID: <4624EB76.2030700@gmail.com>
References: <4624CD58.90103@gmail.com>	 <81b0412b0704170721i2b64999aqbd0d7489074454d6@mail.gmail.com>	 <F47212AE-B31D-4025-9859-6794E7405DF2@silverinsanity.com> <81b0412b0704170811h510ce0afn1b2277b752bdf422@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:47:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdptn-000428-1j
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030890AbXDQPq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030887AbXDQPq7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:46:59 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:35436 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030879AbXDQPq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:46:58 -0400
Received: from [213.51.130.190] (port=52469 helo=smtp1.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HdptQ-00048b-P0; Tue, 17 Apr 2007 17:46:56 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:47092 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HdptJ-0004qR-QN; Tue, 17 Apr 2007 17:46:49 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
In-Reply-To: <81b0412b0704170811h510ce0afn1b2277b752bdf422@mail.gmail.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44784>

On 04/17/2007 05:11 PM, Alex Riesen wrote:

> ach, right. Dangerous: it can change the ref HEAD points to. Very sorry!
> Better just:
> 
> $ rm .git/HEAD && git symbolic-ref HEAD "refs/heads/<branch-name>"

Thanks.

> In the end, you just have git-checkout minus git-checkout-index. Maybe
> a "git-checkout -n" can be useful. Even though I can't imagine what for.

Thought about that as well, to keep with clone, but giving "checkout" an 
option to not checkout seems somewhat odd.

"git branch -s" for "not only create but Set current to it as well" maybe?

Rene.
