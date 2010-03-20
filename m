From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCHv2] Add ignore and clean rules for gitweb.min.js
Date: Fri, 19 Mar 2010 23:05:31 -0400
Message-ID: <4BA43B7B.7030409@mailservices.uwaterloo.ca>
References: <4BA3EF47.7060905@mailservices.uwaterloo.ca> <7viq8sc6rb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 04:06:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsp0Q-0001z8-2c
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 04:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab0CTDFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 23:05:36 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:54542 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752600Ab0CTDFf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 23:05:35 -0400
Received: from bas1-toronto01-1177657629.dsl.bell.ca (bas1-toronto01-1177657629.dsl.bell.ca [70.49.161.29])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o2K35V6F020675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Mar 2010 23:05:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <7viq8sc6rb.fsf@alter.siamese.dyndns.org>
X-UUID: f6f8a6bb-5d6e-4a02-a46c-c8c7e3312cb5
X-Miltered: at mailchk-m05 with ID 4BA43B7B.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Fri, 19 Mar 2010 23:05:34 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142677>

Junio,

I went and added some other things that should probably be squashed
into this commit, unless it is too late. Updating documentation for
jsmin and adding autoconfigure support for it.

-- 
Mark Rada (ferrous26)
marada@uwaterloo.ca


On 10-03-19 5:59 PM, Junio C Hamano wrote:
> Mark Rada <marada@uwaterloo.ca> writes:
> 
>> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
>>
>> ---
>>
>> The instaweb patch from earlier was about making the instaweb
>> script aware that users can generate a minified version of 
>> gitweb.js. I think the stuff I am doing in this patch was just
>> forgotten when JSMIN support was first added for gitweb.
>>
>> Junio, I went and changed the clean target changes according
>> to your comment.
> 
> Thanks, will queue.
