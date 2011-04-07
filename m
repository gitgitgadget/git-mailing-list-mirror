From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to
 use_wildcard
Date: Thu, 07 Apr 2011 12:47:45 -0700
Message-ID: <7vr59detcu.fsf@alter.siamese.dyndns.org>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org>
 <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com>
 <7vfwpvjobl.fsf@alter.siamese.dyndns.org>
 <4D9D9B60.4030404@drmicha.warpmail.net>
 <7vvcypeti4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:48:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7vBk-00011p-MJ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 21:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874Ab1DGTr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 15:47:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756709Ab1DGTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 15:47:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9AB9F41D0;
	Thu,  7 Apr 2011 15:49:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G8bAjIp5Zxr/aSZEq5gEfLGJLoQ=; b=FkuVW7
	KJTgZ5BQ5BLLlxG0h0I9IyG9fyCulSMTwgQUCQI8DTOgZLQc0VZIMIyWQOmvGTcH
	MGieL3SrOD+1qqbotMFWQVJSBjYZ8FCrvFgHzoxurVcPhl8c83vhT4cK9uI7zqxJ
	Koq6qEj6HORUkuEcju4AN2Ly/1xskptSkRRos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eRM6Ixd4Yma1rctxBb7OkVkdIWmv4uJ3
	yPe9B72K5FdrENKVcB+r5aQ1SzkBCCELJK5hbGnIHSykIoPRfjV9f61YJdqtiwkW
	747ad0qfZ8dL/+tjSDct7EI2Bd+prq3BOr+3dksfz2QPmXy/VGJgk/Mcwp9nbeLq
	GcIHUV4P78I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6ABEC41CA;
	Thu,  7 Apr 2011 15:49:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4DE5841C8; Thu,  7 Apr 2011
 15:49:41 -0400 (EDT)
In-Reply-To: <7vvcypeti4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 07 Apr 2011 12:44:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 301C174A-6150-11E0-B71B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171084>

Junio C Hamano <gitster@pobox.com> writes:

> Because I doubt that the major restructuring we discussed earlier won't be
> ready within the 1.7.6 timeframe,...

I think people involved in this thread have dealt with my bad writing long
enough and understood what I meant, but just in case, I meant to say that
I do not think restructuring would be ready to ship with 1.7.6,
in other words, s/won't/will/ is needed above.

Sorry for a noise.
