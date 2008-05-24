From: Pieter de Bie <pieter@frim.nl>
Subject: Re: [PATCH] Documentation/git-gc.txt: change --aggressive description
Date: Sat, 24 May 2008 21:03:24 +0200
Message-ID: <25B3A6F3-5650-438D-807F-983C811084CC@frim.nl>
References: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl> <alpine.DEB.1.00.0805131251320.30431@racer> <FCA89971-FDBB-4E44-82CE-C0AA854A4667@ai.rug.nl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 21:47:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzzhq-0003p4-C2
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 21:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbYEXTp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 15:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbYEXTp5
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 15:45:57 -0400
Received: from frim.nl ([87.230.85.232]:49448 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752693AbYEXTp4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 May 2008 15:45:56 -0400
X-Greylist: delayed 2543 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 May 2008 15:45:56 EDT
Received: from ip63-33-210-87.adsl2.versatel.nl ([87.210.33.63] helo=[192.168.1.7])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1Jzz1f-0002SD-UX
	for git@vger.kernel.org; Sat, 24 May 2008 21:03:32 +0200
In-Reply-To: <FCA89971-FDBB-4E44-82CE-C0AA854A4667@ai.rug.nl>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82823>


On May 14, 2008, at 8:48 AM, Pieter de Bie wrote:
> On 13 mei 2008, at 13:52, Johannes Schindelin wrote:
>>> The documentation for the --aggressive flag was misleading,  
>>> hinting that
>>> running git gc with --aggressive is a good thing. However, -- 
>>> aggressive
>>> only really makes sense if you have a bad pack file, such as from
>>> git-fast-import.
>>
>> I disagree.  It makes sense to "git gc --aggressive" also after  
>> cloning
>> from somebody who did not do so.
>
> The problem with this is that your pack might increase in size,  
> which you can't know in advance. Running "git gc --aggressive" on  
> the git repo for example increases its size from 20MB to 30MB.
>
> The current wording at least makes it sound as if --aggressive will  
> always result in a smaller pack, which is simply not true.  
> Increasing the window and depth might help, but 250 or even 100 can  
> be too much on any decently size repository.

Any other comments on this patch? I still think it is an improvement  
over what is currently in the the man-page.

- Pieter
