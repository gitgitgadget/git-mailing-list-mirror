From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issues with cc-cmd
Date: Mon, 15 Feb 2016 02:06:01 -0800
Message-ID: <xmqqh9haqody.fsf@gitster.mtv.corp.google.com>
References: <20160215082746.GH6334@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Joe Perches <joe@perches.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 11:06:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVG2o-0004W5-Jg
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 11:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbcBOKGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 05:06:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751005AbcBOKGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 05:06:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4674A3E9A2;
	Mon, 15 Feb 2016 05:06:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aSHcvYpqQ5I+Ek33y3kVJf+wzSI=; b=CQcnMl
	ZSBjzpo1SWycwRzi7/77S9I7PQg/fUt4I9YlCYC7bDEEwkP8lX1as0VAsV7EeWwE
	ps6HzQUUbZTZjKpaOWLmcZp8HQMbFFJwb4Xwd9tTljo7S0cnUneToZeEzNTxGCSH
	G/yWIGAOclkH2gstKI0w+J0TUx9QjsVdmUnjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XiKu0iQukga8ecpyEJ/BnyMB3dPYOUX+
	19cskyrP9hNanrpHQeAx+Ooi/gg/yqV+T1iiZa6XPk3bKvge/hooiw93fXIvbY4U
	jSpVkpI4SDbskaTyb/aFU7LZ/0X/qouRAwe2p9uJS6p3VkgXwW/sP+ksxpMue0l5
	xmTS1rUTMGo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F3343E9A1;
	Mon, 15 Feb 2016 05:06:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB13B3E9A0;
	Mon, 15 Feb 2016 05:06:02 -0500 (EST)
In-Reply-To: <20160215082746.GH6334@vireshk-i7> (Viresh Kumar's message of
	"Mon, 15 Feb 2016 13:57:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8414A62-D3CB-11E5-8CF0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286194>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> linux-pm@vger.kernel.org) (open list:OPERATING PERFORMANCE POINTS
> (OPP),

Hmm

http://lists.kernelnewbies.org/pipermail/kernelnewbies/2014-July/011343.html

comes to mind.  It tells you not to blindly automate this process.

I do not offhand know if it was even designed to be directly used
(and usable) as a cccmd, but anyway, I see this mention in its
"Notes:" section:

  Using "--roles" or "--rolestats" with git send-email --cc-cmd or any
      other automated tools that expect only ["name"] <email address>
      may not work because of additional output after <email address>.

I suspect that what you are showing is the "additional output after
address" the above talks about.

In any case, this command is maintained as part of the kernel, no?
I see Joe Perches signed at the beginning of file in 2007; I do not
know if he still maintains this script, or somebody else is
primarily enhancing it these days (ehh, I probably could use the
script on itself, but I am way too lazy late at night), but asking
him would be a good starting point, instead of asking here.
