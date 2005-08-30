From: Christian Meder <chris@absolutegiganten.org>
Subject: Re: please pull ppc64-2.6.git
Date: Tue, 30 Aug 2005 23:40:48 +0200
Message-ID: <1125438048.9705.43.camel@localhost>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
	 <17171.39652.237263.484079@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0508291706230.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 23:42:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EADqx-0001Wu-T4
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 23:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVH3VlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 17:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVH3VlI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 17:41:08 -0400
Received: from shadow.prohost.de ([216.71.84.228]:16208 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S932483AbVH3VlH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 17:41:07 -0400
Received: from blue (p54A208FA.dip0.t-ipconnect.de [84.162.8.250])
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j7ULemA08180;
	Tue, 30 Aug 2005 23:40:48 +0200
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508291706230.3243@g5.osdl.org>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7965>

On Mon, 2005-08-29 at 17:20 -0700, Linus Torvalds wrote:
> 
> On Tue, 30 Aug 2005, Paul Mackerras wrote:
> > 
> > What can one put in the alternates file?  Just an absolute path, or
> > does a relative path or a URL work too?
> 
> Only an absolute path.
> 
> URL's fundamentally do not work, and relative paths end up being parsed as
> relative to where-ever the user happens to be (and some commands will 
> "chdir()" into the .git directory, while others will not).

Is alternates unthinkable with URLs (e.g. remote alternates) i.e. broken
by design or thinkable but not there yet ?

Greetings,


				Christian

-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)
