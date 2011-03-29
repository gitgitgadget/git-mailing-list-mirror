From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-notes.txt: clarify -C vs. copy and -F
Date: Tue, 29 Mar 2011 12:04:25 -0700
Message-ID: <7vd3l9rbnq.fsf@alter.siamese.dyndns.org>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net> <7vbp0tss6t.fsf@alter.siamese.dyndns.org> <7v7hbhss0g.fsf@alter.siamese.dyndns.org> <4D9226B4.20806@warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Michael J Gruber <drmicha@warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:04:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4eDa-00085L-PR
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 21:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab1C2TEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 15:04:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1C2TEh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 15:04:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AA96468F;
	Tue, 29 Mar 2011 15:06:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IxZk2X1+tIvZ0lMj+nI2Fx7Iybc=; b=wr3ZSM
	MYuh5y/P3+Gm3qqXJU85PfDtiN1BAYk5a9eRlAuZlFiFliLGUnHnvwrDnX46D1bk
	OLBdPf650fsz7WxE2EQYYuQfWO3VD1SGMV/PgLPjmSXNnJFpbyHCppXVIdTF7By2
	aLOi/9UGHk9LIMKqvqa4cYLbKl8SOf8YAtytM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x36nINC519RgwtyF9VqvxEpcBFbmzfr+
	jb1TvOq4QrGUFlNARmk/czVOMRwp0CTL0MzrgBPk+lD91ahHkzLIUmRSexxDtIpe
	yxGecmnk8bq8nnBQjq/WfinsccdUNSIQ8K/OvI/bpJWqZLRlZ5A7Mys1frhuKYxQ
	F/9m9Nosqgw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3915B468E;
	Tue, 29 Mar 2011 15:06:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE896468D; Tue, 29 Mar 2011
 15:06:14 -0400 (EDT)
In-Reply-To: <4D9226B4.20806@warpmail.net> (Michael J. Gruber's message of
 "Tue, 29 Mar 2011 20:36:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1922376-5A37-11E0-A2CA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170309>

Michael J Gruber <drmicha@warpmail.net> writes:

>>> Yeah, it utterly is broken.  Why not fix it before people start making
>>> serious use of notes?
>
> You seriously ask why? Because I've banged my head way to often by
> suggesting behavior changes!

Change of a behaviour that nobody had chance to have seriously used for
only 6 weeks or so?  I'd call that a fair game.

> If I were to reimplement it I would:
>
> - make "notes add -C/-c" really analogous to "commit -c/-C", i.e. do
> "notes copy"

That is sensible.

> - make -F binary safe

Likewise.

> and while at it rename "add" to "edit"

That one I think is older wart that may be harder to change.
