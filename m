From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Thu, 07 May 2015 11:35:53 -0700
Message-ID: <xmqqfv78p75i.fsf@gitster.dls.corp.google.com>
References: <55463094.9040204@gmail.com>
	<xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com>
	<xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>
	<CAPig+cQKqkoqN+o_QfVBRvxGdNuJn_oxD5YMsvnBOHguimJhGQ@mail.gmail.com>
	<CAPig+cStUNPZqEyE1rJVj5AsTeZFU54mc97rgQqiPbr5V1B0Sw@mail.gmail.com>
	<554A192D.7000102@gmail.com>
	<xmqq1titd3t6.fsf@gitster.dls.corp.google.com>
	<CD7EEBF2-FE5A-4309-86D8-CBF9F205A159@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:36:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQeP-0001NG-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbbEGSf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:35:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751121AbbEGSf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:35:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6348F4D2D9;
	Thu,  7 May 2015 14:35:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bduqVUZWGfOljdSf8Te2A3fw+DQ=; b=ugLkhX
	ZoBJhIpHmCZtyY3zDCEhLPOs0sw9T7CgZGBmtV4OWKN2ejTaczk9/nh+ccXvBz4e
	R6mKFm/VECInSt2hb9zwJYCZSBBNPMCeT3IITy+AvUn9GCOUEl0G5Epf/lMfDkxw
	I0+yCqIH6oYdYunMbg33wxaVsZkBzahARi5JI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dTzuruGJGKgju6WjWjeH+8U4YYK6VSoB
	kjhhiYUi8VPHRRWZMx0hR5y/IKyFgmg4XeZ/SvYOwn9iOZjoY950JAvo2+THvkX9
	sMapQ6Q+WeF9cYKme3vfpZ7ECe89CWEkL2Q+9rLIBDwJa6LcpZIhd/7lTxJJLLmd
	Q2X9T6ssw/Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 566574D2D5;
	Thu,  7 May 2015 14:35:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D13684D2D3;
	Thu,  7 May 2015 14:35:54 -0400 (EDT)
In-Reply-To: <CD7EEBF2-FE5A-4309-86D8-CBF9F205A159@gmail.com> (Karthik Nayak's
	message of "Thu, 07 May 2015 09:04:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E53FA054-F4E7-11E4-9B8F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268573>

Karthik Nayak <karthik.188@gmail.com> writes:

> By saying "the changes suggested" I meant the SQUASH queued on topic

OK. I've squashed that in.

Let's wait for a few days to see if other people have more comments
and then start merging the topic down.

Thanks.
