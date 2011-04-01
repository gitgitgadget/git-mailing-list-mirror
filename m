From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try to remove the given path even if it can't be opened
Date: Fri, 01 Apr 2011 11:08:36 -0700
Message-ID: <7vy63tg7yz.fsf@alter.siamese.dyndns.org>
References: <AANLkTikfmXiZQquWi4STTCUy0qoY9J_waJ44nrPAvB1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 20:08:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5imG-0005M4-Hh
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 20:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab1DASIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 14:08:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab1DASIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 14:08:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C7ADC47A8;
	Fri,  1 Apr 2011 14:10:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oHlDy3C7qqLY7ycf0psRnJescYE=; b=av5jFT
	QohEQKCnXIohrTnnXFMYqtxM0hMZX9+7iU3yURxALhJQEihvFAlplsYC5yHB76eS
	9IyqdAPo1ZOTZqCg4zhMzkwMhvrv2nxjMuxaR7u4tGaH1TXhWu7RuKxt+WV8eYv9
	bzbziGDir2HVGxjrrgQRb3+VAYTNQ4p16tcnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l7LlpULo+j0HVU7TLeR0wNnRz/ddOcw8
	9oNQagBmnpuddABxO1R9TToRM6+tbmSZyLTz41VxmCEWizWVSf56uN8Uu6u8Fvpt
	frvKSmTvZLBHOADDp8uoOJ9PS7OedD+YFEoYYqRr8yhJ0XleHCxburuTNG1mIivQ
	ZMvPslL3PXM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7664247A7;
	Fri,  1 Apr 2011 14:10:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2007047A3; Fri,  1 Apr 2011
 14:10:28 -0400 (EDT)
In-Reply-To: <AANLkTikfmXiZQquWi4STTCUy0qoY9J_waJ44nrPAvB1d@mail.gmail.com>
 (Alex Riesen's message of "Fri, 1 Apr 2011 10:29:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 569619B2-5C8B-11E0-8CB3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170600>

Alex Riesen <raa.lkml@gmail.com> writes:

> --0016e6d9a16eca69d0049fd73526
> Content-Type: text/plain; charset=UTF-8
>
> Consider unreadable empty directories. rmdir(2) will remove
> them just fine, assuming the parent directory is modifiable.
>
> Noticed by Linus.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---

Please don't do an attachment that has an inline patch and then attach the
patch itself again in base64.  It is extremely annoying.
