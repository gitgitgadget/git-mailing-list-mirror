From: Robert Shearman <rob@codeweavers.com>
Subject: Re: [PATCH] format-patch: Generate a newline between the subject
 header and the message body.
Date: Thu, 13 Jul 2006 21:03:26 +0100
Organization: CodeWeavers
Message-ID: <44B6A70E.7060301@codeweavers.com>
References: <44B6369D.6070602@codeweavers.com> <e967en$bi6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 13 22:05:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G17Py-0008LB-PJ
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 22:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWGMUEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 16:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWGMUEA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 16:04:00 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:8628 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1030344AbWGMUD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 16:03:59 -0400
Received: from host86-141-83-116.range86-141.btcentralplus.com ([86.141.83.116] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G17Pi-0007Ym-20
	for git@vger.kernel.org; Thu, 13 Jul 2006 15:03:58 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <e967en$bi6$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23845>

Jakub Narebski wrote:

>Robert Shearman wrote:
>  
>
>>format-patch previously didn't generate a newline after a subject. This 
>>caused the diffstat to not be displayed in messages without a blank line 
>>and the first blank line to be eaten in messages with a blank line.
>>    
>>
>
>Does this _enforce_ separating commit message into subject+empty
>line+description? What about commit messages without this structire (e.g.
>legacy commit messages from import from other SCM, e.g. GNU ChangeLog
>style)?
>

It only affects commits exported into email style. It has nothing to do
with the structure of GIT commit messages or those of any other SCM.

-- 
Rob Shearman
