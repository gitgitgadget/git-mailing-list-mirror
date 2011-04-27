From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.txt,diff-options.txt: porcelain vs. plumbing for
 color.diff
Date: Wed, 27 Apr 2011 09:39:40 -0700
Message-ID: <7v7hafabsj.fsf@alter.siamese.dyndns.org>
References: <7voc3sewpg.fsf@alter.siamese.dyndns.org>
 <24a6907cade7aedb51dc20ab5977603ca21e70bb.1303889849.git.git@drmicha.warpmail.net> <20110427090323.GA14849@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF7mQ-0003AU-MK
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 18:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab1D0Qjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 12:39:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab1D0Qjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 12:39:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 508664148;
	Wed, 27 Apr 2011 12:41:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0v5A5FqkZs+SYlw9IRjPN6+N80o=; b=EyjHlW
	Tm9TMJ/G8fPvoMB3y1tIQcBdRe67w5M4860QM0O0g6+e5R6bJeP1YSdNX/YsmjhT
	/ZVuzFqy8YknQvWqfR6Yw/vfqvGT7dM5XPNznnkbFWQJjYhWYnvD9hhk7ClXOVM2
	yCpBObCIjlGWPCI5rwmIXTuJMsI9nodT+Fre0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rgPLpUElNvOqZ/lIQa28ARtWr0JreKHl
	PA8iIos5mSS0g1kPRRUjxDcc9JcE18mTBrocf3NK6NN6WZzu2aBVsWzgLHnne4al
	XGUwPNDSX3dRm8tI7U3pGVY9dYE9zyhPHfytgDVfCEdCL4Y1JMEOamlOe7rY1Rnn
	MR2eemLYZSA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F8D04146;
	Wed, 27 Apr 2011 12:41:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 060084145; Wed, 27 Apr 2011
 12:41:43 -0400 (EDT)
In-Reply-To: <20110427090323.GA14849@elie> (Jonathan Nieder's message of
 "Wed, 27 Apr 2011 04:03:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E93195C-70ED-11E0-AB4A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172243>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michael J Gruber wrote:
>
>> Reading the diff-family and config man pages one may think that the
>> color.diff and color.ui settings apply to all diff commands. Make it
>> clearer that they do not apply to the plumbing variants
>> diff-{files,index,tree}.
>
> Sounds like a good idea.  Quick reactions:
> ...
> Thanks, and hope that helps.

Your text reads better at least to me.
