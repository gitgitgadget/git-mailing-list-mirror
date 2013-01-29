From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH v2] CodingGuidelines: add Python coding guidelines
Date: Tue, 29 Jan 2013 19:55:34 +0000
Message-ID: <20130129195534.GE1342@serenity.lan>
References: <20130129190844.GB1342@serenity.lan>
 <7vzjzrokag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:56:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0HHn-0000VA-FN
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab3A2Tzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 14:55:42 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:44887 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab3A2Tzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:55:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id A44FE2308E;
	Tue, 29 Jan 2013 19:55:40 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 63Rm30fbq+1g; Tue, 29 Jan 2013 19:55:40 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 1C8CB1FC8A;
	Tue, 29 Jan 2013 19:55:36 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vzjzrokag.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214966>

On Tue, Jan 29, 2013 at 11:34:31AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Changes since v1:
> >
> > - Set 3.1 as the minimum Python 3 version
> >
> > - Remove the section on Unicode literals - it just adds confusion and
> >   doesn't apply to the current code; we can deal with any issues if they
> >   ever arise.
> > ...
> > + - We use the 'b' prefix for bytes literals.  Note that even though
> > +   the Python documentation for version 2.6 does not mention this
> > +   prefix it is supported since version 2.6.0.
> 
> Do we still need to single out the 'b' prefix?  Even if it were
> necessary, I'd like to see it toned down a bit to make it clear that
> most of the time you can write strings as strings without having to
> worry about the "is it unicode string or a string string" mess.
> Like
> 
>     - When you must make distinction between Unicode literals and
>       byte string literals, it is OK to use 'b' prefix.  Even though
>       ...
> 
> perhaps?

Yeah, that's better.

I want to include it because if you look in the Python documentation
then you'll be misled into thinking that it's not available on 2.6 and
we will be supporting that for a while since it is the version included
in RHEL 6.


John
