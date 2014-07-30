From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] nd/multiple-work-trees follow-ups
Date: Wed, 30 Jul 2014 10:51:47 -0700
Message-ID: <xmqqr412zqdo.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 19:52:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCY2j-0001TQ-0G
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 19:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484AbaG3Rv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2014 13:51:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51276 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371AbaG3Rv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2014 13:51:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDE152A549;
	Wed, 30 Jul 2014 13:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Uxa4JwM+VQz5
	HNeavJxGXAls96o=; b=dzkWTDvbD7gLu74DX3F6So7QqOTg5onQsV3RXaOjQ/bd
	JKcdksIwpK+TLYtYp9QzttkmraZRg0W6HqoEpyEWR8fAMXX0cX+jZIGhbDRGc9iE
	BI1XmUaJxagdRpQ92uMiLuqsA7LVPBqo+bTsX7zrRuVB0Yew0zgPqGTE80HbP5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sD//35
	EgG/8lvhOIDS8l08cFoz6TYCtru8DdEdw+uYHUuYzWF0Me2qOMAn3K5m3JJERW7e
	qz7Vm2EUVMibI42XoIIPTaYtaGFxXSn12mXqNiQLQK9h6eJUlJGAHPyCkoW8hs6m
	8UpXEEDtmooZxcTZSAM7QES4WMWNcyOMFxoIk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E40DB2A548;
	Wed, 30 Jul 2014 13:51:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 944502A542;
	Wed, 30 Jul 2014 13:51:49 -0400 (EDT)
In-Reply-To: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 23
 Jul 2014 18:43:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2E7A704A-1812-11E4-8B3E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254504>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> The series has entered 'next' so I can't replace patches any more.
> Besides the brown paper bag fixes, checkout now rejects if a branch i=
s
> already checked out elsewhere.

I do not think we would want to rush the entire series to 'master'
before the upcoming release, so we could squash these fixes into the
original when we rewind 'next' post release, if you wanted to.

The fix-ups are easier to review than wholesale replacements; keep
them coming as needed.

Thanks.
