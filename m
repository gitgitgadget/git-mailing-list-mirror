From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 02 Jun 2016 12:46:07 -0700
Message-ID: <xmqqeg8ftlvk.fsf@gitster.mtv.corp.google.com>
References: <20160601235233.21040-1-sbeller@google.com>
	<574F800D.6070107@ramsayjones.plus.com>
	<xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
	<57505105.2000801@ramsayjones.plus.com>
	<xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com>
	<57507DFD.6010800@ramsayjones.plus.com>
	<CAGZ79ka3ku7x7BhBZJ_uHjS0pNLT7NFACUVqNKi=DvtOkSN_bg@mail.gmail.com>
	<57508C85.1090503@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:46:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8YZN-0000EA-LN
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 21:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbcFBTqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 15:46:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932378AbcFBTqK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 15:46:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A2C12108F;
	Thu,  2 Jun 2016 15:46:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+nCngAHb7ke22qqFy0YKk4zYLDc=; b=GVzGA5
	Rmc3kqarDW032O/fkigoWNV+nh4z90egxXSj2nBWRY0cbKqt1NNCj3Kg55FucIdk
	v4dQ92kw1KinVU4MtR1LeA9+khl14b3Ucjg2zqYff3rfFvl22k6OPoXyabbCrLcL
	ZcUBLutfoP1N/ruXDYO6Pe9OZYIgZbEnIO2U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=un+FgYkEoG0GlAq4skTZzWAHnvArKCf2
	bvi7YYTFpW7bSEdEmOBwaZdxL0PywQKMeyMSIKHNB+u6bHNJUqVj0lRUw5255vRV
	igHWBw7j4zdTvpfFWf94IepSjeBMcA0oO7S6XaxKr4X6fpE/PnCDDJwGJAjIZq/q
	+4zEjJMS8s4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 408E72108E;
	Thu,  2 Jun 2016 15:46:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C03FC2108D;
	Thu,  2 Jun 2016 15:46:08 -0400 (EDT)
In-Reply-To: <57508C85.1090503@ramsayjones.plus.com> (Ramsay Jones's message
	of "Thu, 2 Jun 2016 20:44:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A6DFB964-28FA-11E6-B087-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296229>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I think Junio wants to go with just " quoting (see other thread).

No.  I meant just \ quoting.
