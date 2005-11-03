From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 18:48:57 +0000
Message-ID: <200511031848.58040.alan@chandlerfamily.org.uk>
References: <200511031741.20496.alan@chandlerfamily.org.uk> <20051103181002.GA26437@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 03 19:51:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXk91-0007sp-Uv
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 19:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbVKCSs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 13:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbVKCSs7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 13:48:59 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:33737
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1030428AbVKCSs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 13:48:58 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EXk8v-0006EF-QC
	for git@vger.kernel.org; Thu, 03 Nov 2005 18:48:57 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051103181002.GA26437@bohr.gbar.dtu.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11082>

On Thursday 03 Nov 2005 18:10, Peter Eriksen wrote:
> On Thu, Nov 03, 2005 at 05:41:20PM +0000, Alan Chandler wrote:
> > I have a little problem I am trying to solve.  Tried a few things and got
> > nowhere, so I thought I would ask here.
> >
> > I have two directories one of which contains a tree of source code that
> > was an original software package that I downloaded.  The other contains
> > the result of some unfinished - but quite substancial changes that I had
> > made to that source code.  Since this was some time ago, I don't have any
> > records, but it is quite possible that I added and removed quite a few
> > files.

> What I read from this, is that you could do something like (with Git,
> but I suppose Cogito is very similar):
>
> ]cd original
> ]git-init-db
> ]git-add all-the-files
> ]git-commit -m "Initial import"
> ]cp -rf ../modified/* .
> ]git-status
> ...fix things up adding and deleting files
> ]git-commit -m "First big change
>
> The point is, I think git-status will tell you about any
> modifications you have made by just overwriting the original
> tree with the modified one.


The advantage of cg-init (as opposed git-init-db) is that it finds all the 
files to add.

I just did a quick trial of this, and it appears that git-status does not 
notice deleted or added files.

That is one of the major issues that was worrying me - that I didn't miss any 
of those.  

There is a manual workaround - I have just run up kdiff3 (from kde) on the two 
directories and it is showing 59 file differences (as opposed to the 21 
reported by git-status).  So I could go down them one by one and deal with 
them.

But I was hoping there was an automated method:-(



-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
