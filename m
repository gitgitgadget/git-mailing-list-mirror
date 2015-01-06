From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] format-patch: Add config option format.coverbodytext to change the cover letter body
Date: Tue, 06 Jan 2015 14:35:36 -0800
Message-ID: <xmqqa91vo7uv.fsf@gitster.dls.corp.google.com>
References: <1420486105-30242-1-git-send-email-sbeller@google.com>
	<xmqqzj9wp52y.fsf@gitster.dls.corp.google.com>
	<CAGZ79kabhx1q2pxY0_UXAy64G94GQZaP4nSUgeUjV0c_sjt+QQ@mail.gmail.com>
	<xmqqd26rpwjg.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE+zBgYANE8+NppnBsAVfLXPdgxnvFRbLdMkafSqduWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 23:36:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8cj6-00032h-Q5
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 23:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbbAFWfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 17:35:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767AbbAFWfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 17:35:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 798B12CA4F;
	Tue,  6 Jan 2015 17:35:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oa1vadbkua/o1pxuufSS0NJh/UE=; b=lPVewT
	GTFucJdDif+RRp8Af96M+cYoYLvbN0ykJIhpWsh92BX4LOGp0pbr0SvNAied30qi
	MhGYuwk7VIaj48g5Txl19t5AYSS5GRSEI1+LolRntnbT32N9phAORIYX8OEyUCZk
	Nrmf7HpOcp+FgGI4eYFtsKcj7g0d/Fr538UkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UvD28sVNBqN7mhu0f0wubI1LIz13APEo
	4BwTtO4Xh9QxXHtjs3q7Q1SaxY+4nJOIT9xTO1YfJbFXbEFfLvEyAxYwKPazaw+C
	CX3vqVJjfl4+5V+zmbQ8feWhRL9QJAsUJYXtfsrujAukqIhwzKUdi2V/4/jxP6qN
	aYBZSp2iXWs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70FC62CA4E;
	Tue,  6 Jan 2015 17:35:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B6CB2CA43;
	Tue,  6 Jan 2015 17:35:38 -0500 (EST)
In-Reply-To: <CAGZ79kZE+zBgYANE8+NppnBsAVfLXPdgxnvFRbLdMkafSqduWA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 6 Jan 2015 11:14:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5659EE14-95F4-11E4-B1F9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262104>

Stefan Beller <sbeller@google.com> writes:

> So before we drift into more discussion, I'd still think it makes sense to have
> the ***BLURB *** replaced by some configurable questions regarding the
> series as a whole, so I'd try to perfect that patch?

So far, it is only you and me talking about that feature in response
to your request for comment, and I am personally not very interested
in it, at least not yet, so it's only you at this point.  That may
be because of new year break, or that may be because people do not
think it is worthwhile to only replace "**BLURB***", or we may have
to give others some more time to chime in.

Don't get that discourage and stop you, though.  "This was written
for my own use, friends with different workflows picked it up, have
been using it and it made their lives better, and I have been using
it myself for a few weeks while polishing it to help my own and
their workflows." might be the best way for a new feature to come
into the world, and you can do that "polish to help my own" part
without having "them".

FWIW, the format-patch itself appeared at the end of May 2005 and
after having been ignored by Linus for a little more than a month it
landed in early July 2005 ($gmane/4324, $gmane/4843, $gmane/5446 and
$gmane/5677) after exactly such a process.
