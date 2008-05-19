From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: t3701 fails if core.filemode disabled
Date: Mon, 19 May 2008 08:01:03 +0200
Message-ID: <20080519060103.GB3179@steel.home>
References: <20080518152337.GB3058@steel.home> <20080518190839.GC15506@sigill.intra.peff.net> <4830C71A.60308@verizon.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Mon May 19 08:02:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxyRa-0006ff-00
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 08:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbYESGBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 02:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYESGBG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 02:01:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:24252 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbYESGBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 02:01:06 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyHI8Q==
Received: from tigra.home (Fac8f.f.strato-dslnet.de [195.4.172.143])
	by post.webmailer.de (mrclete mo33) (RZmta 16.34)
	with ESMTP id c00d1dk4J0tuR9 ; Mon, 19 May 2008 08:01:04 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C80D0277BD;
	Mon, 19 May 2008 08:01:03 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 85F7B56D28; Mon, 19 May 2008 08:01:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4830C71A.60308@verizon.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82415>

Mark Levedahl, Mon, May 19, 2008 02:17:30 +0200:
> Jeff King wrote:
>> On Sun, May 18, 2008 at 05:23:37PM +0200, Alex Riesen wrote:
>>
>>> This is on Cygwin, yes. I have the core.filemode disabled in
>>> ~/.gitconfig. How about stopping the test before the failing portion
>>> (only the last two fail, below)?
>>
>> What's in your ~/.gitconfig shouldn't have any effect (the test scripts
>> take care to avoid looking at anything outside of your git directory).
>> But presumably this test is broken on Cygwin, anyway?
>>
> On Cygwin, support for correctly interpreting the execute bit is governed 
> by the operating system (WindowsNT/XP vs Windows9x), the file system 
> (NTFS vs FAT), and the (NO)NTEA and (NO)NTSEC options via the CYGWIN 

*and* the contents of the file. Look at the code.
