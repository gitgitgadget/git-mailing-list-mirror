From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: make match_refs() copy src ref before
 assigning  to peer_ref
Date: Mon, 23 Feb 2009 23:12:19 -0800
Message-ID: <7vvdr0l358.fsf@gitster.siamese.dyndns.org>
References: <7vzlgcmsan.fsf@gitster.siamese.dyndns.org>
 <1235448334-36310-1-git-send-email-jaysoffian@gmail.com>
 <7vfxi4mk8n.fsf@gitster.siamese.dyndns.org>
 <76718490902232253o4c7667d9h43f06d81794cef60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 08:14:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbrUJ-0006QU-Bj
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 08:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbZBXHM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 02:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZBXHM2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 02:12:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbZBXHM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 02:12:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 57D1B2BD02;
	Tue, 24 Feb 2009 02:12:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9631E2BD00; Tue,
 24 Feb 2009 02:12:21 -0500 (EST)
In-Reply-To: <76718490902232253o4c7667d9h43f06d81794cef60@mail.gmail.com>
 (Jay Soffian's message of "Tue, 24 Feb 2009 01:53:48 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C413764-0242-11DE-AAEE-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111230>

Jay Soffian <jaysoffian@gmail.com> writes:

> So there is no sane way to free the result.

Yeah, I am not disagreeing that this is a good change to make the function
easier to use.  There is no question about it.

I just found your description a bit unfair to the original author of the
codepath who was probably fully aware of this.

> I sent you a message off-list you may not have read yet.

Yes I have, but I was deep into tonight's integration cycle (I earlier
asked you to check the rebased result when I push it out --- that is what
I've been preparing).  I am almost done, and it will be pushed out
shortly, but it won't have your re-roll.  That will be after 1.6.2-rc2.
