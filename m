From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] standardize usage info string format
Date: Tue, 13 Jan 2015 14:45:10 -0800
Message-ID: <xmqqegqycnbd.fsf@gitster.dls.corp.google.com>
References: <1421135087-7284-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, Matthieu.Moy@imag.fr,
	madcoder@debian.org, barra_cuda@katamail.com, dpotapov@gmail.com,
	git@adamspiers.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, barkalow@iabervon.org, stefanbeller@gmail.com,
	shawn.bohrer@gmail.com, felipe.contreras@gmail.com,
	rhansen@bbn.com, pasky@ucw.cz, s-beyer@gmx.net,
	c.shoemaker@cox.net, grnch@gmx.net, l.s.r@web.de,
	philipoakley@iee.org, michal.kiedrowicz@gmail.com, cmn@elego.de,
	artagnon@gmail.com, rctay89@gmail.com, stefan.naewe@gmail.com,
	pbonzini@redhat.com, aspotashev@gmail.com, johan@herland.net,
	luksan@gmail.com, bebarino@gmail.com, Johannes.Schindelin@gmx.de,
	kevin@bracey.fi, jasampler@gmail.com, brad.king@kitware.com,
	git@drmicha.warpmail.net, peff@peff.net, chriscool@tuxfamily.org,
	ayiehere@gmail.com, josh@joshtriplett.org, stepnem@gmail.com,
	Matthieu.Moy@grenoble-inp
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:51:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBAJR-0003H3-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 23:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbbAMWvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 17:51:32 -0500
Received: from a-pb-sasl-trial-quonix.pobox.com ([208.72.237.12]:64060 "EHLO
	a-pb-sasl-trial-quonix.pobox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916AbbAMWv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2015 17:51:26 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jan 2015 17:51:26 EST
Received: from a-pb-sasl-trial-quonix.pobox.com (localhost [127.0.0.1])
	by a-pb-sasl-trial-quonix.pobox.com (Postfix) with ESMTP id 63914A50C;
	Tue, 13 Jan 2015 17:45:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+oIAtB/U2TknZEu1VmcogPOKk/s=; b=xRYeGu
	uxbjQ4cHVrexg1rYrPxL3VckyQqTQLeGjpgnBcbOa/pzwRd2YEESdE/EMuTC0FHd
	A0fduS9ll9k8TIYksUWEw6YZmKzuaWw7kJ1jTGwhiINj9NvIvD2kWdHstG6/eDIN
	h8sk4aHeXtFh407oGHg7WkQfEHzXc2ycu4A+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HCVbMENHepitrfewDoERIkfTJjQbKGlq
	tviB2a3DJzRByfe5QlBa3hs3cML1FZyFod8s+VXv/gQMXEb6gapmfIH10dBHStiW
	0s+uSNHKdsl/B8T24dTKE+Uoys5GeeoTOGM5htgz7/MXCTGrKPkWWd/zaPlc1scm
	2ra5MFn7yLI=
Received: from pb-smtp1.int.icgroup.com (pb-smtp1.int.icgroup.com [10.80.80.28])
	by a-pb-sasl-trial-quonix.pobox.com (Postfix) with ESMTP id 465AAA50B;
	Tue, 13 Jan 2015 17:45:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93AFB30BA4;
	Tue, 13 Jan 2015 17:45:11 -0500 (EST)
In-Reply-To: <1421135087-7284-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Tue, 13 Jan 2015 00:44:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D51CAF76-9B75-11E4-8EE1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262361>

Alex Henrie <alexhenrie24@gmail.com> writes:

> This patch puts the usage info strings that were not already in docopt-
> like format into docopt-like format, which will be a litle easier for
> end users and a lot easier for translators. Changes include:
>
> - Placing angle brackets around fill-in-the-blank parameters
> - Putting dashes in multiword parameter names
> - Adding spaces to [-f|--foobar] to make [-f | --foobar]
> - Replacing <foobar>* with [<foobar>...]
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/CodingGuidelines |  8 ++++++--
>  advice.c                       |  2 +-
>  archive.c                      |  4 ++--
>  ...
>  git.c                          |  2 +-
>  64 files changed, 109 insertions(+), 105 deletions(-)

A patch that affects this many files is bound to interfere with a
few topics already in flight, but after applying it on top of
2.3-rc0 and then merging the result to 'pu', the textual conflicts
are still manageable.

I eyeballed it briefly and saw nothing glaringly wrong.  Let's give
others some time to glance it over.

Thanks (and thanks to those who read the previous iteration).
