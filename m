From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] split_ident: parse timestamp from end of line
Date: Tue, 15 Oct 2013 11:48:47 -0700
Message-ID: <xmqqeh7me5f4.fsf@gitster.dls.corp.google.com>
References: <20131014202734.GA7007@sigill.intra.peff.net>
	<xmqqwqlfebhi.fsf@gitster.dls.corp.google.com>
	<20131014223137.GA12744@sigill.intra.peff.net>
	<xmqqsiw3eajt.fsf@gitster.dls.corp.google.com>
	<20131014232949.GA10415@sigill.intra.peff.net>
	<xmqqob6qe808.fsf@gitster.dls.corp.google.com>
	<20131015180312.GA26845@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 20:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW9go-0004CQ-JA
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 20:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933611Ab3JOStu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 14:49:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932760Ab3JOSto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 14:49:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90A404A353;
	Tue, 15 Oct 2013 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FFACzFMzGrs/EAqv3ZXxz6zsM9c=; b=g7cmPE
	D3yyFswY8rd4sM07NjvjEXS4nZTJQnLSzg8ERuUtgyPhwv2MtxtL0zug/RcRdSz2
	Gi0ZBPDi20GERHopCGm41r67FQJbn+mxd3Q2k0UpYmCDb+MueMlswpHUpUSsnegH
	t66/IyamSj5d+a5kNxiZileXWeBG3U26t8b2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=og01f3+m+hqJZpGeh6XcYJ+05n7tuSZz
	/hz1RZLsHoTZCQwUAlEw4HdMuLOaV4lLMqSrDWF4RxuPsshBA3PHxD+GJEDFJLe1
	zCTieoc92FGNdJh/I2D+BV5OpZy/ssQrNPh/LdsVQ5IVtsX6edBOa2icASwz1EXD
	1comCJKlm00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 340DB4A320;
	Tue, 15 Oct 2013 18:49:25 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CDD64A271;
	Tue, 15 Oct 2013 18:48:52 +0000 (UTC)
In-Reply-To: <20131015180312.GA26845@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Oct 2013 14:03:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A8A78B6-35CA-11E3-A35A-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236193>

Jeff King <peff@peff.net> writes:

> My version seems a little clearer to me, but that is probably because I
> wrote it. If you strongly prefer the other, feel free to mark up my
> patch.

I do not have strong preference either way. Just that I thought two
loops would be shorter and easier to understand than three, that's
all.
