From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase fails with: Patch does not have a valid e-mail
 address.
Date: Thu, 08 Sep 2011 14:21:12 -0700
Message-ID: <7vipp2wx13.fsf@alter.siamese.dyndns.org>
References: <CACyv8dckmRxgb9_FDTW+=1Y9bS27b3XZQCHnhjpfHiJig5p6wg@mail.gmail.com>
 <7v7h5jx8dz.fsf@alter.siamese.dyndns.org>
 <CACyv8dc28sRWsObYi3vbFNakj=R-2Q9eAoJdFfqNxsqq2+_aPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Blackburn <jamesblackburn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 00:56:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nWd-0004sj-KC
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1IHW4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:56:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553Ab1IHW4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:56:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFEBD56C5;
	Thu,  8 Sep 2011 17:21:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9aWUzrLS0X0QqeThz8VDGjbbdk8=; b=M7Djzb
	KW6/BwOwACjDKRgxjv6eR4JKd/lI8SahVj5AxQ8VOprm/EkIqRxbjmlV7xJnpol+
	pQmn0/0dSZBRwJQp8S7NlsfSh7wP05iByI3jdKQgkBYkvb1v9BJXvf+qSB3YRDTC
	6wi/IspNyCzk2x0lXK0WYInk1F0ngIpfXnctE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ao+O+XLvOks2wY1ns3FoX1hWPMErZJWm
	fEZYgeQ2RFStO9BB7dZ0m1NmAX44vRKK40vV+mgTpnFl2nKkMCTlc/TxM5y1f09C
	mgF0Jgo8K3Ic83TB7dqmVfWL4HDAE6+CgNBB8I4OhjiOn14DYMTOjOW2hT06SZ61
	10NA0XTKKcU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB25656C4;
	Thu,  8 Sep 2011 17:21:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C76956C3; Thu,  8 Sep 2011
 17:21:14 -0400 (EDT)
In-Reply-To: <CACyv8dc28sRWsObYi3vbFNakj=R-2Q9eAoJdFfqNxsqq2+_aPg@mail.gmail.com> (James
 Blackburn's message of "Thu, 8 Sep 2011 18:21:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B4A24EE-DA60-11E0-ABCF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180981>

James Blackburn <jamesblackburn@gmail.com> writes:

>> Perhaps you used "filter-branch" for conversion and your "doesn't
>> ordinarily complain about this" refers to it? If so, I have to say that it
>> is filter-branch that needs to be fixed to error out.
>
> I use cvs2git for the conversion (which produces a fast-import
> stream).  That tool doesn't enforce an email address, and it's only
> when I try to rebase that I run into this problem...  AFAICS there's
> nothing fundamentally wrong with what I'm trying to do, so forcing me
> to re-write the author seems to be the wrong answer, no?

Sorry, I do not follow. Nobody is forcing you to rewrite the author, but
earlier didn't you say _you_ rewrote the author into that invalid empty
string yourself, no?
