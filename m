From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: git p4: feature request - branch check filtering
Date: Tue, 22 Apr 2014 09:46:32 -0700
Message-ID: <xmqqoazt71nb.fsf@gitster.dls.corp.google.com>
References: <CADtnS+zWzPY6ftwxWUE+Gb-OKq_Kzf9y+fFfgJ-demWyX3azCg@mail.gmail.com>
	<CADtnS+weco6Lvk3hHuM7BcaRsvMkeDCmqH26s19TrgWvBYXAvA@mail.gmail.com>
	<20140223151247.GA1272@padd.com>
	<CADtnS+w9q0dmnGsZoDr12GZ-RSZzcfPs6rfii-4eK7Hhn2byag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Dan Porter <dpreid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 18:46:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcdqM-0002QL-My
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 18:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933390AbaDVQql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 12:46:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933080AbaDVQqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 12:46:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FCF37F437;
	Tue, 22 Apr 2014 12:46:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SlJUmsnXWSufrxhaey2dMYs70wE=; b=SNsMhy
	ujbnxyHc/f6VvqA+Rkn2NADztrBa9GzUV4tSowLtM/c5w2MHyGvBUAqoU6QE4S17
	syLZQbcNDo4tOJNmj88xW0fSbibE9ZYbQJrWsooQEwwuMt0FkSw6UmJcTiWHW3U7
	SWAPlNmEXcMFfsX5UO9r69Muieg8m8xgzb5HE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BFW+A4Dv9qtgjbmde8EGUDOVSrAPOzl5
	7L7RVlYCdKfxioyRMoJ+OWCsZv46nc9gfXL7ERBiqEYoKOUoCEOH+6zrs1VGV1dJ
	dVZyaF0IXHftdORlrozaCIKqGhUXkliPMo8/2+5oTFeble5dV5FgZdmaEbLBw/nk
	dZES8Y/vJjI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 366687F436;
	Tue, 22 Apr 2014 12:46:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CE117F433;
	Tue, 22 Apr 2014 12:46:34 -0400 (EDT)
In-Reply-To: <CADtnS+w9q0dmnGsZoDr12GZ-RSZzcfPs6rfii-4eK7Hhn2byag@mail.gmail.com>
	(Dan Porter's message of "Tue, 22 Apr 2014 10:29:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A9FA6522-CA3D-11E3-BFDB-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246751>

Dan Porter <dpreid@gmail.com> writes:

> I should have updated on this earlier, but I wished to refine my work
> on this feature before submitting.  With 2.0 looming I'll submit
> what's there so far.

I am not Pete, but...

The pre-release time is to find and fix regressions that may have
been introduced since the last release while we tried to add new
features and fixes to 2.0 until now.

"With 2.0 looming" is not a good reason to send out a new work.  In
fact, if 2.0 is "looming", it is already too late for the upcoming
release.  Of course "With 2.0 looming" does not mean that you must
not work on things that are regression fixes---it is your own time
and effort, and it will be great if that can help later releases.

Thanks for contributing anyway ;-)
