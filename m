From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] Introduce CHERRY_PICK_HEAD
Date: Sat, 19 Feb 2011 22:43:33 -0800
Message-ID: <7vhbbzmciy.fsf@alter.siamese.dyndns.org>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-2-git-send-email-jaysoffian@gmail.com>
 <7vipwibfc5.fsf@alter.siamese.dyndns.org>
 <AANLkTik7cfihdu5-0pvgkq1u7kVShEqnjzh07T+5pU16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 07:44:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr31Z-0007Kz-09
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 07:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158Ab1BTGnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 01:43:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab1BTGnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 01:43:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E45749C7;
	Sun, 20 Feb 2011 01:44:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jVWlbVBdV74X+sLtGIW3ODs3Pgk=; b=LfZa1G
	RX7RaM1uM89x31KG6dPDWE4dwt7tpzeO6IvYv9/eJhxh8d5uV/V7FYw2H8AFqtDi
	8Y1N6G+UeVSR+L8v9akKhwwuKYfjJpCaO31lhxaVVQ8RwvkX5IwTdznzUFnEsWcq
	EUNKnq4jUxpqXQD0Pl/ZmFUNg35XnFqgpVev0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q5mmsGLC9sULInj9E77J2Cwr2VSXCHyR
	BOhqLky+M54GfZvCp9JgQV9Afn7Vy6s7C2AIbrsWpsmGkQKwjyN+JQFaSA2VDKTQ
	1PHtSvDTyrMAk52JovrkTJsJEO8gGLul9MYzSs44YiXD8mrHtuvjrdImOWZq39vc
	xLB8KQIDYmQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF6DA49C6;
	Sun, 20 Feb 2011 01:44:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 68A7A49AE; Sun, 20 Feb 2011
 01:44:46 -0500 (EST)
In-Reply-To: <AANLkTik7cfihdu5-0pvgkq1u7kVShEqnjzh07T+5pU16@mail.gmail.com>
 (Jay Soffian's message of "Sat\, 19 Feb 2011 21\:29\:28 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EBCD906C-3CBC-11E0-B55F-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167401>

Jay Soffian <jaysoffian@gmail.com> writes:

> ..., but I think the current message is correct. This hunk is inside
> cmd_merge and the user is about to start a merge.

Yes, you are right; I misread the patch.  Sorry about that.
