From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting started contributing.
Date: Sat, 02 Feb 2013 23:40:05 -0800
Message-ID: <7vhaltalre.fsf@alter.siamese.dyndns.org>
References: <1359872508519-7576834.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: adamfraser <adamfraser0@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 08:40:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1uBz-0007m5-6f
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 08:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974Ab3BCHkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 02:40:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab3BCHkK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 02:40:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BB2451A5;
	Sun,  3 Feb 2013 02:40:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/wrhmyZgoQYrW/1uCIDmOlXmcLI=; b=YQDhQA
	laDB7Abb3groH/0shJA/V4l97uRIjqa7aXIPx7JC03m0XZB08K4MUA0VeWbXHaxJ
	0dhoQe8JNzOuI9LA8NCxJhbbyjZ6JsJRZyrythzHH6YZTOZBRmRbEga3pjidkp4K
	LNUkRexzHrXDci1DbWqOsA9pdjrZ70nCzMc5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BISXHSvg5HYnyRba5r3NdMvGtDORxulG
	QGvLUlvin9V9twZ40vdzOufw27hxiqxSeD6O1KQveFRyZep1334VxPsBorlJ0nrM
	tqJCof8Rx8cnH5uBFVI+b2s/LHeDZjJlFGwNPM1/+ZueX+OSBUO6TYEELIWqnC9r
	4NlaI4vIdaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F36F51A4;
	Sun,  3 Feb 2013 02:40:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3DDD51A3; Sun,  3 Feb 2013
 02:40:08 -0500 (EST)
In-Reply-To: <1359872508519-7576834.post@n2.nabble.com> (adamfraser's message
 of "Sat, 2 Feb 2013 22:21:48 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF1EB75A-6DD4-11E2-B877-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215303>

adamfraser <adamfraser0@gmail.com> writes:

> I would like to start contributing to git and am looking for a small project
> idea to get started with. On the  Small Project Ideas wiki
> <https://git.wiki.kernel.org/index.php/SmallProjectsIdeas>   site there is a
> suggestion for adding a 'git rebase --status' command that sounds like it
> would be good for someone who has little knowledge of the code base.

I think the two patches Duy just posted tonight overlap with that
topic, and I suspect it would give the end users a better experience
to put the information in "git status" output rather than a separate
"git rebase" subcommand.  Perhaps you can work with him to see what
other things his patch may have missed can be improved?
