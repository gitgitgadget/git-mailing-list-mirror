From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #09; Mon, 29)
Date: Mon, 05 Aug 2013 09:29:49 -0700
Message-ID: <7viozkm77m.fsf@alter.siamese.dyndns.org>
References: <7vk3k9yol3.fsf@alter.siamese.dyndns.org>
	<51F94DFD.5020101@ramsay1.demon.co.uk>
	<7v4nbav9ys.fsf@alter.siamese.dyndns.org>
	<51FACA67.8090207@ramsay1.demon.co.uk>
	<7vtxj9qfnm.fsf@alter.siamese.dyndns.org> <51FD07A6.9040902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	tboegi@web.de, mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Mark Levedahl <mlevedahl@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershaus?= =?utf-8?Q?en?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:30:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NfV-00082m-Bu
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab3HEQ3z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Aug 2013 12:29:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014Ab3HEQ3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Aug 2013 12:29:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E02E3690B;
	Mon,  5 Aug 2013 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7LB8x74u5GtM
	UVT5ppi2K1gTZoE=; b=IxHQO7rLkqNYbMARjRA+U2SlovQkHJRsEv6HmuYyIx83
	lzxnFJn2iJ+zW/Se648MyavacKSmusG2sk4oc77toiCeVmqzA3xJfWZB1PFvXvkH
	RwK43Z8GtW9IGGqvSfhD33nRShBAfy2VGPdADQtpwJ8I9XAx3BAspv4NPH1dOLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=M5ADY4
	wF3wjMY4BNl23QdnXIT9H6yCZshsQtRPiqbRYufUUgdqzWC/6I/yZrBMOV8OLgRm
	Gwb2MB7DfER7GN8Qrj1hvt++6C6reJWkEc3lPRsXKEF/zh/8IdWQhZfepJMbrrbK
	kWtx01USFj6fth2t3hTYRUpXEGb3L/S5N390M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E82813690A;
	Mon,  5 Aug 2013 16:29:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 319DF36907;
	Mon,  5 Aug 2013 16:29:51 +0000 (UTC)
In-Reply-To: <51FD07A6.9040902@gmail.com> (Mark Levedahl's message of "Sat, 03
	Aug 2013 09:37:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40A89D5A-FDEC-11E2-98AD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231673>

Mark Levedahl <mlevedahl@gmail.com> writes:

> I have been using this patch since Ramsey first sent it, have noticed
> no trouble over that time but all of my work is with filemode=3Dtrue
> (has been since I started using git as Cygwin is a secondary platform
> for me and interoperability with repos on Linux is an absolute
> requirement).

Torsten B=C3=B6gershausen writes:

> So I think we can and should remove compat/cygwin.[ch] without furthe=
r
> cooking, to be on the save side.

Thanks.
