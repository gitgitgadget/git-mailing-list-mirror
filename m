From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH 2/6] Factorize shortening of notes refname for display.
Date: Mon, 20 Jun 2011 20:49:53 +0200
Message-ID: <20110620184953.GO2921@home.lan>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
 <1308431208-13353-3-git-send-email-ydirson@free.fr>
 <201106192325.00667.johan@herland.net>
 <7vliwxe8p5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 20:50:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYjY0-0000EG-4y
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 20:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab1FTSuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 14:50:03 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60951 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab1FTSuC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 14:50:02 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 1C306D48047;
	Mon, 20 Jun 2011 20:49:54 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.76)
	(envelope-from <ydirson@free.fr>)
	id 1QYjXl-0007X8-UA; Mon, 20 Jun 2011 20:49:53 +0200
Content-Disposition: inline
In-Reply-To: <7vliwxe8p5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176085>

On Sun, Jun 19, 2011 at 03:51:34PM -0700, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> 
> > On Saturday 18 June 2011, Yann Dirson wrote:
> >> Signed-off-by: Yann Dirson <ydirson@free.fr>
> >> ---
> >>  notes.c |   24 ++++++++++++++++--------
> >>  notes.h |    7 +++++++
> >>  2 files changed, 23 insertions(+), 8 deletions(-)
> >> 
> >> [...]
> >> 
> >>  /*
> >> + * Return a short name for a notes ref, suitable for display to the user.
> >> + *
> >> + * No copy is done, the return value is a pointer into the original string.
> >> + */
> >> +const char *notes_ref_shortname(const char *ref);
> >> +
> >> +/*
> >
> > Please include in the documentation what a NULL return means.
> >
> > Otherwise the patch looks OK.
> 
> It may be just me, but every time somebody says Factorize, I find myself
> looking for math textbook from middle school days, 12 = 2 * 2 * 3, etc.
> 
> Could we say Refactor instead pretty please?

Well, factorizing is just one kind of code refactoring - but OK, I'll
do that ;)
