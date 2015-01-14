From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault in git apply
Date: Wed, 14 Jan 2015 10:50:58 -0800
Message-ID: <xmqqiog99ox9.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:51:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBT2J-0000Oq-Rv
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 19:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbbANSvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 13:51:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752184AbbANSvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 13:51:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AD562CE00;
	Wed, 14 Jan 2015 13:51:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYy5HI4D+o7NCd3icDA5EPZOpss=; b=pyUrV0
	Vfz2BFnWokmw3/SRzonC1hVwPdZ8liuWaoYY9Fz8aP3AIS9tUYuQ6Dc0p7+3C9uG
	cgCzQjbwPH0dBoNT5aDoSl4ZOtwvMeNEtI0ZXZpJD0pNC+Gdgshd9W9L9lnyw+bq
	dCsOsO28YEA9kdZnS0NBPxHAjrQnjzDcEVAHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cj3UNuMRYWeU34ao+j9dEgHGcsJPcfie
	aE4H0LLGL2QhH8gDh33a6tItTx/j02U5+tNlIGf21co0Y1oac8QhvmRzTNnCXLgZ
	3+rA+DBmPCCzu0McLssSjcqJ7iUX+9T+1LSVz1EbTmuntFhCbQ1ATJSWXJ1QTnai
	DpW9NjznM8Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 603FE2CDFF;
	Wed, 14 Jan 2015 13:51:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F2A02CDF5;
	Wed, 14 Jan 2015 13:51:00 -0500 (EST)
In-Reply-To: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com>
	(Michael Blume's message of "Wed, 14 Jan 2015 10:20:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 48309B00-9C1E-11E4-98C8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262410>

Michael Blume <blume.mike@gmail.com> writes:

> This is a mac with a fresh build of git from pu branch, commit 53b80d0.

Hmm, I do not see anything suspicious between master and pu.  Is it
possible to bisect?
