From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Mon, 08 Jun 2009 14:02:49 -0700
Message-ID: <7vzlcixwue.fsf@alter.siamese.dyndns.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	<7vskidcf9s.fsf@alter.siamese.dyndns.org>
	<200906070932.36913.chriscool@tuxfamily.org>
	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	<4A2D337C.70203@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDm0K-0003Wf-9e
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbZFHVCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbZFHVCt
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:02:49 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45253 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbZFHVCs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:02:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608210250.SKSW20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jun 2009 17:02:50 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1Z2p1c00F4aMwMQ03Z2pWB; Mon, 08 Jun 2009 17:02:50 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ZlvubiwuF4QA:10 a=BRJNLUJM0I0A:10
 a=oGMlB6cnAAAA:8 a=OhMQtgWKZHhq0dHswUkA:9 a=DjtSxXsc94ZkkrqloN0IzL6IhnAA:4
 a=CY6gl2JlH4YA:10
X-CM-Score: 0.00
In-Reply-To: <4A2D337C.70203@zytor.com> (H. Peter Anvin's message of "Mon\, 08 Jun 2009 08\:51\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121109>

"H. Peter Anvin" <hpa@zytor.com> writes:

> The advantage of that -- and I have to admit I don't know if it will
> ever matter in practice -- is that using an actual PRNG:
>
> a) is less likely to get into pathological capture behaviors.
> b) doesn't make people think later that there is something magic to the
>    arbitrary chosen numbers.

My gut feeling agrees with you that both are likely to be true; these are
good points.

Christian, what do you think?
