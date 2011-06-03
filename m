From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarified how "git submodule add" handles relative
 paths.
Date: Fri, 03 Jun 2011 16:16:34 -0700
Message-ID: <7vhb86a4kt.fsf@alter.siamese.dyndns.org>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org>
 <1306943792-1825-1-git-send-email-marcnarc@xiplink.com>
 <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de>
 <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:16:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSdbn-0003nc-SP
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 01:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab1FCXQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 19:16:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab1FCXQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 19:16:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E57D15B20;
	Fri,  3 Jun 2011 19:18:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IxtTcNDBH+lSQP9WA5YlSgRhZ60=; b=Sat4yY
	k1znXls+5hHopJtv3Y7UJYHFJgz/YMiqc2Ei3Bsw7zBel0m5t8pWLmGOquvVjeEH
	Jrhbzjcm5WGnyCgTiqIaS4UAGaxGIc/UaW5cjpgzrJ+2Lr5IT+6NUG4ViLpCq0TP
	VKL1l9PBD1VoQtxHx5drjruhrK+FrPC7vVaGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dkjCALKrfo4IVBuUe6hNCMh0L0KBD5Ji
	62yeNRbh5X7g6IdXCSZBZ2cOsmP+PLjkinUQ+grz5kXH6cVGOk7vGIx2hcsCuJnp
	WUoZdvTU5es3yI+VXXYcfm8s0hiKU5kAA9+OpscKKP6UsYaMqMxNJi0vUIhxnHfE
	EZoE13rIqGk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A28555B1E;
	Fri,  3 Jun 2011 19:18:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5893E5B1B; Fri,  3 Jun 2011
 19:18:45 -0400 (EDT)
In-Reply-To: <4DE93B29.4030401@web.de> (Jens Lehmann's message of "Fri, 03
 Jun 2011 21:51:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D731B2B0-8E37-11E0-9CCF-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175037>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Now I understand this issue better I'd vote for leaving the relative url
> like it is, comment it better in the man page and give a better error
> message when that happens. After all this issue only surprised a few
> people, mostly due to the lack of information in the error message and
> man page, so I'd rather prefer to not change the behavior but the wording.

The "how about this" patch you are voting against (I am neutral by the
way) is a response to your earlier "I have three use cases and the current
implementation is forgetting the third", which in turn was a response to
my "your third use case does not count, so the updated wording of the
documentation is wrong---it should say 'do not', not 'cannot'".

So what should the updated document say?
