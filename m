From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2014, #01; Mon, 6)
Date: Mon, 06 Jan 2014 15:32:06 -0800
Message-ID: <xmqqzjn8g009.fsf@gitster.dls.corp.google.com>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
	<CALas-ii8anKWa1qhn29fNxHiLbbrak=5XUSNPw26LBViREiS4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 00:32:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Jee-00077v-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 00:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbaAFXcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 18:32:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932806AbaAFXcL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 18:32:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6403D6134F;
	Mon,  6 Jan 2014 18:32:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oSfFVSlOX0rSbnE637DmaKXbNzI=; b=q8rgFT
	OUrwo/Wh2zypZMdeefWl80Rn5hoDT218BCITrvwHpccsHu//0wP502k5C8WG1WmC
	VOwuK9X10p7tfYaa030arSTYFwkU4DDLi4cf3Mv4GdRkOuRSr3Tozi1TqGevO00g
	oxcWkkuw+gLdd3HOJW6r4MmNiCl02GwMslUTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TvCthx4oIOL2TWbZ/N6f/306+aJ31P5x
	ouT2vFUA1EcunenDp2QcBfcrTROolPofogtfWaiTH5iKVgjS/EB+xOF4pjC0Grb+
	5iD0Qv8zlwZ2jabhB7DTlHxCl1y2FLz+Oo2VTtN1NNFOKD7WOXYW+9BGxmwGt9Oe
	QGxf88ec8Vc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 502766134E;
	Mon,  6 Jan 2014 18:32:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FE116134D;
	Mon,  6 Jan 2014 18:32:09 -0500 (EST)
In-Reply-To: <CALas-ii8anKWa1qhn29fNxHiLbbrak=5XUSNPw26LBViREiS4w@mail.gmail.com>
	(Francesco Pretto's message of "Tue, 7 Jan 2014 00:16:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C30CEFF0-772A-11E3-9784-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240083>

Francesco Pretto <ceztkoml@gmail.com> writes:

> 2014/1/6 Junio C Hamano <gitster@pobox.com>:
>>
>>  - git-submodule.sh: support 'checkout' as a valid update mode
>>
>>  Need to pick up a rerolled one.
>>
>
> I resent it, can you see it?

I know. I saw it and that is why I left the note to self.

The thing is, it takes a non trivial amount of time to run through a
single day's integration cycle, and any reroll that comes later in a
day once the cycle started may be too late for that day.  Otherwise
I have to discard the the result of earlier merges and tests and
start over from scratch.
