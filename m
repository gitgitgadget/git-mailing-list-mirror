From: Junio C Hamano <gitster@pobox.com>
Subject: Re: COPYING tabs vs whitespaces
Date: Thu, 04 Feb 2016 11:15:08 -0800
Message-ID: <xmqqsi18i8xv.fsf@gitster.mtv.corp.google.com>
References: <56B32BDA.4010909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Petr Stodulka <pstodulk@redhat.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:15:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPN9-0007WR-G6
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984AbcBDTPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 14:15:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756943AbcBDTPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:15:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 701CE3FD8A;
	Thu,  4 Feb 2016 14:15:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=29gPU53tscFxuFJlojGcN5yu6pI=; b=gj6eDU
	b/G9iPl5yk+/diD8H0vr4lZmM1ZBJG+cvQCMhCamtitKZO409V+KuUUsfqr4p8zz
	eu1xQc9CQb7pnOzNIPcwHL5hPaXV0uhxPcyljoVFgi0fIlVCDQNh5IB/Rc/v73OK
	WC+dn7kBPcLD1eK4NxQwm3n/Ob1hb8L1QonyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uo8NpTYgq9AXUXZrI4XbEsFM66zpT1jc
	BcUGt1QiRrUxNR0p1B4Q5ouvLe0b4qRvAquMbbpVK7EzxtmRiKYIJoxVja2igdKG
	6JP0W0VrQtZ5cJXYaQe8cFKg/nQKrinc4rKAer73Yg4vi4ZVNcPJOShiTeA4l6e6
	9FxoC9gT9PU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 671853FD89;
	Thu,  4 Feb 2016 14:15:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C15093FD87;
	Thu,  4 Feb 2016 14:15:09 -0500 (EST)
In-Reply-To: <56B32BDA.4010909@redhat.com> (Petr Stodulka's message of "Thu, 4
	Feb 2016 11:45:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9BAB3D50-CB73-11E5-905E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285479>

Petr Stodulka <pstodulk@redhat.com> writes:

> I found that license file COPYING is different as compared with
> http://www.gnu.org/licenses/gpl-2.0.txt If I pass over with
> Linus's preamble, change is only about whitespaces - tabs
> vs. space.  Probably it's minor non-essential change, but some
> projects do this change, so rather I ask about that.

Interesting.  I cannot quite connect "some projects do this change"
and "so rather I ask".  Are you asking why this project changed it?

After running "diff" between the two, I think the changes are only
on the indented section title lines, and "git blame" tells us that
the section title lines in the copy we have has always been that way
since Linus added to it at 075b845a (Add a COPYING notice, making it
explicit that the license is GPLv2., 2005-04-11).

So, perhaps the copy Linus got originally had leading runs of spaces
that are multiples-of-8-long unexpanded to leading tabs back then,
or perhaps he did that unexpanding himself.
