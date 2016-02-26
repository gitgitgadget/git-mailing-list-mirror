From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-commit: add a commit.verbose config variable
Date: Fri, 26 Feb 2016 08:56:48 -0800
Message-ID: <xmqqio1bl8a7.fsf@gitster.mtv.corp.google.com>
References: <56CFBF19.6040004@zoho.com>
	<CAPig+cQE6ytRKFjqRRLrPHCYqJuf52NKvy8sZs8rX3t5_kDRVg@mail.gmail.com>
	<56D05295.6020102@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@zoho.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 17:56:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLhJ-0002ry-CD
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933286AbcBZQ4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:56:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754483AbcBZQ4x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 11:56:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8880A43D49;
	Fri, 26 Feb 2016 11:56:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EEaMQldPUWPmsaSIHX6dhXxh6RI=; b=eqNF18
	YJ5OGs7/vxoHZcYe34q5HtVPdgPyTPTM3zTW2NcSrVGR7PMWiiI+7FzEhC5iniE9
	CHnF2GM944rkAGbzZw0XJfKNxXN2V3x41HHdqrokXt9FZubHbwXPkUKbxi47xEfy
	g1/NBr0LU42nlDN3cKJ/YXdCJd4j2FR5kh95o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rbb82vtAak4OY0eVnmlZBsd7Zj4o9tjh
	CqV5tY6hxLxi6MM0B1NYsWMn6Ua5t3/enWHjqDX7muK4HUgmQDmeT35IQDZ4DVr+
	LAEWii0ouoc4VWvcEVY/zHnyeAT2sZhENnXWHj6ZIkrHljXJ1LxkUKk26ZwVZ96/
	SrtCzZ819+w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E9D843D47;
	Fri, 26 Feb 2016 11:56:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D91D743D38;
	Fri, 26 Feb 2016 11:56:49 -0500 (EST)
In-Reply-To: <56D05295.6020102@zoho.com> (Pranit Bauva's message of "Fri, 26
	Feb 2016 13:26:45 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EDA79C88-DCA9-11E5-B4D2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287590>

Pranit Bauva <pranit.bauva@zoho.com> writes:

>> If you know you haven't finished, you may use WIP (work in progress)
>> instead of RFC in the title.
>
> I wasn't familiar with this tag. I will keep it in mind. And this is not
> included in Documentation/SubmittingPatches , so I will send a patch to
> include WIP tag.

Please don't.  It is OK to say WIP or RFC or some people even say
[not a patch] there; we do not need to enumerate all of them, and
your original RFC was just fine.
