From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Tue, 28 Sep 2010 20:37:36 -0700
Message-ID: <7vfwwtrzi7.fsf@alter.siamese.dyndns.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
 <201009282252.25688.j6t@kdbg.org> <4CA2A32E.3050802@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 05:38:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0nUX-0005Qa-HG
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 05:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab0I2Dhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 23:37:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab0I2Dhy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 23:37:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64041DAD58;
	Tue, 28 Sep 2010 23:37:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5dJcNORi4y33gnGMKiO9DshIy9s=; b=j1/6HV
	PaL5NYwAEythsVCEmmESQWAANVVF74VH+7+AQeL9oegRA2RTacmRH5erpf4KMTvR
	HXz8GLIDO6onjm0hDcha3vFt9Ax1m1dW1fmUNelU7gC4CoiIyE5+IJy0E6YUFjXI
	l3hovmwaVI3cvN6B/qypyZShlLe+sZlyla5EI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UWWgfEDwukeA4P1tZS44Q1KfxIwRtems
	XgvqExb+CV8eR1qGyGBvQ8ySwx7DqqHlmImb6tmNKZr+WIvSLoXSiM+4LOCwTJ3n
	+RSvDFOu1KaZ2qWnF+/RzP8Ig3RAgvqvwUk3jq7O6TFemnnHeCFnBw5uj8YUvutC
	TqeXRXJNo4k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8E77DAD57;
	Tue, 28 Sep 2010 23:37:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D88B0DAD54; Tue, 28 Sep
 2010 23:37:37 -0400 (EDT)
In-Reply-To: <4CA2A32E.3050802@sunshineco.com> (Eric Sunshine's message of
 "Tue\, 28 Sep 2010 22\:23\:42 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EBF054F2-CB7A-11DF-960D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157522>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I also normally avoid unportable 'export foo=bar'. In the particular
> case of GREP_OPTIONS, when commenting on my original patch submission,
> Dscho suggested 'test_have_prereq MINGW && export GREP_OPTIONS=foo' so
> that is the form which made it into the final patch.

Well, since bbc09c2 (grep: rip out support for external grep, 2010-01-12)
we do not run external grep at all, so GREP_OPTIONS is irrelevant.

Unless you are planning to run tests on installed version of git older
than v1.7.0, that is ;-).
