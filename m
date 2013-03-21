From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] do not use GIT_TRACE_PACKET=3 in tests
Date: Thu, 21 Mar 2013 08:04:06 -0700
Message-ID: <7vli9gbxqx.fsf@alter.siamese.dyndns.org>
References: <20130320172640.GC10752@sigill.intra.peff.net>
 <20130320174347.GA28548@sigill.intra.peff.net>
 <514AAA5D.4000803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 16:04:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIh2k-0002bb-Ty
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 16:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab3CUPEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 11:04:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46065 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab3CUPEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 11:04:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2811BACDD;
	Thu, 21 Mar 2013 11:04:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GMUH9f+2NpbNa754baT8jmNOKzw=; b=LEfHTE
	+XqkG3kdHn+uffHVssLy5Vza/Gi1oVA/BzIveo5UJqBaR32gVdAyxOlHgjGPSTJE
	p6uVBzmebMxme5Jl1mVZ3P8PFU1uxtRWRV7OYrQt5EbRmR0KLbdEu1j7f0AkCX0y
	9GTQQ3xD3eob9l8rHFWhIjKGFNMiBT+59s4pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dA/juXkSNuY2JyEkxqiF3xASbcrbLTEV
	L/eW2MSfeAxlKyAI/Iv+gKB6WxKMbGl97+Zi8GDJdqq3lWvoAf4Y/eD746QVlCo8
	nxS4BlwuwY4PUJdMsajwMahCQs6xIpsy8jsrDQS/2Hd72XUamWqBvnpeAgWBQ19N
	bH74OzLyLCE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B2E7ACDC;
	Thu, 21 Mar 2013 11:04:09 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EBD4ACD8; Thu, 21 Mar 2013
 11:04:08 -0400 (EDT)
In-Reply-To: <514AAA5D.4000803@viscovery.net> (Johannes Sixt's message of
 "Thu, 21 Mar 2013 07:36:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94BF96AC-9238-11E2-A3C2-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218732>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 3/20/2013 18:43, schrieb Jeff King:
>> Now that we are using the GIT_TRACE mechanism, we can
>> improve both scripts by asking git to write directly to a
>> file rather than a descriptor. That fixes the hang in t5700,
>> and should allow t5503 to successfully run on Windows.
>
> Well spotted, and, right, both tests pass with this patch.
>
> Tested-by: Johannes Sixt <j6t@kdbg.org>

Thanks.
