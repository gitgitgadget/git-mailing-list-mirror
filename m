From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] commit::print_summary(): set
 rev_info.always_show_header to 1
Date: Fri, 04 Jun 2010 23:44:34 -0700
Message-ID: <7vljau0yi5.fsf@alter.siamese.dyndns.org>
References: <AANLkTimuTIugURlYxwbk7wGW2IM11YTy4P91YDguLQUb@mail.gmail.com>
 <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <1274974492-4692-4-git-send-email-rctay89@gmail.com>
 <1275639660-5344-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 08:44:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKn7e-0007Va-Do
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 08:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab0FEGom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 02:44:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab0FEGol (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 02:44:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA8B3B91BB;
	Sat,  5 Jun 2010 02:44:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cNnKKbGAs9jDqDisccKUoxHZbQA=; b=PE8TLT
	3Pihuz1wgECVkIhhIjK1jLWSLy4GqYY3J6pSkOVcPx0TXUVCY5fitZZh1A9OTAte
	OqHRdRpbmbmr7tWuCXabv5qmBBcUj3bk+lALG7UDQ/M/f/16RYCX44kpArg0aXNg
	p9aGn1J0N1c1R8Iz3rNH99vIRpTQ1/PaLesWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DjeOZ3c4ae+qdBVLFbxJbiHw8uTXD3AJ
	B9zc6LCRjfpQ7CNHImDDOfdefblRr+NrqPxsIAJAFADwBpH/WUB6n1JzDCgRXVeS
	XJkOD1GCgnJhvBIMPPAbAgHnQ3EKNEYYobSJKacvLIQwg/lz47NRFRa3So/MdnPZ
	Ca4pjUxVJTA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4B9AB91BA;
	Sat,  5 Jun 2010 02:44:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24652B91B9; Sat,  5 Jun
 2010 02:44:35 -0400 (EDT)
In-Reply-To: <1275639660-5344-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Fri\,  4 Jun 2010 16\:21\:00 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CFFF5508-706D-11DF-BDDD-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148458>

Tay Ray Chuan <rctay89@gmail.com> writes:

>  - mention the die() and our assumption that it won't be triggered, as
>    suggested by Junio.

What I meant was to state that in the die() message, not in the commit
log, so that a bug reporter (or preferably people hacking on git that
introduces a regression to trigger this die()) can quickly diagnose what
assumption this new code relies on was violated.
