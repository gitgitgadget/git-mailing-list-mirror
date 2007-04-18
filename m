From: Sam Vilain <sam@vilain.net>
Subject: git-format-patch for binary files / merges [Re: Expose subprojects
 as special files to "git diff" machinery]
Date: Wed, 18 Apr 2007 20:46:38 +1200
Message-ID: <4625DAEE.3090702@vilain.net>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org> <200704152116.26773.andyparkins@gmail.com> <Pine.LNX.4.64.0704151402130.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 10:47:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He5pE-0005Hy-Ji
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 10:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030649AbXDRIqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 04:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030760AbXDRIqx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 04:46:53 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:59369 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030649AbXDRIqo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 04:46:44 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id C1DCF13A400; Wed, 18 Apr 2007 20:46:41 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 84E6C13A382;
	Wed, 18 Apr 2007 20:46:38 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <Pine.LNX.4.64.0704151402130.5473@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44872>

Linus Torvalds wrote:
>> Isn't this dangerous because it looks just like a normal diff with a 
>> file being rewritten, when in truth it is a tree entry record being 
>> rewritten.
>>     
> Well, that's exactly what symlinks do too.
>
> You have to look at the mode to know what the rewriting *means*.
>
> But yeah, I wouldn't object at all to making it an "extended git header" 
> instead (possibly just for subprojects, possibly for symlinks too)
>   

Speaking of 'custom' patch file formats, anyone put any thought to a
format for the commits which can't be represented with patch, like
binary files and merges?

Sam.
