From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 11:56:19 -0700
Message-ID: <1212173779.26045.77.camel@localhost.localdomain>
References: <483C4CFF.2070101@gmail.com>
	 <200805300127.10454.jnareb@gmail.com> <483FABB4.1010309@gmail.com>
	 <200805301202.25368.jnareb@gmail.com> <4840166C.3030903@gmail.com>
	 <20080530150713.GG593@machine.or.cz> <48401CFF.4020702@gmail.com>
	 <20080530153822.GH593@machine.or.cz>
	 <b77c1dce0805300904o5b4363efkc4591fc820164bf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 20:57:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K29nT-0007La-M6
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 20:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYE3S44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 14:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbYE3S44
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 14:56:56 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:54949 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbYE3S4z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 14:56:55 -0400
Received: from [10.255.255.198] (65-115-68-195.dia.static.qwest.net [65.115.68.195])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m4UIuJcP004044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 May 2008 11:56:19 -0700
In-Reply-To: <b77c1dce0805300904o5b4363efkc4591fc820164bf7@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-4.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7297/Fri May 30 09:41:12 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Fri, 30 May 2008 11:56:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83319>

I would agree - lets try and shoot for 5.8 as a baseline minimum (there
are lots of people who are slow to upgrade, and it would be nice to be
able for them to make use of newer gitweb's on things like Centos / RHEL
4

- John


On Fri, 2008-05-30 at 18:04 +0200, Rafael Garcia-Suarez wrote:
> 2008/5/30 Petr Baudis <pasky@suse.cz>:
> >
> > Wow, and here I was wondering if requiring at least 5.6 was not too
> > liberal. ;-) I believe 5.8 is the newest possible candidate though, it
> > is still too widespread; e.g. Debian-wise, many servers run on Etch and
> > are going to stay there even for quite some time after Lenny gets
> > released. Heck, I still have accounts on plenty of Sarge machines. ;-)
> > (Sarge seems to have Perl-5.8.4.)
> 
> I think 5.8.2 is a good _minimum_ perl to support. Before that one,
> Unicode support is next to null (5.6 and below) or too buggy, and
> gitweb needs that.
