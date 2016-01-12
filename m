From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Teach 'git pull' to handle --rebase=interactive
Date: Tue, 12 Jan 2016 15:40:36 -0800
Message-ID: <xmqqsi22s6x7.fsf@gitster.mtv.corp.google.com>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
	<5ed91705cc70323dd3f175627acf86a4f594536c.1452612112.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 00:40:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ8YN-0004wm-2F
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 00:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbcALXkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 18:40:39 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752810AbcALXki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 18:40:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 039233B7B9;
	Tue, 12 Jan 2016 18:40:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iA7W8R2wFRlsJErw/U3txTLVITc=; b=gM5w9C
	tF5qwb1MIksWqhnkxze8Z+czQKm/7lKSgvhkWCPB6w3auqvLWQWzJOnYzAB58JGL
	5q2OMKAeZCNmNe25e+/xQTFpNXjneCDiqITg5sM+DdNjBjmxAxELqN0LZVDBXGGB
	4svxsU4jEw4NCTuKZXHJ+4ZwTVYE/Aiui5f8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uJy6ZsoghIy5RJmOiUW91+vw+MrAyMSo
	CHC2DDy5SSZRgSC7LlXQYmx0n8k2bh/TmEwJlXARElF12/ySrgZgK36ZlwaOrw+l
	N8/dmX/O7u/Lw5hVseSWtsLGMOjK5326ytxVjNJuCuPWTLCYsc0G8jZoIsSN1w4l
	Gaik/tFzG0M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE74F3B7B8;
	Tue, 12 Jan 2016 18:40:37 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6ED3F3B7B7;
	Tue, 12 Jan 2016 18:40:37 -0500 (EST)
In-Reply-To: <5ed91705cc70323dd3f175627acf86a4f594536c.1452612112.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 12 Jan 2016 16:22:11 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E1CB4F78-B985-11E5-A4DE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283853>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Subject: Re: [PATCH 1/3] Teach 'git pull' to handle --rebase=interactive

Subject: pull: allow interactive rebase with --rebase=interactive

or something?  The same comment applies for the other patches in
this series, and other recent patches from you in general.

> The way builtin pull works, this incidentally also supports the value
> 'interactive' for the 'branch.<name>.rebase' config variable.

That, especially the "incidentally" part, makes it sound as if it is
"because we can easily", not "because it is useful in such and such
way, we must support it".  We definitely want to see patches that
fall into the latter category, and from the sound of 0/3, I think
this one should be advertised as such.

The patch text looks good (admittedly from only a cursory read,
though).

Thanks.
