From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 20:16:52 +0100
Message-ID: <20051103191652.GA28273@bohr.gbar.dtu.dk>
References: <200511031741.20496.alan@chandlerfamily.org.uk> <20051103181002.GA26437@bohr.gbar.dtu.dk> <200511031848.58040.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 03 20:19:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXka5-0002JS-Vd
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 20:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbVKCTQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 14:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbVKCTQz
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 14:16:55 -0500
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:55937 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1030411AbVKCTQy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 14:16:54 -0500
Received: (qmail 2031 invoked by uid 5842); 3 Nov 2005 20:16:52 +0100
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200511031848.58040.alan@chandlerfamily.org.uk>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11085>

On Thu, Nov 03, 2005 at 06:48:57PM +0000, Alan Chandler wrote:
> On Thursday 03 Nov 2005 18:10, Peter Eriksen wrote:
[snip]
> > ]cd original
> > ]git-init-db
> > ]git-add all-the-files
> > ]git-commit -m "Initial import"
> > ]cp -rf ../modified/* .
> > ]git-status
> > ...fix things up adding and deleting files
> > ]git-commit -m "First big change

Perhaps something like this is better (now I actually tried it out):

]rm -rf linux-2.6/.git
]cp -r linux-2.6 peter-2.6
...Initialize a repo in linux-2.6 with cg-init or similar and commit.
...Remove, add and change files in peter-2.6.
]mv linux-2.6/.git peter-2.6/.git
]cd peter-2.6/
]git-status

How does this work for you?

Peter
