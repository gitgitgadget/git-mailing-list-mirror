From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: no [--merge|--rebase] when newly cloned
Date: Wed, 16 Feb 2011 13:41:04 -0800
Message-ID: <7v7hczirnz.fsf@alter.siamese.dyndns.org>
References: <1297860417-21895-1-git-send-email-olsonse@umich.edu>
 <7v62sjkbbi.fsf@alter.siamese.dyndns.org> <4D5C2F33.8020309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Spencer E. Olson" <olsonse@umich.edu>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:41:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppp7i-0001WM-2r
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab1BPVlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 16:41:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab1BPVlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 16:41:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC5024540;
	Wed, 16 Feb 2011 16:42:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MpDILHuN8/KI4nbjtj6pTCAyeaM=; b=RG2be+
	c014bxMf3Oa6gg9sVtVBaTYS7fsArsCxazddTkM8JAe5lPyKtjURE9wbGIJviUAo
	ykpg0piZyljlLVEG9EFvM2KLLtMqC3CLAKXipii031yhkpxktcu4dbjGoBcd1OJJ
	ODs4BMuEPYJqrrK+coAR+v7UPdW52W9FB0RdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VxWAEjRCAAUbVAO/C2LlbxfeyyYjQT/z
	3sjHZUh0zbYhVG8GCD28ANPOtwFXQehJi5N1dcJCV4bKmSCz4GlpfLh0jn+vPZmF
	CjwVZ1mvlDjLcuMZjI54cjumx8rtANkRizJgYt2lqEmfa4k6onJG4kAWZLdu6QMe
	d6wv2MUkey0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA067453F;
	Wed, 16 Feb 2011 16:42:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5F4A8453B; Wed, 16 Feb 2011
 16:42:11 -0500 (EST)
In-Reply-To: <4D5C2F33.8020309@web.de> (Jens Lehmann's message of "Wed\, 16
 Feb 2011 21\:10\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9EF258A8-3A15-11E0-AB21-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167006>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> So this looks like a worthwhile fix. The commit message and POSIX issue
> need to be addressed, tests would be a good thing to add too, but apart
> from that it looks sane.

Thanks for a translation ;-).  I agree everthing you said above.
