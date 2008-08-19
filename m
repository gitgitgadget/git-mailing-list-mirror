From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/9] Narrow/Sparse checkout round 3:
Date: Tue, 19 Aug 2008 02:06:33 -0700
Message-ID: <7viqtxcr1i.fsf@gitster.siamese.dyndns.org>
References: <20080815142439.GA10609@laptop>
 <7v1w0pdze0.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0808162212y756465a5ib7ce3a8849765033@mail.gmail.com>
 <7vbpzs9om7.fsf@gitster.siamese.dyndns.org>
 <7v3al49nos.fsf@gitster.siamese.dyndns.org>
 <loom.20080817T094637-285@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 11:10:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVNBz-0004Sg-IM
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 11:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYHSJGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 05:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYHSJGv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 05:06:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYHSJGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 05:06:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 043FF5A74D;
	Tue, 19 Aug 2008 05:06:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5DE315A74C; Tue, 19 Aug 2008 05:06:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 273D691C-6DCE-11DD-A247-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92840>

Eric Raible <raible@gmail.com> writes:

> s/but we would need to have/but we may need/
> in the commit message?

Yeah, strictly speaking, perhaps.

One thing that I refuse to believe is we will need only one more bit and
after assigning the 0x4000 bit to whatever that single purpose the index
will stay that way forever.  So we would need to reserve that bit as the
extension bit in any case.  If we do not have any extension forever, that
means any index entry with the bit set is corrupt, so erroring out would
be the right thing to do anyway ;-).
