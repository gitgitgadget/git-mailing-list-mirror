From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] commit.h: add 'type' to struct name_decoration
Date: Mon, 21 Jun 2010 21:04:38 -0700
Message-ID: <7vhbkvg1bd.fsf@alter.siamese.dyndns.org>
References: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
 <1276911456-18466-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 06:04:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQujE-0005l4-FW
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 06:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924Ab0FVEEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 00:04:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0FVEEo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 00:04:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A052BE477;
	Tue, 22 Jun 2010 00:04:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=GLQYziaHTJzTE2ksAT8JJvkuraw=; b=CFIujtwlrELcScA8bNrHzt1
	KYh7wbkrcPOJwQyS6uEd0ElAin0MkE1m8hHXFi8Dbx/PFX71cWm6YksVxp/1+8cK
	LwhNUhW7EOTLtP8vMsV8djJgb17HHJ+Ec5oOa+76k3IjW6I4a90rmK8YLZ1y6BnJ
	y5B5uE4sVFDC6p2S0/vE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=FhYSxsOUStRnXVuMnPsrwXZnlqa6RNwsmj+bTPBgzul68toGu
	9jDvPF3GLLXljhBA9JX2yIqyjIJvnu18z7POb1TwPypXE1OhuX6/xaxmRfK4twb7
	WRdSbOpiL4H60LYiOM3TiZ1zmTiDbYXfmzTIlZTKSoKzgST6p1aKuQGTww=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 45B16BE473;
	Tue, 22 Jun 2010 00:04:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94678BE471; Tue, 22 Jun
 2010 00:04:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 490C6C04-7DB3-11DF-86DB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149464>

Nazri Ramliy <ayiehere@gmail.com> writes:

> Now the slots are no longer tied to log, and they are named like
> this:
>
>         color.decorate.reflocal
>         color.decorate.refremote

Wouldn't "(local) branch" and "remote (tracking) branch" be more natural
way to call these things?

>         color.decorate.reftag
>         color.decorate.refstash
>         color.decorate.refhead

And these would just be "tag", "stash" and "head".
