From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] git-bisect.txt: clarify that reset finishes bisect
Date: Sun, 10 Feb 2013 00:24:55 +0100
Message-ID: <20130209232455.GA31027@rhlx01.hs-esslingen.de>
References: <5e23d4c420f150b700dd5100bffb38d32f874200.1360439176.git.git@drmicha.warpmail.net>
 <7v8v6xw3wf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Andreas Mohr <andi@lisas.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:25:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4JnW-0007AU-NL
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 00:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760875Ab3BIXY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 18:24:57 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:48142 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab3BIXY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 18:24:57 -0500
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id B7C91A2C52; Sun, 10 Feb 2013 00:24:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8v6xw3wf.fsf@alter.siamese.dyndns.org>
X-Priority: none
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215882>

Hi,

On Sat, Feb 09, 2013 at 01:53:04PM -0800, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> >  After a bisect session, to clean up the bisection state and return to
> > -the original HEAD, issue the following command:
> > +the original HEAD (i.e., to finish bisect), issue the following command:
> 
> Makes sense.

Doesn't ;)

[aww, very sorry for this blunt reply]

The main point of my mail was to stretch the (whether actually intended)
*perceived* start <-> stop symmetry
(which a *user* quite likely would end up searching for in the document,
and fail to find any "stop" keyword, thus not getting to the relevant
reset parameter section in time).
Quite likely I failed to properly word things to make that obvious,
in my quickly carved mail.


To clarify intent behind these docs, I would thus propose to have
the sentence improved to something quite similar to

the original HEAD (i.e., to finish - "stop" a started - bisect),
issue the following command:


Thanks a ton for your immediate handling of my wishlist item!

Andreas Mohr
