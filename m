From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How does git follow branch history across a merge commit?
Date: Fri, 28 Aug 2009 16:30:12 -0700
Message-ID: <7vskfbcy9n.fsf@alter.siamese.dyndns.org>
References: <8363c75zug.fsf@torus.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 01:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhAtt-00041e-FM
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 01:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbZH1XaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 19:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbZH1XaY
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 19:30:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZH1XaY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 19:30:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C14F73A773;
	Fri, 28 Aug 2009 19:30:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JUSyj5j25Mo3+2MvLR3cqfSO/qQ=; b=ovE9HA
	KLZxZ5tlcuHiLSqTr6PPHsMiUj7dyTOAdLjkimZXgk13g1OZkNLd7YzmYnliooEs
	7TnVOJghv1MBE6A1M1o3Nlne6VVugKcv0Qr64FGCUkmuLWZKGyP1DeMx3x4hNnkn
	DOI9FyYYbI6qe4NvM6NTfUHf7RmMTyS8/FjZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O+wJVzrVGfT53LLOB3l4xtxnF7z8O2KX
	PozeJomvhCbpsO4FdqLVc00X5l6yJnZ7JvILGfUszoLKybVIg81tHKsNllFbaO5x
	w0vbVd2zzD9T319sTCOkAWBLfsEqCYpVukI06ctLi6+HIHGqJvWLhOeHRujwmPfC
	2s7JTJZ6NfM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A45AC3A76F;
	Fri, 28 Aug 2009 19:30:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 860753A76D; Fri, 28 Aug 2009
 19:30:14 -0400 (EDT)
In-Reply-To: <8363c75zug.fsf@torus.sehlabs.com> (Steven E. Harris's message
 of "Fri\, 28 Aug 2009 18\:37\:59 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C10FEFDC-942A-11DE-B93C-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127362>

"Steven E. Harris" <seh@panix.com> writes:

> Was it just luck that "HEAD^" referred to the predecessor that came from
> branch "master" rather than branch "competition"?

Yes, if you want the second parent you would say HEAD^2.
