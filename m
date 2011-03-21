From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git rm" is not a valid merge resolution?
Date: Mon, 21 Mar 2011 13:24:52 -0700
Message-ID: <7v1v20p6gb.fsf@alter.siamese.dyndns.org>
References: <4D879882.4070608@gmail.com>
 <7vvczcp8w7.fsf@alter.siamese.dyndns.org> <4D87AE83.6080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:25:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lf0-0000re-MK
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab1CUUZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 16:25:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab1CUUZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:25:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76CDC4832;
	Mon, 21 Mar 2011 16:26:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oQW9NsjP5OPeRf9XQz0CuIoshv0=; b=XloGTF
	0pDEcIS35mu+KuJNvK4Bj53vkobi1OGOdDJo9+q4Zb7svAytJynwbYq1G8PMM3Ld
	pJ5YkSEj8KuR6mN+XtxmP7RdMlxJoK1ZnCrg7ckW2RICaB8loIahL7oTDShx3Ub4
	XYvTSzJpFj5nSqATzL5IKZtxX1Kba996cQiDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=crgfd/xL/1anpYcSIMV6HeUNGtjBrOnS
	yKQ/yyKAwtTBzCdtW4ZrQsvuw1k6CRCu3DvyKqawA7mND72fVluOsZoaFQEZ9kC5
	xdvW7YSnG98M2kuTl5Lmn9NC5/VVIEHOh0S/WAFi8KioXnQh2u7raHG6Iu/2u8Z9
	Ty+/UqqUgcw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55A6B4823;
	Mon, 21 Mar 2011 16:26:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 72A504820; Mon, 21 Mar 2011
 16:26:33 -0400 (EDT)
In-Reply-To: <4D87AE83.6080008@gmail.com> (Piotr Krukowiecki's message of
 "Mon, 21 Mar 2011 21:01:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84E39654-53F9-11E0-A771-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169662>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Please see my other mail - file deletion can also be done by "git add". 

So what?

While it technically is correct that "git add" can be asked to do so (and
no, forbidding "add -u" from noticing deletion or renaming the command to
stage to spread the confusion even more is out of the question), people
found that it is more natural to remove things with "rm", wished to have
that separate command, and the wish was granted.  We suggest its use when
it is appropriate.

What is your problem?
