From: Christoph Duelli <duelli@melosgmbh.de>
Subject: Re: File info from SHA ID
Date: Fri, 04 Apr 2008 15:55:05 +0200
Message-ID: <47F63339.3070903@melosgmbh.de>
References: <47F50CC5.20502@melosgmbh.de> <alpine.LFD.1.00.0804031009280.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 15:57:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhmQH-0005Yr-SF
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 15:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbYDDN4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 09:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbYDDN4s
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 09:56:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:63379 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbYDDN4r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 09:56:47 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi97hMDGc5n+ojdbo9B56/YXBytmKws+HDM9bkjM02t
Received: from mail.melosgmbh.de
	(p5B07AAFE.dip0.t-ipconnect.de [91.7.170.254])
	by post.webmailer.de (fruni mo51) (RZmta 16.19)
	with ESMTP id a05637k34BiGHX ; Fri, 4 Apr 2008 15:56:45 +0200 (MEST)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.036,BAYES_00: -1.665,TOTAL_SCORE: -1.629
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1);
	Fri, 4 Apr 2008 15:56:44 +0200
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <alpine.LFD.1.00.0804031009280.14670@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78803>

Linus Torvalds schrieb:
> 
> On Thu, 3 Apr 2008, Christoph Duelli wrote:
>> Given (only) a SHA ID (say from a file's $ID$ expansion), is it possible to
>> determine the file's name, date of commit etc?
> 
> Not directly, no.
> 
> But you can get it indirectly with a number of variations on
> 
> 	git whatchanged --raw --no-abbrev
> 
> and then just searching for that SHA1 ID in the result. That will also 
> show you where in the history that SHA1 came to be or went away.
> 
> The SHA1 itself is _purely_ about the actual contents of the file, so it 
> has no bearing on where that file actually exists, and two identical files 
> in different places will have the same SHA1. So no SHA1 -> filename 
> mapping can exist, but you can figure out where in the tree or history it 
> existed if you just have the full repository.
Ok, thank you. I was able to use the output of "git whatchanged --raw 
--no-abbrev" to achieve what I wanted to do.

-- 
Christoph Duelli
