From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Thu, 11 Jun 2009 16:56:07 -0700
Message-ID: <7vocsue354.fsf@alter.siamese.dyndns.org>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	<ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 01:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEu81-0004FV-7h
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 01:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758721AbZFKX4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 19:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbZFKX4H
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 19:56:07 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57281 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbZFKX4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 19:56:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090611235606.WFZO18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 11 Jun 2009 19:56:06 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2nw71c0064aMwMQ04nw7iU; Thu, 11 Jun 2009 19:56:07 -0400
X-VR-Score: -130.00
X-Authority-Analysis: v=1.0 c=1 a=ZkqYN0c8iNwA:10 a=Z2nhhV3jvI0A:10
 a=pGLkceISAAAA:8 a=F6dkZquyb0_Px09vLhsA:9 a=OMl7GAiVcLpi38bYzPpd4lOtfk4A:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com> (Mark Lodato's message of "Thu\, 11 Jun 2009 19\:00\:43 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121378>

Mark Lodato <lodatom@gmail.com> writes:

>> The user is always prompted, even if the certificate is not encrypted.
>> This should be fine; unencrypted certificates are rare and a security
>> risk anyway.

Hmm, "rare" is in the eyes of beholder.  For automated settings, I would
imagine that it is a necessary feature that we need to keep working.  Of
course the local box that keeps an unencrypted certificate used this way
must be well protected to make it _not_ a security risk, but that is not
an issue you are addressing with your patch anyway, so it is not nice to
dismiss possible usability issues like this.

>> I did not create any tests because the existing http.sslcert option has
>> no tests to begin with.

Again, not nice.  Not having tests in this particular patch may be Ok, as
long as you or other people fix that deficiency with follow-up patches,
but please don't be proud that you are following a bad example.
