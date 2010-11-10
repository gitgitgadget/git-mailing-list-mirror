From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t/t7004-tag: test handling of rfc1991 signatures
Date: Tue, 09 Nov 2010 16:19:47 -0800
Message-ID: <7vhbfqjaho.fsf@alter.siamese.dyndns.org>
References: <4CAB90EC.1080302@drmicha.warpmail.net>
 <cover.1289041051.git.git@drmicha.warpmail.net>
 <c20fb62cefcd42533e47f6f1bf5817712e5ebf9a.1289041051.git.git@drmicha.warpmail.net> <7vwrommn6j.fsf@alter.siamese.dyndns.org> <4CD9839B.6060406@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 10 01:20:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFyPx-00011M-Rl
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 01:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385Ab0KJAT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 19:19:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab0KJAT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 19:19:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 657BA3D21;
	Tue,  9 Nov 2010 19:20:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YF0Wn7Ck3biH3pSKp8ZUBDkCKWc=; b=CzqS2U
	4grTwAA2pIFMcGz4hq8qOOhxu/wbO77kDnv8OQd2GQW4pVh+r6j7K7NqgtPQMKaa
	B/EEnYhDYIvs3eyOlS/u+nQ+D3CoRhRUONmMAZh+7UVeHAX5VDHyyQOVRJf48utx
	cYmiEamPg31B0E8HOukPoJQH6Ugel5patgET4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+zST5zFmiuBGTN1PgDzWcYu6zZTfb10
	5WMcj13Q7tiebQkmBx5Sg/Dqvjo/pUHLdtPC/baT287YYLltlTSg927IwFUM3e6z
	cQU8pA1/UCBoln2PxyRRdJQuYp4CC5bZExaih/AQ3n0pPTQxWfpHv+1exBsGoolg
	3ndPdnvVQPI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33BC23D1B;
	Tue,  9 Nov 2010 19:19:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9907E3D14; Tue,  9 Nov 2010
 19:19:52 -0500 (EST)
In-Reply-To: <4CD9839B.6060406@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue\, 09 Nov 2010 18\:23\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F8E540A-EC60-11DF-B79B-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161112>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The --rfc1991 option matters for the creation of signatures only, not
> for the verification (and neither for display/listing with git, of course).

Doesn't the above statement assume a bit too much about how the current
version of gpg behaves, I have to wonder?
