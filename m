From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 01 Nov 2011 13:47:00 -0700
Message-ID: <7vobwvlge3.fsf@alter.siamese.dyndns.org>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
 <7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1110311908240.1930@bonsai2>
 <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com>
 <7vy5vzn65u.fsf@alter.siamese.dyndns.org>
 <CABPQNSaiFpmHa_GLF8PaejvXTkqCMoWG+Cd4MbNrqXF-SXR1yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 01 21:47:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLLEl-0006Cy-TC
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 21:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab1KAUrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 16:47:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab1KAUrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 16:47:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 214816011;
	Tue,  1 Nov 2011 16:47:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5fj2tg50fvzTyTQRMYThsu2vOoI=; b=gVojCa
	FDqt/erAhZoP+N81D4jtKpzu+4KAZ5wjRroD10w+7sW08ixXuoo+hRXqwOnPky0L
	YpChDoldF34/stRW2ByhrWgaVDpvCatphiWMEcXhPRU4IiDjQp7XNzxgOrt/ajzW
	2ziG3jsQ3KeZQBow974C/511SO1dfTK1E2wGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HSNoua23u3tiY+M9DPZ8Akq3bsCdI4UQ
	9r7d+/h89loqHEK0cpzBlLhW55QldMTvNIAaOj3zC31U6B55vEOKnHysbZi6THon
	KnWDAe+j5GoMTPR5lX7KlamUFn1651SD6vyFPknn03INPE6717QV2pV14yBHwBGB
	G5U1FTY3uAQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 181C16010;
	Tue,  1 Nov 2011 16:47:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F5A6600E; Tue,  1 Nov 2011
 16:47:01 -0400 (EDT)
In-Reply-To: <CABPQNSaiFpmHa_GLF8PaejvXTkqCMoWG+Cd4MbNrqXF-SXR1yw@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 1 Nov 2011 21:35:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6C4C8CE-04CA-11E1-8F9E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184591>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> It seems, from your description, that msvc update series has some way to
>> go and it probably is better to be cooked by Windows-savvy folks for
>> another cycle.
>
> I don't think you need to hold these three patches; with them I was
> able to build your 'master'. I believe the problems I bumped into only
> exist in msysgit's 'devel' (or in your 'next', which msysgit/devel is
> based upon).

Ok, then. Thanks for clarifying.
