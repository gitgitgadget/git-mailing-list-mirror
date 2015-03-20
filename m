From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Fri, 20 Mar 2015 11:33:46 -0700
Message-ID: <xmqqlhirecxh.fsf@gitster.dls.corp.google.com>
References: <20150320100429.GA17354@peff.net>
	<xmqqegojftsj.fsf@gitster.dls.corp.google.com>
	<xmqq384zft22.fsf@gitster.dls.corp.google.com>
	<20150320180448.GC11844@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:34:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1k6-0002Wy-HI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbbCTSdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:33:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750821AbbCTSdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:33:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C58541531;
	Fri, 20 Mar 2015 14:33:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q/BFI0Cp//Y41ZA4VMKzckmkxkk=; b=BOhysh
	amxZmJXgRI8H+yqF/DU+gfk7M92L2rxrZbIeZYZQ4UPDgH9Fh0ZX8dZDsQekjMDa
	xDqkzvi0bv60PtA7R/qViJ3tCtgEiYY+/uhOffL28A08SIdayGzMC+v5eAugsYaX
	xsvZ7ieYaoyTNyoYifX9dpPVhi34PG2aZ9w1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bavpfUF6Yv2e4ZSleU/Fwn2Ead8YukW+
	tJZ7raC+6BFena0H0K1yKpa7M5jmDs2iY+VNArxgP/E/KHXm4iYMMTdzn1Be9WZ8
	gaP7ArbgyvLwIL0QMAIrKmYHd1cpRoEYxhgqiVcJYgwEDpTL5yN/E7yEHBEQlg8v
	B2SfmnLj6jw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01FE441530;
	Fri, 20 Mar 2015 14:33:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FD644152F;
	Fri, 20 Mar 2015 14:33:47 -0400 (EDT)
In-Reply-To: <20150320180448.GC11844@peff.net> (Jeff King's message of "Fri,
	20 Mar 2015 14:04:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A585B1B6-CF2F-11E4-9026-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265931>

Jeff King <peff@peff.net> writes:

> I'm actually about to send out a re-roll of that, as I think all of the
> review comments have been addressed.

Thanks.
