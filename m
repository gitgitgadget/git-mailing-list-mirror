From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] builtin-log: Add options to --coverletter
Date: Fri, 15 May 2009 19:30:29 -0700
Message-ID: <7v63g1srsq.fsf@alter.siamese.dyndns.org>
References: <1242349041.646.8.camel@Joe-Laptop.home>
	<7v63g2tewu.fsf@alter.siamese.dyndns.org>
	<1242418762.3373.90.camel@Joe-Laptop.home>
	<7vljoyrq4z.fsf@alter.siamese.dyndns.org>
	<1242425263.31337.17.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat May 16 04:30:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M59fb-0005MA-1h
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 04:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbZEPCab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 22:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbZEPCa3
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 22:30:29 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60271 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbZEPCa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 22:30:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516023029.HVRE20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 May 2009 22:30:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id s2WW1b0014aMwMQ042WW1U; Fri, 15 May 2009 22:30:30 -0400
X-Authority-Analysis: v=1.0 c=1 a=80QVIHGmj5cA:10 a=52mTYfW24d0A:10
 a=IJv9LcIfAAAA:8 a=gCUmrezajv4ag3fWNSYA:9 a=p_Zqg2aWcgXf15QfnEx91or51XIA:4
 a=K6kUPx8HyhEA:10
X-CM-Score: 0.00
In-Reply-To: <1242425263.31337.17.camel@Joe-Laptop.home> (Joe Perches's message of "Fri\, 15 May 2009 15\:07\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119318>

Joe Perches <joe@perches.com> writes:

>> > +static int coverletter_wrap = 1;
>> 
>> Do not change the default behaviour before people agree it is a good
>> feature;
>
> This doesn't change the default behavior.
> The default is still wrap enabled.

You are correct; my mistake.

> Prefixing "no-" to git arguments seems widely used.
>
> Perhaps:
>   --no-cover-letter-wrap

Again you are right; it looks much better.
