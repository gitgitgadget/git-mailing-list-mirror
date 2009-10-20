From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pull/fetch rename
Date: Tue, 20 Oct 2009 16:16:05 -0700
Message-ID: <7v3a5dlkqy.fsf@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <200910201359.30880.wjl@icecavern.net>
 <7vpr8hlow9.fsf@alter.siamese.dyndns.org>
 <200910210053.29794.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Wesley J. Landaker" <wjl@icecavern.net>, <git@vger.kernel.org>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 21 01:19:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0NwE-00018z-OQ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 01:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbZJTXQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 19:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbZJTXQN
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 19:16:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbZJTXQM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 19:16:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB7A660F6B;
	Tue, 20 Oct 2009 19:16:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vhlpGGvWLtmm6IM9zlEMaRCscKs=; b=aP/5HD
	Hadc783lFJj8yPN45RwxG87a5ieYBam+UQj25BZf7YN30pC88/mg9M9EhZRPlMdY
	IKX3BEO1skSRzLsnZkDoC/Oj2oIo3S0zrJPc55otEzXAYFdjqxWxIjzH7CJGbT2D
	lu2H6I7+de3e5ES+Z4QZ+xW8nZuTsfjJp/UfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BSc8L6M+qFFRG5m2YX987PDQq7U1d+U5
	gXRyKM4DQrZ0BL3v6a4mbEhZ6nLpQgXDnrT6RSPfZN1NdrQo+PsrUL1KScWA5I88
	2oJxsz4Ad1QyTD5UDQqjqa6qRxaPh7vJEkCfTfycLuY52NbI8CgJGn3Ac1VmR5K8
	mGSZ6NGDSC0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E93860F61;
	Tue, 20 Oct 2009 19:16:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6B8D60F5C; Tue, 20 Oct
 2009 19:16:06 -0400 (EDT)
In-Reply-To: <200910210053.29794.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 21 Oct 2009 00\:53\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8EDEF44A-BDCE-11DE-8094-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130868>

Thomas Rast <trast@student.ethz.ch> writes:

> Well, that reminds me of
>
>   http://thread.gmane.org/gmane.comp.version-control.git/110251
>
> but was not really what I was aiming at.

Actually, if that patch weren't marked as [DRY HUMOR PATCH], and if it did
not have the detachInstead option, I would have at least queued it to
'pu', if not 'next'.
