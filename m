From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t0081-*.sh: Fix failure of the 'long read' tests
Date: Sat, 30 Apr 2011 18:12:48 +0100
Message-ID: <4DBC4310.4000105@ramsay1.demon.co.uk>
References: <4DB70972.20308@ramsay1.demon.co.uk> <20110426193539.GA2616@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 19:28:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGDxX-0008Nn-VK
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 19:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757681Ab1D3R1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2011 13:27:45 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:47423 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751383Ab1D3R1o (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2011 13:27:44 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1QGDxH-0004Xf-oF; Sat, 30 Apr 2011 17:27:44 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110426193539.GA2616@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172523>

Jonathan Nieder wrote:
> Ramsay Jones wrote:
> 
>> --- a/t/t0081-line-buffer.sh
>> +++ b/t/t0081-line-buffer.sh
>> @@ -25,8 +25,7 @@ generate_tens_of_lines () {
>>  		do
>>  			echo "$line"
>>  		done &&
>> -		: $((i = $i + 1)) ||
>> -		return
>> +		i=$(($i + 1))
>>  	done
> 
> This test is a mess.  Could you try the patch from the tip of
> 
> 	git://repo.or.cz/git/jrn.git svn-fe
> 
> which just gets rid of it instead?

Ah, so I didn't imagine the discussion to remove this test!

Yes, this works great for me. So, I will keep skipping the test
until this patch makes it into git.git.

Thanks!

ATB,
Ramsay Jones
