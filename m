From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 12:41:23 -0700
Message-ID: <7vhai5ic2k.fsf@alter.siamese.dyndns.org>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
	<7vwqr1jw67.fsf@alter.siamese.dyndns.org>
	<CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
	<7v8v3hjt57.fsf@alter.siamese.dyndns.org>
	<CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
	<20130514191757.GP3657@google.com>
	<CALkWK0=fr6413jY0wEf061y6Q_1MOksuWWBFuKhgdhphPHY-Cw@mail.gmail.com>
	<20130514192909.GQ3657@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 21:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcL6I-0004kQ-T7
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab3ENTl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:41:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656Ab3ENTl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:41:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E30681E11B;
	Tue, 14 May 2013 19:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s3B26HArJFqIlQvebMV4a2UfYNg=; b=dbG+2j
	gSu66lm1yJK3FwOv8fOZDnU4p+gSLVKD48H9of2QtJXNjgw8Vg0EhTgmDAG/201u
	AATA9vZtLeO6H39jtvFtHeRLdhFJBqRxBTDj+2cMy5Oi0rjHIbdTTdYDV+9TqoJq
	k1UmCRUiY5bcFSaWSEexMhUGmBeM+9RrfsEOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VLqwTcwW2yGGE6m44uIWksjE10abS/IJ
	Cha86VkuUp23UI4fl851eYW8ypkRYjeUrX/yKsyX0Y43A9uje2TeRaZAsKW+2197
	nwPpVvRHNaEwILah6NX6IFvTylnPs66QsfzSB15ICUhm7AlAi+Ggkqm/5/+ZtzMf
	3YnHkZvmw3k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D40FE1E11A;
	Tue, 14 May 2013 19:41:25 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4913E1E117;
	Tue, 14 May 2013 19:41:25 +0000 (UTC)
In-Reply-To: <20130514192909.GQ3657@google.com> (Jonathan Nieder's message of
	"Tue, 14 May 2013 12:29:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 434F16E2-BCCE-11E2-86CF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224325>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> Should we mention in the -S documentation that temporary shell script
>> is the way to get multi-line input?
>
> No, because for almost everyone it isn't.
>
> An example in the EXAMPLES section including an aside that you might
> have to hit ^V to enter a tab could be useful, though.

Or document it as "for scripter's use", which it is.
