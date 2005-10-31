From: Chris Wright <chrisw@osdl.org>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Sun, 30 Oct 2005 22:41:05 -0800
Message-ID: <20051031064105.GV8041@shell0.pdx.osdl.net>
References: <43652934.8000308@zytor.com> <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 08:02:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWTNG-0003pJ-CD
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 07:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVJaGlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 01:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVJaGlL
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 01:41:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932497AbVJaGlK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 01:41:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9V6gosC029434
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 30 Oct 2005 22:42:50 -0800
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9V6f5OI028113;
	Sun, 30 Oct 2005 22:41:05 -0800
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j9V6f59C028112;
	Sun, 30 Oct 2005 22:41:05 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10853>

* Junio C Hamano (junkio@cox.net) wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > git-svnimport.perl:require v5.8.0; # for shell-safe open("-|",LIST)
> >
> > ... which RPM thinks means that you need a Perl module called v5.8.0 
> > which doesn't, of course, exist.  This is arguably an rpmbuild bug, but 
> > it nevertheless breaks at the moment.
> 
> I took Ryan's suggestion and pushed 0.99.9a out.  Does it make
> RHEL4 happy?

It's fine for FC3.  Certain irony that git now effectively requires
subversion.  I'm all for splitting these out, but have no time until
later in the week.  BTW, mind pushing the tag?

thanks,
-chris
