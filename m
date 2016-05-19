From: Junio C Hamano <gitster@pobox.com>
Subject: Re: since/after not working properly
Date: Thu, 19 May 2016 12:03:54 -0700
Message-ID: <xmqqeg8xj2ed.fsf@gitster.mtv.corp.google.com>
References: <573DDEBF.7000903@here.com>
	<CAPc5daXPWiY8=NtOcsjMcVN2MiwaaQUbVY6GBn2Eu31Q0fZrUQ@mail.gmail.com>
	<AM4PR0401MB184426EE089AE65941C5F7869B4A0@AM4PR0401MB1844.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: "Hawk\, Jeff" <jeff.hawk@here.com>
X-From: git-owner@vger.kernel.org Thu May 19 21:04:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3TEo-00013m-E0
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 21:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbcESTD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 15:03:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754342AbcESTD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 15:03:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DF771CE6A;
	Thu, 19 May 2016 15:03:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mRKlpaGlUeDK+P2HVrcH+r22Guk=; b=l8N1gI
	IjZJ6NWUaS3SeHqGjSKWc19rcdJaxYIAw9GRlmROUBOK9r/ZmJyTcSlb4pfmbQ36
	rAnPhNGkJpfjg4ro25SL4I/oS05zuosW8b2RRbGvKv9ULIhwm278shZ4H5IUF4tl
	S3qtukTaINz4acxmn7QBEbtFlalJXkvqaHVaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Co5DlPY5ursiaoy5avZTj41iOiKLrshp
	atBFfQmVEFM/JoWaD87JTSELG8t2aA0JrtouSFseBkMhdbwrKEMvukxgouFdCcQo
	9pq6zzyldRy/0lvYCxbkEIv8RRCeWv8VqylNPehrpz9qNtU1qAhUO5PMegUIxa7z
	XBh9NL29dHg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34B041CE69;
	Thu, 19 May 2016 15:03:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2B171CE66;
	Thu, 19 May 2016 15:03:55 -0400 (EDT)
In-Reply-To: <AM4PR0401MB184426EE089AE65941C5F7869B4A0@AM4PR0401MB1844.eurprd04.prod.outlook.com>
	(Jeff Hawk's message of "Thu, 19 May 2016 17:37:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6F45A10A-1DF4-11E6-8A19-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295091>

"Hawk, Jeff" <jeff.hawk@here.com> writes:

> They suggest this:
> git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames
>
> Seems like the %ad should be %cd.

I have no opinion on that.  If somebody wants to show author dates,
that's her choice.
