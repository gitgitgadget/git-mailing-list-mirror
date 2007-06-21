From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 01:07:42 -0700
Message-ID: <7vtzt1ybld.fsf@assigned-by-dhcp.pobox.com>
References: <20070621030622.GD8477@spearce.org>
	<7vsl8m3sph.fsf@assigned-by-dhcp.pobox.com>
	<200706210900.49702.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	govindsalinas <govindsalinas@yahoo.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 10:07:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Hhl-0007Z9-Na
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 10:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbXFUIHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 04:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbXFUIHp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 04:07:45 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63455 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbXFUIHo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 04:07:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621080745.LZED17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 04:07:45 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E87j1X0021kojtg0000000; Thu, 21 Jun 2007 04:07:43 -0400
In-Reply-To: <200706210900.49702.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 21 Jun 2007 09:00:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50607>

Andy Parkins <andyparkins@gmail.com> writes:

> On Thursday 2007 June 21, Junio C Hamano wrote:
>
>> Having many "identical files" in the preimage is just stupid to
>> begin with (if you know they are identical, why are you storing
>> copies, instead of your build procedure to reuse the same file),
>> so the algorithm did not bother finding a better match among
>> "equals".
>
> That's a really poor argument; it's not git's place to impose restrictions on 
> what is stored in it.

It's not even an argument, nor an attempt to justify it.  It was
just an explanation of historical fact "It did not bother".
Please re-read the final part of the message, which you omitted
from your quote.
