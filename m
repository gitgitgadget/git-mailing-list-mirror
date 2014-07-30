From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already checked out
Date: Wed, 30 Jul 2014 11:03:42 -0700
Message-ID: <xmqqmwbqzptt.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406115795-24082-4-git-send-email-pclouds@gmail.com>
	<53CFBD2A.9030803@drmicha.warpmail.net>
	<CACsJy8DwPM68j-=LDDbq1H_bT1gD=aLQ8x6C1qiwF79=ai14dg@mail.gmail.com>
	<xmqq8uni8mx4.fsf@gitster.dls.corp.google.com>
	<53D1FE76.5080708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:03:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCYEF-0003OV-T2
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 20:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbaG3SDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 14:03:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61465 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755021AbaG3SDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 14:03:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 00FC22A952;
	Wed, 30 Jul 2014 14:03:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mp+rudDMbPCvidmeU9uyg7mBVdo=; b=bnRWf6
	gBRk+HH4y1p+Oq/w2kh03IRwTqLpUzHK20sfICR0fDVDHM5cjPij5dT17VfBORb4
	QEkkqWmplJkkExvI8KsrIpbeEo1849o5fQQKqaFGV/oYfx+AsQitZ34b3lUcClXY
	GYJS9ZJLXY8KM5YyMSo2r8fZXHN1A9rgFbp4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mMHqT/ADAioV+dHr/QmEl3Gwhp9Z2cq3
	q9H+e2fFLVDSkkG03tu5koG7Sj2CSkJ+hKoIGc2z76hizyypzFqie9SWVG8CYazD
	7mT4xJyFIqo5vLS2zxsuCJUKXnJKHFwhrDCvRUNVCr27owS4NODGYRRZA53PRjy5
	F2HX3O9ywAM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E99A22A951;
	Wed, 30 Jul 2014 14:03:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 75E472A94D;
	Wed, 30 Jul 2014 14:03:44 -0400 (EDT)
In-Reply-To: <53D1FE76.5080708@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 25 Jul 2014 08:51:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D8935938-1813-11E4-8C5B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254505>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> As an error message that is completely sufficient.
>
> The advice messages are meant to teach the user about the normal parts
> of the toolchest to use in a situation of "conflict", aren't they?

Not really.  They are to remind (to those who learned but forgot)
and to hint (to those who haven't realized they have things to learn
in this area).  Wall of text that tries to do more than that, like
"teaching", risks not getting read by anybody.

> Maybe
> we should ask someone who hasn't turned them off...

Actually, I run without most of the 'advice.*' turned off.
