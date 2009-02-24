From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
	commits older than a year
Date: Tue, 24 Feb 2009 00:04:00 -0500
Message-ID: <20090224050400.GC4615@coredump.intra.peff.net>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com> <20090222230620.GB19011@coredump.intra.peff.net> <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org> <20090223031631.GC22348@coredump.intra.peff.net> <49A2599E.2030406@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, eletuchy@gmail.com,
	git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbpU7-0004qh-2p
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 06:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbZBXFEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 00:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbZBXFEG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 00:04:06 -0500
Received: from peff.net ([208.65.91.99]:33890 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbZBXFEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 00:04:05 -0500
Received: (qmail 11138 invoked by uid 107); 24 Feb 2009 05:04:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Feb 2009 00:04:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2009 00:04:00 -0500
Content-Disposition: inline
In-Reply-To: <49A2599E.2030406@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111209>

On Mon, Feb 23, 2009 at 09:09:02AM +0100, Marius Storm-Olsen wrote:

>> Another option would to give higher resolution in number of years,
>> like "3.5 years" or even "3.1 years".
>
> And using shorter names for the units would be a no-go?
>
>   "3y 2m ago"    <--

Personally I think that looks terrible. But I recognize that it is
very subjective. The only objective thing I can say is that "m" is not a
unique prefix of a time unit, due to "minutes". Yes, it is obvious if
you see the "y" first, but I actually parse the relative time backwards
in my head and think "2 minutes ago, oh wait, 3 years, that must be
months".

-Peff
