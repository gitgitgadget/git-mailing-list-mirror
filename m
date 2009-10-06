From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 06 Oct 2009 13:09:07 -0700
Message-ID: <7viqesz3mk.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <20091005225611.GB29335@coredump.intra.peff.net>
 <200910060932.24377.trast@student.ethz.ch>
 <alpine.DEB.1.00.0910061112570.4985@pacific.mpi-cbg.de>
 <7vvdis21qk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910061359560.4686@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 22:14:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvGQ6-0000ap-4Z
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 22:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbZJFUKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932951AbZJFUKF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 16:10:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933048AbZJFUKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 16:10:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 368F44E812;
	Tue,  6 Oct 2009 16:09:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TH8ENklHsCE0Vtwg0R8TQUy0b+k=; b=TtVCuM
	0bCp7LgBHTZ5jzPR7dYGDu+tBRNZbqTO3yrJWWrS54VB4c7aC9dWQPXlF9fCYu8r
	rmMY2WMXvOjsuk0Fq1Mh2uupLL2PbVSzRlexI24xRkFmOSEhAcpfrvtr3kQRuu7g
	eJ0kTSPnApxAm68oGFT20S8Emue6Pq1IUdHmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R3HMDMHANwsD5spJ1icaDMKKJ7Bi/Et+
	+Q2xkgQYGTSrjQqzij6UPuKq88cUkHNHXR20sxGxx9S8SejEOQVWSc0md2uVNGMg
	3cJJ4pUoJH0ob1Y3DoyjjfmdgsweSdsM9cpEoVw2uv21xCMiu7AMmWh8AOHDXzFV
	5dwYJuXrsxc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6C2C4E810;
	Tue,  6 Oct 2009 16:09:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13CC64E80F; Tue,  6 Oct
 2009 16:09:08 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910061359560.4686@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Tue\, 6 Oct 2009 14\:02\:41 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1ED9EA8A-B2B4-11DE-B6BE-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129634>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I'll stop wasting my time with this discussion.

I do not think it was a waste of time; earlier you said that you were not
proposing to include a patch that does that DWIMery, and we need to
discuss the downsides and upsides until we can figure out if it does more
good than harm.

And I think we reasonably established that this does more harm than good,
so I am Ok if you want to stop here.
