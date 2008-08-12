From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make cherry-pick use rerere for conflict resolution.
Date: Mon, 11 Aug 2008 23:59:26 -0700
Message-ID: <7vy732ra5t.fsf@gitster.siamese.dyndns.org>
References: <1218368935-31124-1-git-send-email-ams@toroid.org>
 <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080811023053.GA9144@toroid.org>
 <7vmyjjxuca.fsf@gitster.siamese.dyndns.org>
 <20080812023411.GA14831@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 09:00:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSnrx-000441-Vn
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 09:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbYHLG7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 02:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbYHLG7f
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 02:59:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbYHLG7f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 02:59:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3074B56F2C;
	Tue, 12 Aug 2008 02:59:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 48AF056F2B; Tue, 12 Aug 2008 02:59:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 370CB9CA-683C-11DD-B12C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92072>

Abhijit Menon-Sen <ams@toroid.org> writes:

> At 2008-08-11 11:47:01 -0700, gitster@pobox.com wrote:
>>
>> I do not think that story is a good example.
>
> I agree, it's a stretch.
>
> I can't think of any better rationale for the change than "It might
> conceivably be convenient to someone at some point", which falls a
> fair bit short of being convincing.
>
> To be honest, it took so little time to implement this suggestion that
> I didn't realise until later that there was no realistic use-case and
> nothing to say about the patch.

Oh, that's Ok.  I think my "cherry-picking from devel to maint1 and then
cherry-picking the same change to maint2" example already shows the
potential usefulness of the patch.  Yes, cherry-picking the change from
maint1 would avoid conflicts, but we do not _have to_ force the user to
think about it.  If the user somehow chose to cherry-pick from devel to
maint2, it is certainly better if we allowed the earlier resolution
applied.

In any case, thanks for the patch --- queued in 'pu' for now.
