From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb not friendly to firefox?
Date: Thu, 01 Mar 2007 03:56:19 -0800
Message-ID: <7vvehlqisc.fsf@assigned-by-dhcp.cox.net>
References: <989B956029373F45A0B8AF02970818902DA70E@zch01exm26.fsl.freescale.net>
	<200703011134.22451.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Li Yang-r58472" <LeoLi@freescale.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 12:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMjty-0006En-TV
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 12:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbXCAL4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 06:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbXCAL4V
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 06:56:21 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50315 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965021AbXCAL4U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 06:56:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301115620.QTWV748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 06:56:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VPwK1W00E1kojtg0000000; Thu, 01 Mar 2007 06:56:19 -0500
In-Reply-To: <200703011134.22451.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 1 Mar 2007 11:34:20 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41091>

Andy Parkins <andyparkins@gmail.com> writes:

> On Thursday 2007 March 01 10:57, Li Yang-r58472 wrote:
>
>> XML Parsing Error: not well-formed
>> Location:
>> http://10.193.20.133/gitweb/?p=linux-2.6.git;a=commit;h=c0051ec763eca4c1
>> adfcb8d461243d0a7b444bb7
>> Line Number 43, Column 38:<tr><td>author</td><td>Li Yang
>> <LeoLi@freescale.com></td></tr>
>> -------------------------------------^
>>
>>
>> Would it be anything wrong with my gitweb configuration or apache setup?
>
> When I've had errors like that in the past it has been because:
>  a) Firefox installation corrupt; try running with a new profile 
>     (firefox -ProfileManager)
>  b) Firefox has been upgraded but you haven't restarted it since.
>  c) An extension is incompatible with your current version, but doesn't know 
>     it

I've seen another one.

d) gitweb does not like your name (your name is not encoded in
   UTF-8 while gitweb incorrectly assumes it is), and spits out
   malformed output.
