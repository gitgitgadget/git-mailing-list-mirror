From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 10:11:13 -0400
Message-ID: <F205FBFD-99B1-45F5-9596-3FE8384A9268@silverinsanity.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com> <ee77f5c20804280612o3db1fb86nf089e2201f688d2f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	=?ISO-8859-1?Q?=22J=F6rg_Sommer=22?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:12:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqU5d-0004tz-9t
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 16:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933586AbYD1OLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 10:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763151AbYD1OLR
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 10:11:17 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49292 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933360AbYD1OLQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 10:11:16 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id E03D61FFD6C5;
	Mon, 28 Apr 2008 14:11:11 +0000 (UTC)
In-Reply-To: <ee77f5c20804280612o3db1fb86nf089e2201f688d2f@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80536>


On Apr 28, 2008, at 9:12 AM, David Symonds wrote:

> I doubt J=F6rg suggested it for its speed, but it removes the =20
> dependency on Perl.

We already depend on perl for git-add--interactive.perl in core git, =20
and for git-svn, git-cvs*, and git-send-email.  I don't think this one =
=20
line is going to make a big difference in our Perl dependency.

~~ Brian