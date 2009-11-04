From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker
 when options are patch and a stat
Date: Wed, 04 Nov 2009 10:10:01 -0800
Message-ID: <7vy6mmgo06.fsf@alter.siamese.dyndns.org>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com>
 <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
 <20091104063612.GA24263@coredump.intra.peff.net>
 <20091104071053.GB24263@coredump.intra.peff.net>
 <20091104071940.GA15011@coredump.intra.peff.net> <4AF12EC5.4030407@gmail.com>
 <20091104073731.GA15408@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	=?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Gustavsson 
	<bgustavsson@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:10:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kJN-0000JI-5d
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbZKDSKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbZKDSKJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:10:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbZKDSKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:10:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D13B092B5D;
	Wed,  4 Nov 2009 13:10:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ebl/PLc62bVCRG6YmtypDoGTxHY=; b=pgZBJ0
	7PvzkYwI1U3G7ukIZTYDQoViUbS1tStrOm3ZSjL3hTyB62XMRDWf3fy2iyHxhTIp
	nmSsBP7uhdQLIpeIov4WtxiGrB18trVSYB6EeJbfs7b4V74RdVFb1j9pOAKkBLp+
	LNj7mfSgtgoXJle3p+0j0L2S755d97vmLIWz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wL5uuGFTyF6xdieQWex4fKqZc+gcAcRW
	iFnqjU4vsvEKwLRbMt5e3LzbeYu4WHzo/l4e19ajNwaE6RY3NsG0lwTsyOLI8Zki
	wJ/KX0NE06CUwRZGSC+Ev01hug0WBjLtwKjdw53g8ahVACzzcybLMCDNIYiQvcwB
	R7y0+mbgu2g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9340D92B59;
	Wed,  4 Nov 2009 13:10:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D8F7C92B58; Wed,  4 Nov 2009
 13:10:02 -0500 (EST)
In-Reply-To: <20091104073731.GA15408@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 4 Nov 2009 02\:37\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 49458214-C96D-11DE-A497-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132109>

Jeff King <peff@peff.net> writes:

>> I don't imagine we want this option in the messaging group though.
>> Can you move it up?
>
> Thanks, good catch. I just tacked it onto the end, forgetting that we
> were using grouping. Junio, can you tweak it, or do you want a resend?

Just ater "no-binary" would be a good place for this to go; done.
