From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] t5541-http-push: add test for chunked
Date: Wed, 04 May 2011 11:23:58 -0700
Message-ID: <7vvcxqe341.fsf@alter.siamese.dyndns.org>
References: <1304503896-5988-2-git-send-email-rctay89@gmail.com>
 <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-1-git-send-email-rctay89@gmail.com>
 <1304529590-1032-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>, Jakub@sepia.pobox.com,
	Narebski@sepia.pobox.com, jnareb@gmail.com
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 20:24:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHgkL-000752-UC
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 20:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab1EDSYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 14:24:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab1EDSYS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 14:24:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E9164E2B;
	Wed,  4 May 2011 14:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OGTvwWiK0scgDjIG+0mMhk2bVSw=; b=qwqb+C
	g9ohwgLJxg/bezu+RgV2VNkVlMWSUh9o8GKfbv0twt1rZeMbVdVQObKYZNHhCKb1
	73GWD7N+Tto96STTGpq4Qbu/n2efc1HogVrWTZ9cIHxA1fedUdh54Ffp/vYHHIrp
	O00vtc3YXsvHSAWYh525DEcK+7AZUELHLa1sY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UKDErGDiS3W4Qs+6HClrSkiSfgWPWW9c
	kF5wXyXdoI2IP+XJQwRaIX+bnjZpe/XVpdULNN9eaUbTcYVMV7gY5iouKCNDno0C
	9vAz30Lbh/6KTmCy6KzoyIcrnfFf9XcuJxRTygfpN2cOMdIE7ZC7j204vOmPJxzj
	gARzMjwoBpI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0C4D4E1C;
	Wed,  4 May 2011 14:26:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D8A554E13; Wed,  4 May 2011
 14:26:04 -0400 (EDT)
In-Reply-To: <1304529590-1032-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu, 5 May 2011 01:19:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE213A68-767B-11E0-A276-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172758>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Trigger the chunked type of pushing for smart HTTP. This can serve as a
> regression test for the issue fixed in 1e41827 (http: clear POSTFIELDS
> when initializing a slot).
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>
> Junio: only the first patch (this one) was changed; all the other three
> remain as they are.
>
> Changed in v5: use test_when_finished to unset config changes.

Thanks.
