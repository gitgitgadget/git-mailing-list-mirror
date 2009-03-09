From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] grep: make show_line more portable
Date: Sun, 8 Mar 2009 22:44:40 -0400
Message-ID: <5ACAF49A-84B5-4F55-A8B8-0FC711708810@silverinsanity.com>
References: <1236561326-1231-1-git-send-email-benji@silverinsanity.com> <76718490903081922p105ebf79vb0bf06989413887c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 03:48:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgVXM-0004Jq-Le
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 03:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbZCICop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 22:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbZCICop
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 22:44:45 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:57092 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbZCICoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 22:44:44 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 643281FFC3FB; Mon,  9 Mar 2009 02:44:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 0E6A71FFC043;
	Mon,  9 Mar 2009 02:44:31 +0000 (UTC)
In-Reply-To: <76718490903081922p105ebf79vb0bf06989413887c@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112672>


On Mar 8, 2009, at 10:22 PM, Jay Soffian wrote:

> On Sun, Mar 8, 2009 at 9:15 PM, Brian Gernhardt
> <benji@silverinsanity.com> wrote:
>> On OS X the printf specifier "%.0s" outputs the entire string instead
>> of 0 characters as POSIX states.
>
> Does not reproduce for me:

Nor for me, as I noted on the other thread...  And looking again, I  
was reading the man page for printf(1), not printf(3).  Ouch.   
*grumble, grumble*  I'm crawling back under my rock now.

~~ B
