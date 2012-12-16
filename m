From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Sun, 16 Dec 2012 15:11:26 -0800
Message-ID: <7vsj75pp7l.fsf@alter.siamese.dyndns.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
 <7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 00:12:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkNNS-00081v-Pw
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 00:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab2LPXL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 18:11:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab2LPXL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 18:11:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7415FA199;
	Sun, 16 Dec 2012 18:11:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nWiKmxljXSMM4cQWZaTDQVwbrHg=; b=g9cVrc
	+1Gb2Ax+G4iJ0rN9jrdVtaF5b+QcourHGbbIFye97ijZvZ0KE3g5HXxjCzHs/N1W
	8eL5610xZtGF8Xu5UiN24ysnlaOP8dVUORP8rX/4YvMcz3/mBBsHQWT4tz5jdLYZ
	L2tTEaaiCDPuOaxgl1XDA5ffIiky4tkzwBUOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZBsIvXXGRJCSrXuZCLIlf0VdMRC6wC4u
	HhAed+V922llD8u06UtL0eC7MZ8Hw8Rh1ejqBcPhzWT5GmiopUr8A0+l1tWHmkaT
	+SZtiRd9jHEAM7o/KQoVA7kfA88Jc2/hRu3ZquK9AIAwrSRjAl7gkFuhrf7r2XPr
	1Ymr83xO0S4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61C23A198;
	Sun, 16 Dec 2012 18:11:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D39CAA197; Sun, 16 Dec 2012
 18:11:27 -0500 (EST)
In-Reply-To: <CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com> (Adam
 Spiers's message of "Sun, 16 Dec 2012 19:01:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB795350-47D5-11E2-A567-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211617>

Adam Spiers <git@adamspiers.org> writes:

> On Sun, Dec 16, 2012 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Adam Spiers <git@adamspiers.org> writes:
>>
>>> This series of commits attempts to make test output coloring
>>> more intuitive,...
>>
>> Thanks; I understand that this is to replace the previous one
>> b465316 (tests: paint unexpectedly fixed known breakages in bold
>> red, 2012-09-19)---am I correct?
>
> Correct.  AFAICS I have incorporated all feedback raised in previous
> reviews.

Seemed clean from a cursory look.  Will replace.  Thanks.
