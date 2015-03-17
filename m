From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule: update=!command
Date: Tue, 17 Mar 2015 14:05:10 -0700
Message-ID: <xmqqtwxjmj21.fsf@gitster.dls.corp.google.com>
References: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
	<xmqqy4mvmjs9.fsf@gitster.dls.corp.google.com>
	<1426625989.1809668.241718517.07249CD6@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Mar 17 22:05:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXyfw-0006y4-8J
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 22:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbbCQVFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 17:05:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753365AbbCQVFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 17:05:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47CEF3F5A9;
	Tue, 17 Mar 2015 17:05:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Arj952h9Q27lvSPAK3p1LQiJ7I=; b=XJRq8J
	WXFgwet+NIv4W9Hzb4MnNr2VdpzdiVcwvwjtLjtJCRul4OAkECMGK1kiBd8nLbRR
	O87J/VJGdj2J1Vhku2DT3UzuLqQf1KM0Qea7yODBvTbDhIdq9xV4lN4oN3k98zn3
	36HxofBnlU/EBDmgAkI4x7l2WIVSvIJbnPdgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aD5QsbLpn/gc69vGoStPhkdt8XUMT254
	Kr/eDxmvr/PcNcwcih0DKju7YlE+IRrrbkVvEXQUOfJ4WM0LXsCTKJtYeDCrjdEW
	+Oc+2Jx1BICiVwGvaHjOY4tjJBG5WvwnbtIXXnMlYM9eeI+yBbbHBayMNIid4cW9
	9v99jRNhExk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FEAD3F5A8;
	Tue, 17 Mar 2015 17:05:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF2673F5A4;
	Tue, 17 Mar 2015 17:05:11 -0400 (EDT)
In-Reply-To: <1426625989.1809668.241718517.07249CD6@webmail.messagingengine.com>
	(Ryan Lortie's message of "Tue, 17 Mar 2015 16:59:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CECC6D6-CCE9-11E4-831B-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265668>

Ryan Lortie <desrt@desrt.ca> writes:

> On Tue, Mar 17, 2015, at 16:49, Junio C Hamano wrote:
>> With more recent versions of Git, namely, the versions after
>> 30a52c1d (Merge branch 'ms/submodule-update-config-doc' into maint,
>> 2015-03-13), the documentation pages already have updated
>> descriptions around this area.
>
> sigh.
>
> That's what I get for forgetting to type 'git pull' before writing a
> patch.
>
> Sorry for the noise!

Nothing to apologise or sigh about.  You re-confirmed that the old
documentation was lacking, which led to an earlier discussion which
in turn led to Michal to update the documentation.  If you check the
output from

    git diff 30a52c1d^ 30a52c1d

and find it appropriately address the problem you originally had,
that would be wonderful, and if you can suggest further improvement,
that is equally good.

Thanks for participating in our effort to collectively make Git
better.
