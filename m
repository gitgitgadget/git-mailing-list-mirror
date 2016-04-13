From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why doesn't gitk highlight commit references from git-describe?
Date: Wed, 13 Apr 2016 14:50:52 -0700
Message-ID: <xmqqbn5djhz7.fsf@gitster.mtv.corp.google.com>
References: <nemal5$mb$1@ger.gmane.org>
	<CAGZ79kZVC0FxUN45KgLh-2tEK2=j2-yyTajYOc=s-LECgx+yqQ@mail.gmail.com>
	<xmqqk2k1jita.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY_C9wSS+z7XwPEWiM+8vhYuZzs_SPZ0mQR=LB+MPzTJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Kelly <steveire@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 23:51:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSgd-0007xn-Pm
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbcDMVu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 17:50:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750802AbcDMVuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 17:50:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5122912193;
	Wed, 13 Apr 2016 17:50:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5tJzEGpPT61U2NSyCbtD4vBpAgU=; b=DN3B6A
	0r83KB8SgtlvOtMjO8M3Q6c4R2DO+6Myk1YaQT/7q4qEev/1/yDssAD6xFxFIjRP
	7rJc2pBTs7llQ2pQ7jB1UVpOMl7NNs+MTlnDS2xUk6eOiPZOUHHU8ovacHi5goJq
	mLSVX7BsPS19U288ttTwKqCImZiWX3y6ZY0AY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLNkQYTapPDyTSfDf/ZIllLqR560LejZ
	zX4fITprGdAUeJ0tUgVXCPAXxdwe5T6je/7lPmUjqjuJyryYdlWZDzmU3RhOIXkH
	zVHZ67lHZLaTfAQzvYzn3vfTSKuQIrD+fSB6lDv7OKpP89vIhUaDgElEL1eV/2aG
	Gevwi2c+THs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4908912192;
	Wed, 13 Apr 2016 17:50:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A219212191;
	Wed, 13 Apr 2016 17:50:53 -0400 (EDT)
In-Reply-To: <CAGZ79kY_C9wSS+z7XwPEWiM+8vhYuZzs_SPZ0mQR=LB+MPzTJg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Apr 2016 14:45:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CB8E03D4-01C1-11E6-A7B7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291492>

Stefan Beller <sbeller@google.com> writes:

> But it should not be just tags?
>
> We also want to have 4b9ab0ee0130~1^2 to work `right`,

I'd consider that just "crazy", though.  I'd be just happy to see
4b9ab0ee0130 highlighted and lead to the named commit, i.e. as long
as ~1^2 is not part of the link, it is sufficient.
