From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] http cleanups
Date: Tue, 03 May 2011 21:09:29 -0700
Message-ID: <7v4o5bgl8m.fsf@alter.siamese.dyndns.org>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 06:09:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHTPH-00051u-SY
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 06:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821Ab1EDEJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 00:09:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1EDEJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 00:09:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 003135B25;
	Wed,  4 May 2011 00:11:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6kSI4eKFP5kDqtWvcpdHKFzahUI=; b=wcKTN3
	cZrK4svatqCe5yxoy14JNaxv15y/7Tl+AtvQbndFxOrpgfrXuosJmCiEKmi2h4+O
	S7OTvJNpIZjhU7Wb6/C1GSuUs8bGKbA1k8v/XKP7aO7yRGGGNHNuaD/36zuBvp42
	4u8MP2oDq7e3EaWhFA2Gc6FHX7Mxc+XcWKK58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mjJ3dIQp5EVOyfnK7FopfYyqC8VzJg5W
	BVUarcYGWZeb5cvuvfHeZH9elZhs7Ulgi5fX05vz0KQsfM4ow0bVNORjeFJTcXNR
	F5A67Er47GinRCUwNJoZOTT1rMJ9XrHP2CD5i/f8ZWkzrhuipsIOiU1LqrHFJ2Ks
	fWQZafuDT8Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B43245B24;
	Wed,  4 May 2011 00:11:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 697845B1F; Wed,  4 May 2011
 00:11:35 -0400 (EDT)
In-Reply-To: <1304437649-7052-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Tue, 3 May 2011 23:47:25 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CF6B398-7604-11E0-9809-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172711>

Tay Ray Chuan <rctay89@gmail.com> writes:

> This is a re-roll of dm/http-cleanup. I've also included a test for
> chunked http pushes that has been sitting on my side for some time.
>
> Note to Junio: these patches should apply safely on
> sp/maint-clear-postfields. Actually, the first patch depends on it.

It doesn't apply for me.  It does apply to 'master' after that topic is
merged to it, which is good enough for our purpose, though.
