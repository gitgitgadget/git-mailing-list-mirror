From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 11:56:24 -0800
Message-ID: <7vd2zlp6zb.fsf@alter.siamese.dyndns.org>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <CAMP44s3yVtQ4wGqVTyHN-VfAM7iRo9WfNnAu+ns7Zkc_cPBH3g@mail.gmail.com>
 <20121110003331.GA12567@sigill.intra.peff.net>
 <20121110123250.GR12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:56:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXHAZ-0000sJ-MV
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab2KJT43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 14:56:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099Ab2KJT43 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 14:56:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 631AA8A68;
	Sat, 10 Nov 2012 14:56:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v2gEOxZ7wSI0
	3SBGYiuEp0dSG+k=; b=b6MNEDkPN56H4k8sZ/CsNcYZ36Tz6QDQW/JvnuJa5QH3
	P0Cb5UGRzbR1hZQAkH32PNKVkWkXdManwAAZ8HmAya4iJvtiRtIX3jGx8YlQ/NJ9
	GUqbGJUdPh60Pa87gy3Ppbik53NFQIE0Ol0ie1rTuvYIScGuK22QeSSymY7KcKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fU35qv
	PsEE3o2Vps1ZcqbnlHd0ESDgzZEwTQ71+gFV83DvnkFIPYn5uSwiVU34RZihYHEG
	pbRAL4ojldqLTqo4HLX05wAi1nTVj1pgiq9GO5K4IHEqXrnNk70iN3oxsAchzL8/
	pYlD6T9qnhaDDLNsd9+bBh8TQr/ZOeS5sOCXQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EEEF8A67;
	Sat, 10 Nov 2012 14:56:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABF688A66; Sat, 10 Nov 2012
 14:56:27 -0500 (EST)
In-Reply-To: <20121110123250.GR12052@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Sat, 10 Nov 2012 13:32:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6D3F5AA-2B70-11E2-8ED6-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209302>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> I think it is better to keep the tests simple and maintainable.
>
> Maintainable?  There is nothing to maintain here....
> ...
> OTOH, this series has some serious drawbacks.
>
> It makes debugging more difficult....

Are these referring to the same aspect of the series?  The concern
you described about debuggability matches my impression IIRC back
when I took a look at the series, which I would count as a large
part of keeping tests maintainable.

But you may be referring to something different (sorry, not on my
primary machine yet).
