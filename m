From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to fork a file (git cp ?)
Date: Wed, 04 May 2011 19:14:24 -0700
Message-ID: <7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
References: <4DC1934D.6070608@aldan.algebra.com> <4DC19955.7040503@kdbg.org>
 <7viptqdvrf.fsf@alter.siamese.dyndns.org>
 <4DC20461.4090703@aldan.algebra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: "Mikhail T." <mi+thun@aldan.algebra.com>
X-From: git-owner@vger.kernel.org Thu May 05 04:14:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHo5S-00074A-EM
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 04:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab1EECOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 22:14:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1EECOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 22:14:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C4FC44C7;
	Wed,  4 May 2011 22:16:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9YlfSnZoKQ6syjkaeVbcm/yyK6Y=; b=qN8xcm
	YJGutRhid/GG3uv+sa64mVRFOyhi1zhaF3zkW2yWyja3d5dQSwfWZv+cEDzTeVqg
	4tYRfxEJal3SAVM//qZ0V6atusn/d0W+tnMXUfuGlB3RJ52OUCFo8QC3u2t82nlR
	/kNH2gZ0eYCsyG0DN+GZM4sevC3xyikVyR55w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vRtWMi/s6mZBDr4ehL6k3Me5peGcn9Ni
	xi4AbhQgL9aDBH77rdJd/PiT8F8e57c6HWFKtVifB+O6jYsq2xYJ9I6y6+uG8RkY
	uEAH43M6OTajfFjkfRaRo/LDyRQK2NWCSVQ8XJHD4lAecuCWl50BPr4zm+RHYILz
	/xibhpyHctA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1ADC844C6;
	Wed,  4 May 2011 22:16:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0EB2144C1; Wed,  4 May 2011
 22:16:29 -0400 (EDT)
In-Reply-To: <4DC20461.4090703@aldan.algebra.com> (Mikhail T.'s message of
 "Wed, 04 May 2011 21:58:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2B6B48A-76BD-11E0-BD37-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172787>

"Mikhail T." <mi+thun@aldan.algebra.com> writes:

> On 04.05.2011 17:02, Junio C Hamano wrote:
>> Well, if you come from the mindset that a "file" has an identity (hence
>> there is a distinction between "This file used to be called A and at one
>> point was renamed to B which is the name we see today" and "Some time ago
>> somebody created a file B with the same contents as A and then removed A
>> at the same time"), "copy" would not make much sense.  What identity does
>> a new file B gets when you create it by copying from A?
> What I want is to signify something like: "This code was obtained from
> that in file A."

I think that is what exactly "blame -C -C" gives you.
