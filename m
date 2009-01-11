From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 14:25:34 -0800
Message-ID: <7v63klpjj5.fsf@gitster.siamese.dyndns.org>
References: <1231699002-5316-1-git-send-email-barvik@broadpark.no>
 <alpine.DEB.1.00.0901111944360.3586@pacific.mpi-cbg.de>
 <86iqol8wql.fsf@broadpark.no>
 <alpine.DEB.1.00.0901112044230.3586@pacific.mpi-cbg.de>
 <86eiz98v0s.fsf@broadpark.no>
 <alpine.DEB.1.00.0901112112540.3586@pacific.mpi-cbg.de>
 <86ab9x8t4a.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:27:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8ls-0005bP-Qx
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbZAKWZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZAKWZl
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:25:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZAKWZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:25:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 575F38F133;
	Sun, 11 Jan 2009 17:25:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 834048F12F; Sun,
 11 Jan 2009 17:25:36 -0500 (EST)
In-Reply-To: <86ab9x8t4a.fsf@broadpark.no> (Kjetil Barvik's message of "Sun,
 11 Jan 2009 21:50:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C70A8222-E02E-11DD-AA87-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105240>

Kjetil Barvik <barvik@broadpark.no> writes:

>   And the 'a' and the 'd' in the DCO I do agree with in this particular
>   situation, so I added a '--signoff' to the patches.

I think Dscho's suggestion was to sign-off when you commit, not when you
format-patch.  It won't make any difference either way to me nor other
people who reads the list, because nobody can tell which way you used by
looking at your e-mail, but it is a good habit to get into if you work on
git or the kernel.
