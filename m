From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git release notes man page
Date: Tue, 18 Feb 2014 15:05:58 -0800
Message-ID: <xmqqtxbwaund.fsf@gitster.dls.corp.google.com>
References: <1392460179-776-1-git-send-email-philipoakley@iee.org>
	<xmqqha7wcbkz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>,
	Stefan Nwe <stefan.naewe@atlas-elektronik.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Feb 19 00:06:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtkb-0002nj-7G
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 00:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbaBRXGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 18:06:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbaBRXGM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 18:06:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9C506EDFE;
	Tue, 18 Feb 2014 18:06:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WgIB7CQ0lUx0IivdRIyS4CzndQE=; b=FCjJZo
	rMKo59AqYBLf3lEcHlnRX7/Mfz47tT3JBvRY8H9X3DXIGQqKsfk786a8GGNXVS6Q
	cAlAo/GYPJkvGo7DLZyRSvTtOu81U3SH4UsmKYL585+XZMAV83jj3P0Xy9EyGQ73
	zKw25lwMqUx2YC3zxxI7KLLgjd2SOUCrk9GHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jDLklqudekyBEWxAKPxru7Qf3m9o89iF
	PBGe7GxG7MBpqdNku5BI9cdGOAMMR5bEKZ++q/9RMmfCLif9jZbu/dJ7bydl5Auu
	3EOiwHRJVhRFQ/LlLPcUxPRaJRP93wLocYrVTDQUGtcvBV2nS4DzVxq9YECGvOjR
	NmQKpqHFmv0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A33436EDFC;
	Tue, 18 Feb 2014 18:06:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 934476EDFA;
	Tue, 18 Feb 2014 18:06:00 -0500 (EST)
In-Reply-To: <xmqqha7wcbkz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 18 Feb 2014 14:14:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3B9FEEA8-98F1-11E3-8F62-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242372>

Junio C Hamano <gitster@pobox.com> writes:

> Philip Oakley <philipoakley@iee.org> writes:
>
>> A few days too late for the 1.9.0 release cycle :(
>>
>> This responds to Stefan Nwe's request for a 'git help' command that would
>> access the release notes. ($gmane/240595 17 Jan 2014).
>>
>> I've used the full name "release-notes" for the help guide rather than
>> Stefan's original 'git help relnotes'.
>>
>> The release-notes man page lists just the notes for the current release.
>> The combined notes for all releases is nearing 15k lines.
>
> RelNotes are incremental and only useful for those who know what the
> immediately previous release contained, but for most people who get
> their Git from distros, I have this impression that the versions of
> Git they get skip versions, and seeing the notable changes since the
> previous source release will not give them wrong information---they

Ehh,, s/will not give them/will give them/; obviously...

> may have this warm fuzzy feeling that they know what is going on,
> but they are missing information on all the accumulated changes that
> were added in earlier versions their distro skipped---these changes
> are still in the version they are running.  I do not understand why
> it is even a good idea to show release notes from the command line
> "git" interface.
