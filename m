From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RF sanity check] send-email threading fixes
Date: Thu, 11 Jun 2009 16:21:08 -0700
Message-ID: <7vd49afjbv.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<200906111849.40232.markus.heidelberg@web.de>
	<7vprdah5es.fsf@alter.siamese.dyndns.org>
	<200906120049.02368.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Jun 12 01:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEta7-0002rZ-CT
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 01:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762608AbZFKXVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 19:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762258AbZFKXVH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 19:21:07 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37412 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762631AbZFKXVG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 19:21:06 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090611232109.SOWX20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Thu, 11 Jun 2009 19:21:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 2nM81c0064aMwMQ04nM8G4; Thu, 11 Jun 2009 19:21:08 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=rGcsWzy2ZY0A:10 a=aX3-ONhlG_4A:10
 a=yoxlLVvDPRFdmVEh9YsA:9 a=CsQuvfojHVK7mGxnULgIjuHmpW4A:4 a=5KVauyKsRKMA:10
X-CM-Score: 0.00
In-Reply-To: <200906120049.02368.markus.heidelberg@web.de> (Markus Heidelberg's message of "Fri\, 12 Jun 2009 00\:49\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121374>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> HTH and I got everything explained correctly.

Now, you can summarize the series with a proper [0/6], perhaps modelling
after how I explained the order of application and merge structure ;-).
