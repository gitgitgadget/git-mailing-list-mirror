From: Bill Lear <rael@zopyra.com>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 18:42:21 -0600
Message-ID: <17923.8813.162118.405908@lisa.zopyra.com>
References: <200702281036.30539.litvinov2004@gmail.com>
	<Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
	<200703210956.50018.litvinov2004@gmail.com>
	<200703211024.04740.litvinov2004@gmail.com>
	<Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703221257020.18328@xanadu.home>
	<Pine.LNX.4.64.0703221006360.6730@woody.linux-foundation.org>
	<20070322221340.GA13867@segfault.peff.net>
	<Pine.LNX.4.64.0703221720481.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 01:43:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUXrx-0001or-29
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 01:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934219AbXCWAmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 20:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934220AbXCWAmm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 20:42:42 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61313 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934219AbXCWAmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 20:42:37 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2N0gNA28395;
	Thu, 22 Mar 2007 18:42:23 -0600
In-Reply-To: <Pine.LNX.4.64.0703221720481.6730@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42889>

On Thursday, March 22, 2007 at 17:25:37 (-0700) Linus Torvalds writes:
>
>
>On Thu, 22 Mar 2007, Jeff King wrote:
>> 
>> Try EF_DISABLE_BANNER=1
>
>That does nothing for me. Nor does
>
>	strings -- /usr/lib64/libefence.so | grep EF_
>
>show that string or anything else half-way promising..
>
>Googling for that shows that some versions of efence have had that flag 
>(not necessarily as a environment variable, though). But certainly not the 
>version I have.

I just downloaded and installed the latest version (2.1.13):

% strings /usr/lib/libefence.a | grep BANNER
LLEF_DISABLE_BANNER
 EF_DISABLE_BANNER
EF_DISABLE_BANNER
EF_DISABLE_BANNER
EF_DISABLE_BANNER

http://perens.com/FreeSoftware/ElectricFence/electric-fence_2.1.13-0.1.tar.gz


Bill
