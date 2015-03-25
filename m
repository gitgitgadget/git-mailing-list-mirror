From: Junio C Hamano <gitster@pobox.com>
Subject: Re: about Starter project;implementing log --size in the print_commit function.
Date: Wed, 25 Mar 2015 09:13:40 -0700
Message-ID: <xmqq1tkd3vij.fsf@gitster.dls.corp.google.com>
References: <CABJeaiqhL5eNPkaPpheG_Y47Rapj4ys3igHhFH6YuiroECVGDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Shanti Swarup Tunga <b112041@iiit-bh.ac.in>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:13:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YanwC-0003ZK-22
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 17:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbbCYQNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 12:13:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751602AbbCYQNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 12:13:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C139741117;
	Wed, 25 Mar 2015 12:13:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CsemSi4WkcoQRBMbCff+EkvAsz8=; b=wi6Com
	Ojwg5VPqIqPC8ppexxobRTupNzUj+m1JfIRgHBVHBMaoA4o4ihY4p4tieLiXO1ph
	CmE4/h9enc9iCQ7yrCxjhHqr0hMCTKV/WQqC3SUSEgwUxwI4uTRkHAg8EFJVxv3R
	EnI6+KgQFjgCNCZdlzDJDEgXpkx/g/vGVwr1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ryegJpvMGRxEpMn9iHn02HXjeSNbmDCV
	GtSpUEuVYNsW9jf9ZGb5bltHEOw20OgC+Etq7kXuGGo4uW4CbX6ILP1HrEEQ4VM5
	FU7gpb0qXT+f6DMGvGry1bG5tl5PKhw7TKrHlIFMz/A9D3FfgBhLWl5ozeE34YZd
	/PilJ/ESC4o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9A9541116;
	Wed, 25 Mar 2015 12:13:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D14E41112;
	Wed, 25 Mar 2015 12:13:41 -0400 (EDT)
In-Reply-To: <CABJeaiqhL5eNPkaPpheG_Y47Rapj4ys3igHhFH6YuiroECVGDA@mail.gmail.com>
	(Shanti Swarup Tunga's message of "Mon, 23 Mar 2015 20:45:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E70F0488-D309-11E4-B349-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266282>

Shanti Swarup Tunga <b112041@iiit-bh.ac.in> writes:

> I inserted a size variable of int type and calculated size in each
> cases of print_commit(). The function is
>
> static void print_commit(git_commit *commit)
> {
> ...
> }

See Documentation/SubmittingPatches and then also CodingGuidelines

Especially, explain:

 - what does this change try to help and how?
 - why is this patch a good way to achieve that goal?
 - how the users are expected to use the new feature?

in the proposed log message, run existing tests to make sure your
change did not break the existing system, add tests to make sure
you would notice if somebody else broke the feature you are adding
in the future, and describe the new feature in the documentation.

> Will that approach is going to work for the following problem.?

Was your message cut short?  We cannot read "the following" problem
here...
