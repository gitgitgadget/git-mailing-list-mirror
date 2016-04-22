From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 10:24:23 -0700
Message-ID: <xmqqvb39pneg.fsf@gitster.mtv.corp.google.com>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1604221601270.6812@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:24:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ateog-0004ez-Be
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 19:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbcDVRY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 13:24:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754478AbcDVRY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 13:24:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CBDEF155F4;
	Fri, 22 Apr 2016 13:24:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=paNqmQ2JtYikY/v9YyfwgYRGDHY=; b=PRblHL
	x+ODJFltZY6ewPwLES6ifxObWXtRLOCzQ0nZqu1joo6T5K0AHK5OKCajtBjiqk/t
	uKhcWsZYf6pUvncx3rAsqQUBJLALBfYA8Tr169+R+Vf/AEsKQDeOhFpoi0CDhrrH
	mWe2Otutt7Oc04yvANK8t7G//EsiIRMC0MLXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ChR/WM6SVZZ1hTk+OBcSqRyeUPbLEnc+
	RSVqNs16dDmpXQR4cap4gff2GNn+yrvNPN3UHf9j+u7S6TMjv5anqy2IdcHZt+Zo
	V7NEhSIapfc04LopHdZJS7NIDiGr4cUnENrE0Ag1n8xOD1Xw3d3TQtUxtbD1KRL0
	Eds96mCwzdY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4B03155F3;
	Fri, 22 Apr 2016 13:24:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23174155F0;
	Fri, 22 Apr 2016 13:24:24 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1604221601270.6812@virtualbox> (Johannes
	Schindelin's message of "Fri, 22 Apr 2016 16:04:02 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0EC6A176-08AF-11E6-83D5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292233>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 21 Apr 2016, Junio C Hamano wrote:
>
>> * js/am-3-merge-recursive-direct (2015-10-12) 2 commits
> ...
> I hope to find the time next week to go through the entire call graph and
> verify that we are only die()ing in case if really critical errors (such
> as out-of-memory, in which case we traditionally just die).

I'll drop what has been queued and wait for a reroll.

Thanks.
