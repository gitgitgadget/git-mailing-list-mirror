From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 02 Dec 2010 07:51:06 -0500
Message-ID: <1291294266.20062.10.camel@drew-northup.unet.maine.edu>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
	 <1291230820.11917.25.camel@drew-northup.unet.maine.edu>
	 <877hftuvvz.fsf@picasso.cante.net>
	 <7vfwuhtafr.fsf@alter.siamese.dyndns.org>
	 <AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
	 <87sjygspgy.fsf@picasso.cante.net> <buo39qg8zrf.fsf@dhlpc061.dev.necel.com>
	 <87bp54s770.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Santi =?ISO-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 13:52:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO8eH-0006Oe-M4
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513Ab0LBMw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 07:52:27 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:37572 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab0LBMw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 07:52:26 -0500
Received: from [130.111.39.151] (drew-northup.unet.maine.edu [130.111.39.151])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oB2Cp9C1005500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 2 Dec 2010 07:51:14 -0500
In-Reply-To: <87bp54s770.fsf@picasso.cante.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=5
	Fuz1=5 Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oB2Cp9C1005500
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1291899076.49441@8gDBU+VkLASuHHU8RrMKiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162701>


On Thu, 2010-12-02 at 14:14 +0200, Jari Aalto wrote:
> 2010-12-02 08:17 Miles Bader <miles@gnu.org>:
> > Jari Aalto <jari.aalto@cante.net> writes:
> >
> >>> Additionaly, you must know about the ^ notation. That is the only way
> >>> refer to the second parent HEAD^2, for example.
> >>
> >> If "must" is a requirement, I have to regret that there has yet to have
> >> been a situation where I would ahve a need to refer to "second parent".
> >>
> >> I guess most of the basic features can be used without it.
> >
> > It doesn't matter.  There needs to be a better reason than "Jari doesn't
> > like it."
> 
> This has nothing to do with liking. It how infomation is read. When
> information is consistent, it lessens cognitive load.
> 
> In the  "fine print" git-rev-parse(1) there can be the gory details.
> 
> most of the commenters probably are already experts and therefor wear
> "expert glasses on". It's not necessarily the same for starters.
> Certainly not when you try to teach 100 people. One form is much better
> in that situation than variations. You only do it at the end:
> 
>     "[After finishing 6 week training] Btw, if you need more details
>     look at...."
> 
> Experts can later pick anything they want.
> 
> Jari

I have worked in instructional settings, as the instructor. I can say
flat out that this is an incomplete view of the learning patterns of
people being newly exposed to a concept or a technology. Besides, many
people who consult manpages often think of themselves as experts (and
may think better of the idea after consulting the documentation).

The reality is that learning is not nearly as proscribed and rote a
process as you are making it out to be. Rote memorization is good for
learning multiplications tables, alphabets, and the approximate values
of e and pi. It is not particularly suited for learning grammars and
syntaxes--which is why language and algebra are typically not taught
that way. Programming and using computers benefits greatly from
presenting multiple varied examples--even to the supposed experts who
probably don't know it all either.

Leave the odd examples in the manpages--people depend on them being
there.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
