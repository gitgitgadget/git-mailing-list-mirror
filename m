From: Johan Herland <johan@herland.net>
Subject: Re: [RFCv3 2/4] Add Python support library for CVS remote helper
Date: Thu, 13 Aug 2009 03:27:28 +0200
Message-ID: <200908130327.28571.johan@herland.net>
References: <1250036031-32272-1-git-send-email-johan@herland.net>
 <20090812021017.GB62301@gmail.com> <7vzla4r0qc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	barkalow@iabervon.org, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 03:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbP6T-0007Wz-3e
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 03:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZHMB1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 21:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbZHMB1b
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 21:27:31 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40776 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750806AbZHMB1a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 21:27:30 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOA004WCK1UET30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 03:27:30 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOA000PUK1TJ1B0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 03:27:30 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.13.11225
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <7vzla4r0qc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125763>

On Thursday 13 August 2009, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> > This also had me wondering about the following:
> > 	git uses tabs for indentation
>
> Not relevant.  That is a rule for our "C" source code.  We also use it in
> our Perl scripts and shell scripts because there is no single "one right
> way" that is strongly defined and everybody adheres to, like the 4-space
> rule Python folks have.
>
> > BUT, the python convention is to use 4-space indents ala PEP-8
> > http://www.python.org/dev/peps/pep-0008/
> >
> > It might be appealing to when-in-Rome (Rome being Python) here
> > and do things the python way when we code in Python.
>
> Yes, this is more important.
>
> >> +		if len(msg) > 25: msg = msg[:22] + "..." # Max 25 chars long
> >> +		return "<Changeset @(%s) by %s (%s) updating %i files>" % (
> >> +			self.date, self.author, msg, len(self.revs))
> >
> > Similar to the git coding style, this might be better written:
>
> So is this one.  If experienced Python folks also frown on single-line
> conditionals, then by all means please update this.  But if this
> suggestion is solely because we don't do a single-line conditional in our
> C source code, then please do not insist on it too strongly.  The code
> should look familiar to Pythonistas with good tastes (if such a class of
> people exist, that is ;-)).

Ok. Thanks. I will follow PEP8 as closely as possible, including the 4-space 
indent.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
