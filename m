From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Thu, 11 Oct 2007 22:22:48 +0100
Message-ID: <63D5CE5B-51DD-4017-B2E2-2ADC5DCBE849@steelskies.com>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv> <470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz> <470DCC76.7070809@viscovery.net> <81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv> <470DD3B8.1080809@viscovery.net> <85k5pts796.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:23:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig5V1-0004Xb-3o
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbXJKVWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbXJKVWw
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 17:22:52 -0400
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:52437 "EHLO
	smtp1.bethere.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905AbXJKVWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 17:22:51 -0400
Received: from [192.168.1.65] (87-194-43-188.bethere.co.uk [87.194.43.188])
	by smtp1.bethere.co.uk (Postfix) with SMTP id 6B98098114;
	Thu, 11 Oct 2007 22:22:49 +0100 (BST)
In-Reply-To: <85k5pts796.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60639>


On 11 Oct 2007, at 21:53, David Kastrup wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Jonathan del Strother schrieb:
>>> How are you going to test that git works on paths with spaces if the
>>> test suite doesn't run there?
>>
>> By writing a specific test?
>
> This is going to be much less thorough.  And it does no harm if the
> test scripts demonstrate defensive programming.

I would also point out that most tests have already been written to  
handle this case - ones that don't quote their paths are in the  
minority.
