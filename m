From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Re: [PATCH] git-imap-send: use libcurl for implementation
Date: Wed, 22 Oct 2014 10:47:27 -0700
Message-ID: <xmqqbnp4hu8g.fsf@gitster.dls.corp.google.com>
References: <543A9CAC.5030404@raz.or.at> <5447C7A8.7030502@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Wed Oct 22 19:47:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xh00W-0002nV-M2
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 19:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbaJVRrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 13:47:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751031AbaJVRrb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 13:47:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 143D5166CB;
	Wed, 22 Oct 2014 13:47:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UHSZ3cpSqKsopbod08S9cH45NyE=; b=xL9qh+
	c2J2sF2sCr40FiSIQe7dKVS1ViTSTMnlIjJTsRvyeIaW8RSUuMyYBIfB77sPXsrD
	551iE/KNcuD8pKAcLBdvtH+NWo+Lqd2lyKufzGXTBCcxiVsO0Ye7uq1OJvHRGxLa
	BOdt1sJ2KNBWd89nC25kD49SQmPi1r6jwbkmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aa/UqJfFqsC/hJik0tUD+65XvxtA21R/
	IKxovGDvkkVIIoK7VkUVS/71iPeu1iM72xvF31U2cQhBrhFgpS0tNrVXNUhfGj0I
	ilSYiu2mTOiTFyWoTXqG/C/fQInfnQQTA7CG1/6n9b0iEsC9DCGjEFeFsC0HY7l2
	i21fypeWJG8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 089FB166CA;
	Wed, 22 Oct 2014 13:47:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2557166C7;
	Wed, 22 Oct 2014 13:47:28 -0400 (EDT)
In-Reply-To: <5447C7A8.7030502@raz.or.at> (Bernhard Reiter's message of "Wed,
	22 Oct 2014 17:05:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7DC28780-5A13-11E4-8277-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bernhard Reiter <ockham@raz.or.at> writes:

> *ping*
> Hope I didn't mess up formatting again...
> Or do I need to top-post, as the original thread is too old to keep posting to it?

Please avoid top-posting on this list.

If you have some background material (e.g. summary of previous
discussions, list of things that have been changed in response to
previous review, etc.), you have three options:

 * Use a cover letter, even for a one-patch topic.  Use [PATCH 0/1]
   for the background material if you have tons of it and then make
   [PATCH 1/1] as a follow-up to that cover letter.

   See http://thread.gmane.org/gmane.comp.version-control.git/256386
   for how such an approach looks like.

 * Use a single message, [PATCH] (aka [PATCH 1/1]), and add your
   background material _after_ three-dash lines as comment.

   See http://thread.gmane.org/gmane.comp.version-control.git/258451
   for how such an approach looks like.

 * Use a single message, [PATCH] (aka [PATCH 1/1]), and add your
   background material _before_ a scissors line "-- >8 --",
   optionally followed by "From:" and/or "Subject:" (but in your
   case, you are sending your own patch as yourself with the same
   subject, so neither of them apply).

   See http://thread.gmane.org/gmane.comp.version-control.git/258470/focus=258474
   for how such an approach looks like.


Thanks.
