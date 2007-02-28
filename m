From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Make 'cvs ci' lockless in git-cvsserver by using git-update-ref
Date: Wed, 28 Feb 2007 10:06:26 -0800
Message-ID: <7v1wka2m3h.fsf@assigned-by-dhcp.cox.net>
References: <200702210908.59579.andyparkins@gmail.com>
	<200702271248.59652.andyparkins@gmail.com>
	<7v1wkbb1yf.fsf@assigned-by-dhcp.cox.net>
	<200702280844.45949.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 19:06:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMTCB-000467-Ts
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbXB1SG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbXB1SG3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:06:29 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:63803 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbXB1SG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:06:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070228180628.RHEE233.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 28 Feb 2007 13:06:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id V66T1W00A1kojtg0000000; Wed, 28 Feb 2007 13:06:27 -0500
In-Reply-To: <200702280844.45949.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 28 Feb 2007 08:44:44 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40980>

Andy Parkins <andyparkins@gmail.com> writes:

> On Tuesday 2007 February 27 23:44, Junio C Hamano wrote:
>
>> The extra one was introduced by a later patch to honor the
>> update hook since I wrote the original patch you forward ported.
>
> Apologies.  I must have applied your patch in the wrong place on my branch.  
> It did seem unlikely that you would have made a mistake.

Apologies if I sounded I was complaining -- not at all.
I was _thanking_ you for the forward porting of my patch so I
did not have to do that ;-).
