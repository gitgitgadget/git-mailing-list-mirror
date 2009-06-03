From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] Rename submodule.<name>.rebase to
 submodule.<name>.update
Date: Wed, 03 Jun 2009 08:46:35 +0200
Message-ID: <200906030846.35704.johan@herland.net>
References: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
 <20090603001553.GB27149@dingo.bne.redhat.com>
 <7v4ouydp0q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Peter Hutterer <peter.hutterer@who-t.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, apenwarr@gmail.com,
	markus.heidelberg@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:47:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBkFy-00088H-Kl
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 08:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZFCGqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 02:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbZFCGqf
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 02:46:35 -0400
Received: from mx.getmail.no ([84.208.15.66]:37586 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751713AbZFCGqf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 02:46:35 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKN00JO4HHOBF90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 08:46:36 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKN006JWHHNKIC0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 08:46:36 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.6.3.63422
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <7v4ouydp0q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120586>

On Wednesday 03 June 2009, Junio C Hamano wrote:
> Peter Hutterer <peter.hutterer@who-t.net> writes:
> > I noticed this patch still leaves the --rebase commandline flag.
> > Shouldn't that be changed to --update=rebase for consistency?
>
> If we were to add many more (I think --update=merge was mentioned, but do
> we have any other plausibly useful modes of operations?) options, it
> would make sense to support --update=rebase; my impression from the
> previous discussion was that rebase would make sense for more people than
> other modes would, so it also would make sense to keep --rebase as a
> shorthand, rather than forcing everybody to say --update=rebase for the
> sake of consistency.

I agree. Even if we had a hundred alternatives, the most common should be 
available in shorthand form.

Also, I don't think it makes sense to introduce --update=foo until we have, 
say, 3-4 different alternatives. As long as --rebase and --merge are the 
only alternatives (no other alternatives have been suggested so far, AFAIK), 
I don't think we need to introduce --update=foo.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
