From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the
	CGI script
Date: Fri, 18 Mar 2011 11:21:42 -0400
Message-ID: <1300461702.12245.27.camel@drew-northup.unet.maine.edu>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
	 <m3lj0e59ps.fsf@localhost.localdomain>
	 <1300361067.3010.1.camel@drew-northup.unet.maine.edu>
	 <201103171641.29021.jnareb@gmail.com>
	 <1300457243.12245.13.camel@drew-northup.unet.maine.edu>
	 <20110318145147.GA26236@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 16:22:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0bVA-00006C-PV
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 16:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab1CRPV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 11:21:57 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:40102 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801Ab1CRPV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 11:21:57 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2IFLkjo006273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 18 Mar 2011 11:21:46 -0400
In-Reply-To: <20110318145147.GA26236@inocybe.localdomain>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=4 Fuz1=4
	Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2IFLkjo006273
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1301066508.20957@uSvru1qHf1/qw96DfW3KEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169333>


On Fri, 2011-03-18 at 10:51 -0400, Todd Zullinger wrote:
> Hi Drew,
> 
> Drew Northup wrote:
> > At the very least I'm considering making a man page for the
> > configuration file. I don't know off-hand how much that will be
> > seemingly repetitive of the README, but I suspect I'm not the only
> > one who often finds monolithic files tucked away in /usr/share/doc
> > (/usr/doc for some systems) a daunting reading prospect
> [...]
> 
> FWIW, with git-1.7.4.1 in EPEL we now include a commented
> /etc/gitweb.conf in the package.  This wasn't present in the very old
> 1.5.5.6 we had in EPEL until recently.  This config file doesn't list
> all the available options, but it does point to the README and INSTALL
> files for further help.

I did find that following Jonathan's prompting. I hadn't been using the
EPEL git packages but had been building my own. Alas I also haven't
figured out yet how to auto-exclude individual package sets from upgrade
via channel (something for a discussion somewhere else--when I have time
to mess with it) and I missed the new EPEL ones in the list. (It's my
test/dev box so I let it run packages there for a while first before
rolling them out elsewhere.)

> (Also worth noting is that the package was in the epel-testing
> repository for 3 weeks and was announced on both epel-devel and
> epel-announce to try and get testing from folks before pushing it
> stable.  Sadly, very few folks do so, and issues are sometimes not
> caught.)
> 
> Sorry if the update caused you trouble.

The main thing that annoyed me was that EPEL and git's "make rpm" seem
to still have very different ideas about where stuff belongs on a
machine. I wish I had more time to read the "epel-testing" release
notes, but that wouldn't have actually helped me in this case.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
