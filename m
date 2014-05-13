From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: completion: fix 'eread()' namespace
Date: Tue, 13 May 2014 13:41:15 -0700
Message-ID: <xmqqvbt9mmxg.fsf@gitster.dls.corp.google.com>
References: <1399987279-12487-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-fc@googlegroups.com, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 22:41:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJVw-0005nG-S3
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbaEMUlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:41:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58603 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754067AbaEMUlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:41:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BEE5F178D9;
	Tue, 13 May 2014 16:41:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AwR5O39bwjeJxAANrNxih1KEQ8g=; b=lPXN+Y
	dLLcG8vwLuTHY5L1uRWBeX9xKW4xjm9u7X7l7720AraWVHbLyGzrzdO+WOq84J2x
	NiqhTiHlNUiHxfNWoF1VoIQOkc0BxPOwa+1NDB7HEGkh6eQnB+uDDKWwdyFvs4lj
	q2Eapj0LOzxstXUyBqY20y82f/SJ6a6PTctxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VK5vnUJuBHFzaZSRG+Lp5MKkBVEzWIcv
	wstUP0RI9nGg6kDW2hZpyP/OUvaOxNvI1VsDbWxLgwB45tSTIu0BobWyjZEiLWNC
	71qSEctU3W6JCr+mc0n/HhdQumouD4lAxn88LbeFRy53pUUALwNkjU+l7LVNQZaL
	n6eJAIFEgD8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3985178D8;
	Tue, 13 May 2014 16:41:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6A914178C4;
	Tue, 13 May 2014 16:41:17 -0400 (EDT)
In-Reply-To: <1399987279-12487-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 13 May 2014 08:21:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EEC1705E-DADE-11E3-8F94-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248847>

A reasonable regression fix.  Will queue for 2.0 final.

Thanks.
