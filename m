From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2 11/16] Add explanatory comment for transport-helpers
 refs mapping.
Date: Mon, 30 Jul 2012 10:25:40 -0700
Message-ID: <7v1ujtrwiz.fsf@alter.siamese.dyndns.org>
References: <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <20120730170842.GC8515@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:25:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svtj4-000687-49
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501Ab2G3RZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 13:25:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36870 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077Ab2G3RZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 13:25:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B7009841;
	Mon, 30 Jul 2012 13:25:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vGsT3fmpvhWiWQqHtwRZnuimcpU=; b=P3M1Nk
	miKWbNjGAVjFSI0ZGLKzGp3JSg7mBhh3DK0WUNpOb0rTptC2mm+4XJdq5IjoRahk
	oaEbWmExATa/G8OSC20iEOouZANBcIo6410f5Vk8muiLO02/ipNT+qDuTqwMuwa3
	3MS5kpZlZcp29yOfFOktDasSJ4/ksUYHiALpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wkEtrfkaweK8IgOHyNzEx793yuq+DCE2
	dCKZnswsQL1ExS59nbt5j7MuaMp4E0d+ebrDuCFh9e+zK3p35YhEaGzwA9NhaYKP
	HzTmAynd0vEl62rqgdzSZD6d51rTEQHpztR669xWu6+4DgPmoIv/x5rT0co5qEdy
	GZoU5qsAbP8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01A299840;
	Mon, 30 Jul 2012 13:25:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 738CC983F; Mon, 30 Jul 2012
 13:25:41 -0400 (EDT)
In-Reply-To: <20120730170842.GC8515@burratino> (Jonathan Nieder's message of
 "Mon, 30 Jul 2012 12:08:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9641A96E-DA6B-11E1-A244-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202587>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Junio,
>
> Florian Achleitner wrote:
>
>> transport-helpers can advertise the 'refspec' capability,
>> if not a default refspec *:* is assumed. This explains
>> the post-processing of refs after fetching with fast-import.
>>
>> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
>
> The patch below adds a comment to fetch_with_import() explaining the
> loop that saves the fetched commit names after 'git fast-import' has
> done its work.  It avoids some confusion that Florian encountered on
> first reading about which refs the fast-import stream is supposed to
> use to write its result.

>
> (By the way, I guess I find the above paragraph clearer than Florian's
> commit message.  But aside from that, the patch seems good to me.)
>
> I would like to see the patch applied so the remote-svn series without
> it gets shorter and easier to review.

Sounds pretty safe, and as long as mentors and stakeholders in the
area are happy with what the comment says, I see no issue applying
it now.  Is it understood by all parties that Florian may need to
rebase the series on top of it?
