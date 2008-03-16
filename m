From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Sun, 16 Mar 2008 09:52:34 -0700
Message-ID: <1205686355.2758.31.camel@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
	 <m3ve3nwtl3.fsf@localhost.localdomain>
	 <20080316114151.GZ10103@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Mar 16 17:53:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jaw70-00010m-GF
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 17:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbYCPQwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 12:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbYCPQwt
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 12:52:49 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:52429 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbYCPQwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 12:52:49 -0400
Received: from [172.19.0.93] ([76.21.83.184])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.13.8) with ESMTP id m2GGqV2a005442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Mar 2008 09:52:32 -0700
In-Reply-To: <20080316114151.GZ10103@mail-vs.djpig.de>
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/6260/Sun Mar 16 08:16:45 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77365>

On Sun, 2008-03-16 at 12:41 +0100, Frank Lichtenheld wrote:
> On Sat, Mar 15, 2008 at 02:44:42PM -0700, Jakub Narebski wrote:
> > Petr Baudis <pasky@suse.cz> writes:
> > This could be much simplified with perl-cache (perl-Cache-Cache).
> > Unfortunately this is non-standard module, not distributed (yet?)
> > with Perl.
> 
> I think somebody who actually needs this can be bothered to install a
> CPAN perl module. This should probably not enabled by default anyway.

The people who need the caching are also likely those who are most
averse to using things that don't either come with their distribution or
aren't easily and readily available in something like an extras
repository or a very well trusted contrib repository.  I can at least
vouch for one large site that needs this that doesn't install things via
cpan for a lot of different reasons.


- John 'Warthog9' Hawley
