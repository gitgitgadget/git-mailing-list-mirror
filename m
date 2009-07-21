From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix git stash apply
Date: Tue, 21 Jul 2009 13:57:00 -0700
Message-ID: <7v1vo9ah5v.fsf@alter.siamese.dyndns.org>
References: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at>
 <alpine.DEB.1.00.0907212253440.3155@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:57:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTMPD-0007Nt-KL
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbZGUU5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755995AbZGUU5I
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:57:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbZGUU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:57:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 430F2E3D6;
	Tue, 21 Jul 2009 16:57:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9ED20E3D5; Tue,
 21 Jul 2009 16:57:02 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0907212253440.3155@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue\, 21 Jul 2009 22\:56\:29 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C803AA4-7639-11DE-B929-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123717>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 21 Jul 2009, Martin Koegler wrote:
>
>> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
>
> As "git stash" is run through the Git wrapper, which appends the libexec 
> path to PATH, this is no "fix".
>
> Apart from that, it is a nice patch, though, except maybe your leaving 
> only white space between the commit subject and the sign-off: you could 
> have _said_ that this is converting a dashed command to a non-dashed one, 
> instead of sending everybody who is interested enough on a hunt where 
> exactly those two lines differ (was not easy to spot, let me tell you 
> this).

Thanks for a review.  I think the two patches can be squashed into one and
the subject from the second one reflects what is being done more fairly.
It is modernizing the style of the codebase.
