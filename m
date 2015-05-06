From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Wed, 06 May 2015 10:16:37 -0700
Message-ID: <xmqq1titd3t6.fsf@gitster.dls.corp.google.com>
References: <55463094.9040204@gmail.com>
	<xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com>
	<xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>
	<CAPig+cQKqkoqN+o_QfVBRvxGdNuJn_oxD5YMsvnBOHguimJhGQ@mail.gmail.com>
	<CAPig+cStUNPZqEyE1rJVj5AsTeZFU54mc97rgQqiPbr5V1B0Sw@mail.gmail.com>
	<554A192D.7000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 19:16:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq2wE-0002VV-0I
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbbEFRQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 13:16:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751840AbbEFRQk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 13:16:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73D4F4E410;
	Wed,  6 May 2015 13:16:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BEENyIicEymxZCQ2xwPrPiGhhrk=; b=HnkG9Y
	rlit5N51UBepa3iloAhbnNNLfWVU0GOJlNl5AmS/H2MuIhjbI949kbd7t4ZqTlqu
	Y+vNDcxCmtaN4fR1loT60JQB4+M3NGoXeq52GM/Wfzo9vxglxMxl0px5WEuiK9SN
	O8x7pzvmrOIubhqYIcgFEfoziDifkxHL9tFVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XffGpxTFqigmBMmQ+tYIol/L+vzrCiDU
	OywNDkK7MhtzXuQ/Es+og/1kA/Yxj8/6aDvcYmLT3ia8bW+5uoB20j+fdE4duxg4
	gp/UXDyWOCyExf9sbjAoZEFzKZZojlPqpu1ZjC1rEKgx497gj2BYP/OlBmL0H7EO
	mNOqgGNUzAw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CD184E40F;
	Wed,  6 May 2015 13:16:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5E9D4E40E;
	Wed,  6 May 2015 13:16:38 -0400 (EDT)
In-Reply-To: <554A192D.7000102@gmail.com> (karthik nayak's message of "Wed, 06
	May 2015 19:07:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A80256C0-F413-11E4-88D7-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268468>

karthik nayak <karthik.188@gmail.com> writes:

> No other changes for now, apart from the changes suggested by
> you and Eric. You can merge it into 'next'.

Do you mean by "the changes suggested" the SQUASH queued on the
topic?  If it is more than that, then I'd prefer you to send an
updated series, as I do not want to guess how you'd plan to respond
to these suggestions.

Thanks.
