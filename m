From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 15:21:09 -0700
Message-ID: <7vtymzpj56.fsf@alter.siamese.dyndns.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <AANLkTikWnVKxdUcuNHLet20HOuBuzdF9C5fOOtVaY5p8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojg9T-0005Tn-1A
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760822Ab0HLWV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 18:21:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab0HLWV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:21:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B341CC4B0;
	Thu, 12 Aug 2010 18:21:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=btz03z3LLosibpWHAOVTMJMoTvI=; b=YHlCvf
	Az0iLztweGl8BUWBi+saIxXBf3b1eDSFgB623a11CpKFTHDRsbseQgce1nMjLBs/
	GSlExVvgTbjoaMmlRLAyNViZCwwqISzQwYAIIhr0hjMcnbz4/uU33sjrX8+dvDv/
	GCVL+IC6TgL+ophjsj3Od5zWqE2ZNPi4t0d80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iFNS9xSaAnOqlKiFtbmH8vH1CvsaTCjQ
	iiUoBVSKWDIpUfO6Ztj8XHuMLEh/deQFZFICCe2YPJ4NjA4t49CvdSxYZdkbejNb
	23xgT73TW/zbWd+f1numEbx9iy65Tlv/yAN+PEN8ZhfaPEypftSZvCTcFodxH9YJ
	UCzhZbIpy5c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D2FFFCC4AE;
	Thu, 12 Aug 2010 18:21:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFE7ACC4AC; Thu, 12 Aug
 2010 18:21:11 -0400 (EDT)
In-Reply-To: <AANLkTikWnVKxdUcuNHLet20HOuBuzdF9C5fOOtVaY5p8@mail.gmail.com>
 (Elijah Newren's message of "Thu\, 12 Aug 2010 06\:43\:25 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE86E8C4-A65F-11DF-A2EE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153433>

Elijah Newren <newren@gmail.com> writes:

>> The new tests in t/t3509-cherry-pick-merge-df.sh and t9350-fast-export.sh
>> need SYMLINKS prerequisite.
>
> I'll fix them up.  Sorry for being less familiar with the rules, but
> since these are in next, do I resend the series or just the new fixes?

A fix-up patch on top of what is already in 'next' is welcome.  Thanks.
