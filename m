From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 2/2] Add support for GIT_CEILING_DIRS
Date: Wed, 14 May 2008 12:07:50 -0500
Message-ID: <71122C3E-67C8-42B0-BF95-D907718F9A57@sb.org>
References: <482A7CA0.9060908@facebook.com> <alpine.DEB.1.00.0805140903560.30431@racer> <D2EA6017-4607-4A55-8C72-CD2B772CAAE4@sb.org> <alpine.DEB.1.00.0805141759120.30431@racer>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 14 19:09:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwKTD-0001LZ-4L
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYENRH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbYENRH6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:07:58 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:43348 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752216AbYENRH6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 13:07:58 -0400
Received: from [192.168.1.106] (ip68-1-99-99.pn.at.cox.net [68.1.99.99])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 097F818DB4B;
	Wed, 14 May 2008 10:07:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805141759120.30431@racer>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82116>

On May 14, 2008, at 12:02 PM, Johannes Schindelin wrote:

> On Wed, 14 May 2008, Kevin Ballard wrote:
>
>> On May 14, 2008, at 3:23 AM, Johannes Schindelin wrote:
>>
>>>> @@ -414,6 +415,37 @@ const char *setup_git_directory_gently(int  
>>>> *nongit_ok)
>>>> if (!getcwd(cwd, sizeof(cwd)-1))
>>>> die("Unable to read current working directory");
>>>>
>>>> +	// Compute min_offset based on GIT_CEILING_DIRS.
>>>
>>> We do not like C99 style comments.  Remember, there are people who  
>>> compile
>>> Git on something else than the super-latest Linux with cutting- 
>>> edge GCC.
>>
>> Out of curiosity, what environment these days doesn't allow C99  
>> comments?
>
> On an SGI/IRIX machine I was working some time ago, GCC was too big  
> for my
> quota.  And the admin was not willing to install it.
>
> But I have to wonder: why argue something as C99 comments, when it  
> is _no
> problem_ whatsoever to replace them with C89-style comments,  
> especially
> given the fact that this makes our source code more consistent and  
> thus
> easier on the eye?

Oh I wasn't intending to argue, I just was curious. I'm always happy  
to adopt the style of the surrounding code (except when people use the  
One True Brace Style, ugh).

Granted, I personally prefer C99 comments for one-liners and C89  
comments for multi-liners. It's especially helpful if the comment goes  
off the right side of the screen, because I don't have to hunt for the  
closing */ (source code highlighting generally solves this issue, but  
I don't always read code in an environment that can understand it,  
e.g. email).

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
