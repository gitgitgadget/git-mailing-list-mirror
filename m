From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2014, #02; Fri, 6)
Date: Mon, 09 Jun 2014 11:50:12 -0700
Message-ID: <xmqqvbs9ex3v.fsf@gitster.dls.corp.google.com>
References: <xmqqfvjhpsn9.fsf@gitster.dls.corp.google.com>
	<87ha3xtctj.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 20:50:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu4eI-0000kh-Rg
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbaFISuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:50:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55299 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785AbaFISuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:50:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAC3F1C5E5;
	Mon,  9 Jun 2014 14:50:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7zNWls09X7+K0UySBSVSMEXcXOE=; b=EpQ5GD
	xa5AAyoXnjxfhPUYLWvgOerhIT5ukzPKXzL+4Wv6jVWbgJ5j/zYZEylpehKj5Hwr
	yvlGp/ASmLD7FO+7AbvYbkoLxOQPYEiW6jCOdkv0DOXvIWKo6tcDiXuWbsmMX6wS
	6rW4uSiG6ZfV6HTQZPwfyjoOfpozrDTymGzi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ccH2K43q73k0JbZET6pil7nvU06obvAp
	AC4nATFOYhcXfyIqtWTuxR4Pr47kgbxcq12w04Aap9V6A3Ls9jIdE61r1prMxeHV
	Pun6VS2IykYbe+ZX3kgeGMe8BgpTLZjGpysSjx5TWRzOYhYqw1XpuN2hlks+1PlM
	m3EEWYEt9WM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDDDB1C5E4;
	Mon,  9 Jun 2014 14:50:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CA2DA1C5E2;
	Mon,  9 Jun 2014 14:50:13 -0400 (EDT)
In-Reply-To: <87ha3xtctj.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sat, 07 Jun 2014 09:10:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E4170938-F006-11E3-9C17-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251102>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  "git blame" has been optimized greatly by reorganising the data
>>  structure that is used to keep track of the work to be done, thanks
>>  to David Karstrup <dak@gnu.org>.
>
> I guess that "reorganising the data structure" for months is not worth
> the trouble of getting the name right.

We do not usually name people in particular in the release notes
and/or the "What's cooking" report, and trying to do something
unusual misfired X-<.  Sorry about misspelling your name.
