From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t6013: replace use of 'tac' with equivalent Perl
Date: Mon, 1 Sep 2008 12:05:01 -0400
Message-ID: <41757CC9-DB9B-41C9-A698-E2948F79DC2C@silverinsanity.com>
References: <1220212998-90810-1-git-send-email-benji@silverinsanity.com> <1220221897-6081-1-git-send-email-trast@student.ethz.ch> <48BBE682.2070000@op5.se>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Sep 01 18:07:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaBv0-00065U-Cq
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 18:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYIAQFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 12:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYIAQFH
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 12:05:07 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:55828 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbYIAQFG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 12:05:06 -0400
Received: from [192.168.1.109] (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 0120F1FFC13C;
	Mon,  1 Sep 2008 16:04:59 +0000 (UTC)
In-Reply-To: <48BBE682.2070000@op5.se>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94591>


On Sep 1, 2008, at 8:56 AM, Andreas Ericsson wrote:

> Thomas Rast wrote:
>> So I would favour this fix.  I think this should be ok because we
>> depend on Perl anyway.
>
> If it isn't, you could always do
> 	sed '1!G;h;$!d'
> or
> 	sed -n '1!G;h;$p'
> instead.
>
> Both of them are very portable indeed.

I am reminded of the last time I tried to remove a use of tac from git  
(rebase -i, to be specific).  I was yelled at for trying to use perl,  
and "sed -ne '1!G;$p;h'" turned out to be not portable enough.   
Eventually the command was re-written not to need the reversal.

Junio seems to think perl is just fine, judging by next, so I guess  
I'll just give up trying to second guess what the list wants.  :-/

~~ Brian
