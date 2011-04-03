From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH maint resend] compat: add missing #include
 <sys/resource.h>
Date: Sun, 03 Apr 2011 12:27:32 -0700
Message-ID: <7vlizrb0ez.fsf@alter.siamese.dyndns.org>
References: <1300271879-2050-1-git-send-email-stsp@stsp.name>
 <20110318202351.GA22696@elie> <20110331225909.GA21429@elie>
 <20110403191324.GE3830@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stefan Sperling <stsp@stsp.name>,
	Arnaud Lacombe <lacombar@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:27:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Sxo-0004Qd-A7
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab1DCT1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 15:27:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1DCT1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 15:27:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 577C5438F;
	Sun,  3 Apr 2011 15:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=81r6JZ6ifNQTfv6KPvrgnb3w9wU=; b=CCjYdL
	lslFOdq2+46ELBnO7fKm+hsut4Zwy+NRcsZYNfr+wldh50o3V03m+oRc6A/A0/UM
	NPYaZslaCx71trmmXGo1dk3GQa/M4qWF0PZc7MYwx11YRkaof7Ts6PrchnbM8Ilx
	9eXCpm2eAf6CtbGbnubEpvNRGOLAUf7yRWZnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=btM3eUziTAtHLMl/7w1iBmlK68B5HHyp
	SvHy4bLS8WPYc1xc0sfgbKXixlwrJudoWCJpbkcCmAf+GUzSsEbtnzcY3ejRL67v
	5FpcKo8X3NSJBLKniFYUE1r3VRMQMoItQwzoSjvppLOCXaeAB4OOwHQS9hO4qIuK
	HYni5Sb11Gc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA3FA438E;
	Sun,  3 Apr 2011 15:29:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 060AA438A; Sun,  3 Apr 2011
 15:29:25 -0400 (EDT)
In-Reply-To: <20110403191324.GE3830@elie> (Jonathan Nieder's message of "Sun,
 3 Apr 2011 14:13:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4F455A2-5E28-11E0-8E3F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170778>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ping?  Would you like a shorter commit message, or was this just lost
> in the noise?

No, it was sitting in my to-be-applied box.  Thanks.
