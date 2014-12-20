From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --graph --oneline issues (very small edge case)
Date: Fri, 19 Dec 2014 16:53:07 -0800
Message-ID: <xmqqa92jcfbg.fsf@gitster.dls.corp.google.com>
References: <71B93170AE5D4ED08EF12CED427299C4@black>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Jason Pyeron" <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sat Dec 20 01:53:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y28Ia-00076Z-8R
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 01:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbaLTAxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 19:53:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751003AbaLTAxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 19:53:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EA7128749;
	Fri, 19 Dec 2014 19:53:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KAp+NO6wqSHpAj5KVN4NgpCGq4k=; b=NiEo7V
	6Ks7Ojr/HuAx+bltO3746GJ5DQHeyEloRZMwbFzOAC+x5YkQPzoWp1AsbmLbJDse
	uJ61XHg6g6lRDTZP75kplTbHfnd63ffHmGow8oBjSV1i3mGJLrGnjGJryhC0ED5p
	5Lk+9TlQ/0mTycTFl7X9OzcW+DjjfxZm0+pj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lrnLbHbIo9Zk4lFyNT9mnz2A1CZGd71/
	kLYmIpaS0gq7FEPk0PUGgGBuU8cJLrw7ewpFOtulo3Nsa5UmeL5qkdYXl9msEIv/
	o+bWLzi7nMwQYUZrHxz42jhqJ0p4Wxxz8k4ANx6WG4kWEHlKueVVdycOes3lJabX
	N9xfr7ZqPvg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CA1828748;
	Fri, 19 Dec 2014 19:53:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3F4828747;
	Fri, 19 Dec 2014 19:53:10 -0500 (EST)
In-Reply-To: <71B93170AE5D4ED08EF12CED427299C4@black> (Jason Pyeron's message
	of "Fri, 19 Dec 2014 11:27:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9204AE60-87E2-11E4-838C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261598>

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> When a repo has multiple initial commits, the oneline graph can get borked.
>
> It will put a commit * with no parent directly above the next commit *
> with no children. This gives the false impression that the two commits
> are a sequence on a branch.

Sounds vaguely familiar.

http://thread.gmane.org/gmane.comp.version-control.git/236708/focus=239580

My preference is what I wrote after three-dash lines as "It may
actually make sense ...  If we did so, the output ... may look like
this" there.
