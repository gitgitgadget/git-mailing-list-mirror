From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Unexpected behavior in git-rev-list
Date: Sun, 18 Sep 2005 19:58:50 +0200
Message-ID: <20050918175847.GA10427@ebar091.ebar.dtu.dk>
References: <20050918144931.GA9561@ebar091.ebar.dtu.dk> <Pine.LNX.4.58.0509181013250.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 18 20:09:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH3bI-0002Qh-BR
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 20:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVIRSJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 14:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVIRSJE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 14:09:04 -0400
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:60355 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S932150AbVIRSJC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 14:09:02 -0400
Received: (qmail 10486 invoked by uid 5842); 18 Sep 2005 17:58:50 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509181013250.26803@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8800>

On Sun, Sep 18, 2005 at 10:18:10AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 18 Sep 2005, Peter Eriksen wrote:
> > 
> > There's something I don't quite understand about git-rev-list.
> > After adding two files only one shows up with the --objects option.
...
> Well, it looks like some other file has _exactly_ the same contents as the 
> new "Dependencies", which means that git notices that the blob isn't 
> actually new.
> 
> Which doesn't surprise me at all - you've got a lot of projects there that 
> seem to have a Dependencies thing. Why wouldn't some other project have 
> the exact same ones?

Ah!  You are right, there is a Dependencies file in each of the 1000+
directories and they are generated from almost the same setup, so it
must be that there is another one like the one, I just commited.  That
explains it.  Now I will try to see, if I actually can get the effect I
expected somehow. :-) 

So my new challenge to myself: Given two commit objects A and B list all
the tree and blob objects which are not in both A and B. 

After that I think writing a command which does the same as 
'cvs annotate' would be a good exercise.

Thanks for the explanation.

Regards,

Peter


P.S.
I'm on the list, so it's not necessary to cc me. 
