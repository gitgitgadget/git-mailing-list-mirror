From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Fri, 09 May 2014 12:58:46 -0700
Message-ID: <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
	<1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 21:59:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wiqwc-0004nu-QQ
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507AbaEIT6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:58:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60336 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757229AbaEIT6v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:58:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CE7815CDD;
	Fri,  9 May 2014 15:58:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5WSeQyd2hq2OecgYmTg65K2k9kQ=; b=FFQtvq
	Nr1HQs/Qzt4Vufg+ZdDq+OCNO74w900W77BFW5lDiegy7xx+wI8lj1NvBLz0pO02
	+6TlroQJdQP1E6xdm5c8y/hEMWrvMT0cHkWrryt5etCAjEmJPgxuHJdyY33IjUnr
	4KFuQwlAQ+vVxgtnEuQGHMPO3MO/2Yh/52ZtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kTE36lhjIOCHxDFAR3eH2DyIh1mF1aiQ
	JVAhnTte1q0d2HXm1svbMqTUihN4Elk+WR+0n+VL243JJ/GcoE8lPZ1XHQGyyQ+J
	zgYhRLtbxcGPft3QRNqZ23Q0nfw01TO23mRRxy2z+CwO6CIJV0qMhc+SwNKQ5ZIB
	zEWparWoDxo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62D2C15CD6;
	Fri,  9 May 2014 15:58:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CCD5F15CC8;
	Fri,  9 May 2014 15:58:47 -0400 (EDT)
In-Reply-To: <1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 9 May 2014 14:11:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 556C9D52-D7B4-11E3-A956-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248635>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There is no guideline as for what should be part of contrib.
>
> Some tools are actively maintained, others consist of a single commit.
> Some tools have active user-base, some aren't used by anyone. Some tools
> are on the path towards the core, others will never get there. Some
> tools are already out-of-tree and simply mirrored, others probably
> wouldn't survive out-of-tree. Some tools are production-ready, others
> don't even run. Some tools have tests, most don't.
>
> Junio has explained that he wrote this a long time ago, when Git was a
> different beast, now this no longer applies.
>
> The only way to find out if a tool belongs in contrib or not is to as
> Junio.
>
> Cc: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

This is wrong.

The reason I suggested splitting remote-hg out of my tree does not
have anything to do with "removal of disused and inactive" described
in the document.  As written elsewhere, it was a response to

    http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248457

where you said

    I don't want to do anything for a "contrib" tool.

and in response I suggested that you have an option to make it a
standalone third-party project (and the other option being to stay
in contrib/ but then you have to work well with others just like
other contributors).  With the promotion to the core has already
been ruled out as not an ideal direction in the thread that begins
at this one:

    http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248167

that is one of the only two alternatives I can offer.  Given that
the Git ecosystem has matured enough to let third-party tools
flourish on their own merit, if you do not want to work on a thing
in contrib/, that is now a more viable option than it used to be.

For tools that are happy to be in contrib/ and are still in use by
users, none of the above would apply.  And what the text says is
still perfectly valid.  There is nothing outdated in it.
