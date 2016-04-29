From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strangeness with git-add and nested repositories
Date: Thu, 28 Apr 2016 19:54:55 -0700
Message-ID: <xmqq8tzx2kg0.fsf@gitster.mtv.corp.google.com>
References: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
	<CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
	<xmqq1t5p7kmp.fsf@gitster.mtv.corp.google.com>
	<xmqqd1p92kll.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew J <andj2223@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 04:55:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avya7-0001am-D8
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 04:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbcD2Cy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 22:54:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752189AbcD2Cy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 22:54:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 893CF17ADA;
	Thu, 28 Apr 2016 22:54:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0HRtck/cZ8PjozcU/4UaJX086LY=; b=Gi1Hib
	dB5wyEzGEERP1auvpg2uMQIFUNZh/4SeULF4l5BJeKz1fgM51w0CDuHUoXErdNyv
	nZNVV2FkkB+U8xD9DeVYZOXYuw9cI+kNILlknuOdNJXARuDKSgrb9HP2pCYFb8Pk
	ZZlkFkWTPQb3V94gY5OYNg8qvWgXUZKrdvSNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jbLG37B5G5fsnAuKfELDoPtcspGe8+b9
	xp/9H+mHgzg/RJsCETmRWnO8tRxOPJ8NBf9JXHMEGyaFC/jk6f21sMyrpbEjSbUi
	jPaE8ry1y4RM9gUgSLrk07c+irTlSKI+dpVNBRKLInJv4jcv/7e+DnT7GPAjx+rw
	yemVbbgp5pg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8043C17AD9;
	Thu, 28 Apr 2016 22:54:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEF6217AD8;
	Thu, 28 Apr 2016 22:54:56 -0400 (EDT)
In-Reply-To: <xmqqd1p92kll.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 Apr 2016 19:51:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C19CC342-0DB5-11E6-B389-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292968>

Junio C Hamano <gitster@pobox.com> writes:

> A cursory bisection suggests that this used to work up to at least
> v2.7.4; this must be a recent regression.

No, false report.  This seems to be broken from ages ago.
