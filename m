From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: Add an option to show size of blobs in the tree view
Date: Wed, 01 Aug 2007 22:22:09 -0700
Message-ID: <7vtzri1pfi.fsf@assigned-by-dhcp.cox.net>
References: <1185880790812-git-send-email-jnareb@gmail.com>
	<200708011505.02078.jnareb@gmail.com>
	<7v3az24zo6.fsf@assigned-by-dhcp.cox.net>
	<200708020158.50343.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 07:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGT8d-0006qR-R0
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 07:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbXHBFWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 01:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbXHBFWM
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 01:22:12 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44789 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbXHBFWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 01:22:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802052212.HYOI7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 01:22:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WtNA1X0081kojtg0000000; Thu, 02 Aug 2007 01:22:10 -0400
In-Reply-To: <200708020158.50343.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 2 Aug 2007 01:58:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54514>

Jakub Narebski <jnareb@gmail.com> writes:

>>> P.S. I have received no comments on
>>>  [RFC/PATCH] gitweb: Enable transparent compression for HTTP output
>>> (trade CPU load for lower bandwidth usage).
>> 
>> That's probably nobody was interested in it.
>
> Well, it was also posted in the middle of old thread... 

There probably is some of that as well.

Personally, this late in the game, I would be more interested in
resolving the File::Find() stuff, which has been a real issue in
the field, than the compressed transfer one.
