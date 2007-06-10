From: Sam Vilain <sam@vilain.net>
Subject: Re: Is this an acceptable workflow in git-svn, or a user error?
Date: Sun, 10 Jun 2007 19:49:14 +1200
Message-ID: <466BACFA.1000704@vilain.net>
References: <7vy7itdjv6.fsf@assigned-by-dhcp.cox.net> <20070609193835.GB32225@muzzle> <466BABFB.8080208@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIAz-0007L0-Ib
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762010AbXFJHt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762001AbXFJHt2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:49:28 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48890 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760785AbXFJHt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:49:27 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id B9DA713A4FE; Sun, 10 Jun 2007 19:49:26 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D9AD713A4F4;
	Sun, 10 Jun 2007 19:49:22 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <466BABFB.8080208@vilain.net>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49666>

Sam Vilain wrote:
> Eric Wong wrote:
>   
>>> Is my understanding correct?
>>>       
>> Yes.  Since dcommit uses rebase, it'll rewrite history.  
>>     
> Maybe these new lightweight annotations could be a way around that?
>   

Actually I don't think that will work either unless you start
encapsulating extra git information (author/committer email/timestamps)
in the svn commit somewhere, so that someone else fetching the commits
from svn directly will end up with the same git commitid. And then
there's still the issue of merges.

Sam.
