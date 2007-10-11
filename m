From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Thu, 11 Oct 2007 08:30:16 +0100
Message-ID: <81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>	<470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz> <470DCC76.7070809@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 09:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifsr9-0007HJ-Vh
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 09:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276AbXJKHxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 03:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756256AbXJKHxI
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 03:53:08 -0400
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:55033 "EHLO
	smtp1.bethere.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbXJKHxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 03:53:07 -0400
X-Greylist: delayed 1366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2007 03:53:06 EDT
Received: from takwin.config (87-194-43-188.bethere.co.uk [87.194.43.188])
	by smtp1.bethere.co.uk (Postfix) with SMTP id 1D9379809D;
	Thu, 11 Oct 2007 08:30:17 +0100 (BST)
In-Reply-To: <470DCC76.7070809@viscovery.net>
X-Mailer: Apple Mail (2.907)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60585>


On 11 Oct 2007, at 08:10, Johannes Sixt wrote:

> David Kastrup schrieb:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> IMHO, it's not too much of a burden for developers to require "sane"
>>> build directory paths.
>> For a normal user, the only writable directories might be of the
>> "C:\Programs and Data\User settings\Karl"
>> variety.
>
> I whole-heartedly agree about the part of the patch that fixes git- 
> rebase.sh. This should be a separate patch.
>
> But the reset of the patch is about running the test suite, and it  
> is much more difficult to fix because of the 'eval' that is going  
> on. And, yes, I do think that we can expect that contributors,  
> including this handful of people on Windows, have a "sane" build  
> directory.

How are you going to test that git works on paths with spaces if the  
test suite doesn't run there?
