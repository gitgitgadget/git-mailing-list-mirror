From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] Don't free remote->name after fetch
Date: Tue, 14 Jun 2016 11:57:07 -0700
Message-ID: <xmqqr3bz8upo.fsf@gitster.mtv.corp.google.com>
References: <1465928936-68866-1-git-send-email-kmcguigan@twopensource.com>
	<xmqqvb1b8v2w.fsf@gitster.mtv.corp.google.com>
	<CALnYDJObFtrKFBRbbaA2KV257j8L8gcKcGk-Pkhsyvbk7+oTjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Keith McGuigan <kmcguigan@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 20:59:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCtYn-0004V2-8B
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 20:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbcFNS5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 14:57:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752976AbcFNS5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 14:57:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 29BD0236AB;
	Tue, 14 Jun 2016 14:57:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8PuaRYeQlsIeFhjLpMTmtu/JJK8=; b=TzkE97
	p3yxoHPdKP1tMbfW0MWqo3WlrlzNTbBpxAcT1dAk1/BZ8l2m2R5QDspUCFJntYz0
	gCuolhrAmwibdfVsEkncm4EzYLv9pMwz/pYNQNYOhwag/MLW8P5as4QhvNrLTDcW
	xcmIgF8njwNd3+z1kdCEqY4XsiyetGrc8rNIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tWHNxa6C0aAhFuD7kQ7WhFRp5kJO50I5
	mYFRoAejSVZNJKVNAZmqK4Kd4WYsgAneXDmP9uej6RX5oRnohKfzBVWEObMlHxR2
	3QSOn/BnUyk7S2sbqc77mLRS/tSC1aiddOnZLmEPcRSvndTPJkpROxKvH0Wn12eQ
	zUUVHNlCuFI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2282E236AA;
	Tue, 14 Jun 2016 14:57:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A927236A9;
	Tue, 14 Jun 2016 14:57:09 -0400 (EDT)
In-Reply-To: <CALnYDJObFtrKFBRbbaA2KV257j8L8gcKcGk-Pkhsyvbk7+oTjQ@mail.gmail.com>
	(Keith McGuigan's message of "Tue, 14 Jun 2016 14:54:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CBF4FD16-3261-11E6-A2A3-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297321>

Keith McGuigan <kmcguigan@twopensource.com> writes:

> Yeah that was the only place I found where it was doing the strdup
> already (and in that situation, it has to).  All the other places just
> grabbed remote->name.
>
> Yes, sorry, I can sign off on this.  Do you want me to resend with the
> header in place, or is this confirmation good enough?

The latter ;-)  Thanks.
