From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 03 Feb 2009 11:02:48 -0800
Message-ID: <7vy6wn9wdj.fsf@gitster.siamese.dyndns.org>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com>
 <7vocxqf2sf.fsf@gitster.siamese.dyndns.org>
 <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com>
 <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com>
 <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302>
 <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com>
 <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302>
 <5FE034E8-422F-4692-AD37-5633C91A4B98@silverinsanity.com>
 <alpine.DEB.1.00.0902031918520.9822@pacific.mpi-cbg.de>
 <34FE2049-0A81-4615-AE3D-46DE35A44011@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 20:04:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUQZL-0008Rd-Mt
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 20:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZBCTC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 14:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbZBCTC5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 14:02:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZBCTC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 14:02:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F3AE96725;
	Tue,  3 Feb 2009 14:02:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2094996724; Tue,
  3 Feb 2009 14:02:50 -0500 (EST)
In-Reply-To: <34FE2049-0A81-4615-AE3D-46DE35A44011@silverinsanity.com> (Brian
 Gernhardt's message of "Tue, 3 Feb 2009 13:42:03 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43C448D6-F225-11DD-9EAF-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108240>

Brian Gernhardt <benji@silverinsanity.com> writes:

> I was irritated by your statement that I "did not look far" because _I
> read all those files_.  I gave you the result of reading them which
> you seem to have completely ignored, as it was the part of my last e-
> mail that you did not quote.
>
> If you want to double-check me, fine.  But do not claim I did not do
> the work.

Thanks, both, and let's not be unnecessarily un-nice to each other.

I agree that Dscho's "far enough" comment was not the best way to say "I
really want to make sure you did verify the way I would myself", but
please just let it pass, pretend that he just expressed frustration on his
lack of time to do the verification himself with that comment.  Ok?

The thing is, nobody active in git land is paid to work on git.  You
don't, Dscho doesn't and I neither.

I'll try to find time myself to triple check if you two want to, even
though it is known that I often get tripped by the same kind of
brain-slippage as Dscho when Dscho does get tripped, so my auditing might
not add much to the collective confidence level ;-).
