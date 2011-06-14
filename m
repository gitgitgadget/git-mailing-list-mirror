From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 13 Jun 2011 21:41:10 -0700
Message-ID: <7vtybtm3dl.fsf@alter.siamese.dyndns.org>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
 <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
 <4DF0EC32.40001@gmail.com>
 <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
 <20110609162604.GC25885@sigill.intra.peff.net>
 <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com>
 <4DF6A8B6.9030301@op5.se> <20110614003029.GA31447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 06:44:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWLUK-0005W5-Vs
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 06:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab1FNEla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 00:41:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab1FNEl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 00:41:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5037D598E;
	Tue, 14 Jun 2011 00:43:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nfaknDGUD7M6UybT+ro6s+bGreE=; b=RbGEwr
	slXzdKzZdcAR+lzCoidhX5f056YGzLE15O2e/YY4oX1oHYeb6BgkcHwObp36Pa2u
	GoJOjdbEggW2frXgtNLuQJEl3cubPTkso734zp5/KNctbzP7kKrp/FYgVxp+xV/O
	q5tCjPMJUTEIfdFDEBxooQOqnIhvhbDmyB/3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JLUWG3s6Pix7RsgPZ33OZ9t0gWcEokyJ
	W3AbyycBMa/YgF9YfEpnOPdobO+W6PBoe7b7dIARhz7Y7DfnRADOsUpFBPeP6aHB
	WxMb64xVLLXp2mznbunjeTejs/4LASRx81IHYpMCNauEmoBNmXACs+hjPuISPHmp
	CW7PvuHQ2mA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEAFD5989;
	Tue, 14 Jun 2011 00:43:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CCE825988; Tue, 14 Jun 2011
 00:43:22 -0400 (EDT)
In-Reply-To: <20110614003029.GA31447@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 13 Jun 2011 20:30:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB02D840-9640-11E0-BFBB-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175744>

Jeff King <peff@peff.net> writes:

> I suspect the feature would be really easy to implement, if somebody is
> looking for a gentle introduction to git, or a fun way to spend an hour.

I would rather want to see if somebody can come up with a flexible reverse
mapping feature around notes. It does not have to be completely generic,
just being flexible enough is fine.
