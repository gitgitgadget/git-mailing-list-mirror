From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 2/2] Add support for GIT_CEILING_DIRS
Date: Wed, 14 May 2008 11:51:19 -0500
Message-ID: <D2EA6017-4607-4A55-8C72-CD2B772CAAE4@sb.org>
References: <482A7CA0.9060908@facebook.com> <alpine.DEB.1.00.0805140903560.30431@racer>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 14 18:52:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwKDJ-0002Yb-IZ
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 18:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbYENQvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 12:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbYENQvd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 12:51:33 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:56351 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751731AbYENQvc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 12:51:32 -0400
Received: from [192.168.1.106] (ip68-1-99-99.pn.at.cox.net [68.1.99.99])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id A8DDCEEF5A;
	Wed, 14 May 2008 09:51:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805140903560.30431@racer>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82108>

On May 14, 2008, at 3:23 AM, Johannes Schindelin wrote:

>> @@ -414,6 +415,37 @@ const char *setup_git_directory_gently(int  
>> *nongit_ok)
>> 	if (!getcwd(cwd, sizeof(cwd)-1))
>> 		die("Unable to read current working directory");
>>
>> +	// Compute min_offset based on GIT_CEILING_DIRS.
>
> We do not like C99 style comments.  Remember, there are people who  
> compile
> Git on something else than the super-latest Linux with cutting-edge  
> GCC.

Out of curiosity, what environment these days doesn't allow C99  
comments? I think I started programming roughly 10 years ago (granted,  
I didn't start with C, but I did C programming at least 8 years ago,  
if not earlier) and every environment I've ever used has supported  
those comments even in C89 mode.

I mean, I fully understand that git wants to be portable across all  
platforms, but it still makes me wonder if there's any environment  
that anybody actually uses these days that doesn't understand those  
comments when compiling C.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
