From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] realloc failed
Date: Fri, 20 May 2011 18:35:58 -0700
Message-ID: <7vhb8o25tt.fsf@alter.siamese.dyndns.org>
References: <20110521100126.E3CD.BA9123DE@callcc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kazuki Tsujimoto <kazuki@callcc.net>
X-From: git-owner@vger.kernel.org Sat May 21 03:36:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNb70-0005tm-9D
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 03:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab1EUBgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 21:36:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab1EUBgH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 21:36:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 83EC748F7;
	Fri, 20 May 2011 21:38:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b4kywWWhYU80n6RbNm+kVopKYkk=; b=AiI6LF
	BXleYRKv9X3FfamRPEuiQq+0qOYd/pUfMGapiT8aDja0dJzzSW4NdrSBRRrWFeA6
	TvWiDxgfKVdhV+HXVr8HH5A/3qB5Vvot4YN5GDrMdBjFd9j5mEurYQ6C36VKJW1t
	GcL21LAYHFZgnXtM5aWNbAdvVmWyzvXEHHHSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWLzI6Cyq52NVT4B1G/OQJcnjeEo/3Qc
	IJOb31pGm7dYyT0RIM6+ad4zIMSeiU9H7K1zCq1ZuXjVGtbfu6UG3uc43hKg9dg5
	EjzfCVbfHgeZOdnXS7EvKlzVOPIV/OyYdiFLY0GMBKVzWO2O584fjfcTuiCGtA7Q
	goXrq0OktKI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6110B48F3;
	Fri, 20 May 2011 21:38:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8520348F2; Fri, 20 May 2011
 21:38:07 -0400 (EDT)
In-Reply-To: <20110521100126.E3CD.BA9123DE@callcc.net> (Kazuki Tsujimoto's
 message of "Sat, 21 May 2011 10:01:32 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC33F02A-834A-11E0-A5DB-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174086>

Kazuki Tsujimoto <kazuki@callcc.net> writes:

> The following command causes "fatal: Out of memory, realloc failed" error.
> ...

Care to send a patch with test (see Documentation/SubmittingPatches)?

Thanks.
