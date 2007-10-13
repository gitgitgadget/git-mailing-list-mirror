From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Sat, 13 Oct 2007 19:12:08 +0100
Message-ID: <92879AC5-2927-439B-8EB0-AC20AAEE412E@steelskies.com>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv> <470DC05A.8020209@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Oct 13 20:17:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IglTr-0001fM-VH
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 20:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbXJMSMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 14:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbXJMSMO
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 14:12:14 -0400
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:39452 "EHLO
	smtp1.bethere.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762506AbXJMSMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 14:12:12 -0400
Received: from [192.168.1.65] (87-194-43-188.bethere.co.uk [87.194.43.188])
	by smtp1.bethere.co.uk (Postfix) with SMTP id 5614998229;
	Sat, 13 Oct 2007 19:12:10 +0100 (BST)
In-Reply-To: <470DC05A.8020209@viscovery.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60749>

On 11 Oct 2007, at 07:19, Johannes Sixt wrote:

>> -	 git-commit -F msg -m amending ."
>> +	git-commit -F msg -m amending ."
>
> You fix whitespace...
>
>>  test_expect_success \
>> -	"using message from other commit" \
>> -	"git-commit -C HEAD^ ."
>> +	 "using message from other commit" \
>> +	 "git-commit -C HEAD^ ."
>
> ... and you break it. More of these follow. Don't do that, it makes  
> patch review unnecessarily hard.


I'm just preparing to release this patch... was that "don't break  
whitespace", or "don't try to fix whitespace in a patch that's has  
nothing to do with whitespacing-fixing" ?

And while I'm here - tabs are preferred, are they?  There seem to be  
a mixture of tabs & 4 space indentation.
