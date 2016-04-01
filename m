From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] mergetools: add support for ExamDiff
Date: Fri, 01 Apr 2016 11:10:56 -0700
Message-ID: <xmqqfuv5i4i7.fsf@gitster.mtv.corp.google.com>
References: <xmqqio0a17ux.fsf@gitster.mtv.corp.google.com>
	<1458947877-31764-1-git-send-email-jacob.nisnevich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: davvid@gmail.com, git@vger.kernel.org
To: Jacob Nisnevich <jacob.nisnevich@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 20:11:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am3XH-0001yi-7q
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 20:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbcDASLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 14:11:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751264AbcDASK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 14:10:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CE3D50597;
	Fri,  1 Apr 2016 14:10:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y39xed94Zb0vC6CYEBCcKRC3fjs=; b=bo8HYB
	sgpChbUKrSpvoPwwS03xSlo7TuLsGOrrx0D1urwdlmF7RLNvbsCW+/jwh/8w7KOh
	Bm/COZS7D4jTvg2lCNvZQ8tSLFhVAOHuQ3BFMf55Vfi3SL2nQRhLNeGFaMEa05+U
	V6Vkj4ohoN0/rFe2+iOL18QhnYKBRrCn8lX10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VAqTdKpJefOcZ5+GtNLM02BTUWIvA4qU
	Hf2Iy/oSUpNCX1EnN33rMpXLfD/IE4CdGmaxUZFHCvSTx5fCufzQyKUdj8jpbYz3
	ldnHem+zBquKikM4MY+Wxo1SapunO56IyZtnqbOQZZg8bE1pjHoHYsewBmezzXPP
	GTpzZSZW4K4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44E4D50596;
	Fri,  1 Apr 2016 14:10:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B009C5058D;
	Fri,  1 Apr 2016 14:10:57 -0400 (EDT)
In-Reply-To: <1458947877-31764-1-git-send-email-jacob.nisnevich@gmail.com>
	(Jacob Nisnevich's message of "Fri, 25 Mar 2016 16:17:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1533C1CC-F835-11E5-B69D-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290570>

Jacob Nisnevich <jacob.nisnevich@gmail.com> writes:

> OK I add the quotes and modified the comment. I also changed $folder to 
> $sub_directory. I think that makes a little bit more sense and sounds a lot
> better.
>
> Jacob Nisnevich (2):
>   mergetools: create mergetool_find_win32_cmd() helper function for
>     winmerge
>   mergetools: add support for ExamDiff
>
>  git-mergetool--lib.sh | 25 +++++++++++++++++++++++++
>  mergetools/examdiff   | 18 ++++++++++++++++++
>  mergetools/winmerge   | 21 +--------------------
>  3 files changed, 44 insertions(+), 20 deletions(-)
>  create mode 100644 mergetools/examdiff

This round looked good to me.
David, does this look sensible to you?

Thanks.
