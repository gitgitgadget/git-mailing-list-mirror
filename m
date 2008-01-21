From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Mon, 21 Jan 2008 03:06:59 -0800
Message-ID: <7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
	<7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
	<47946F67.5060601@gbarbier.org>
	<7vmyqzzdhf.fsf@gitster.siamese.dyndns.org>
	<47947399.3000507@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Gr=C3=A9goire?= Barbier <devel@gbarbier.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 12:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGuV9-0007nr-5S
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 12:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895AbYAULHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 06:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbYAULHJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 06:07:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbYAULHH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 06:07:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E406740AD;
	Mon, 21 Jan 2008 06:07:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7460540AC;
	Mon, 21 Jan 2008 06:07:02 -0500 (EST)
In-Reply-To: <47947399.3000507@gbarbier.org> (=?utf-8?Q?Gr=C3=A9goire?=
 Barbier's message of
	"Mon, 21 Jan 2008 11:27:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71261>

Gr=C3=A9goire Barbier <devel@gbarbier.org> writes:

> Junio C Hamano a =C3=A9crit :
>> Thanks for correction.  I need to update Release Notes...
>
> Curl 7.16 has been released in october 2006
> (http://curl.haxx.se/changes.html), rather than 2003 like for 7.10.
>
> The consequences is that a lot of not so old distributions may be
> concerned. I only checked Fedora, which does not provide curl > 7.15
> before Fedora 7 (issued late may 2007).
>
> (BTW you may guess well that I'm using a Fedora Core 6 for my git
> patches...)

Now, that means the patch is not quite good for 1.5.4, and if we
want to keep http-push alive (I do not very much care about it
myself, though), and make it usable, we would need to fix it for
non MULTI case.

Hmmmmm.
