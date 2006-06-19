From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: simple use case scenario for --read-tree and --write-tree with --prefix option
Date: Mon, 19 Jun 2006 21:20:08 +0530
Message-ID: <cc723f590606190850q4a200423ve3304c4f7df20267@mail.gmail.com>
References: <cc723f590606190028t65c76c74t6a90d1dcec411598@mail.gmail.com>
	 <7vpsh5a8gs.fsf@assigned-by-dhcp.cox.net>
	 <cc723f590606190058w2d7481ecsaded46095aee2355@mail.gmail.com>
	 <20060619135343.GP2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 17:50:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsM14-0006GG-61
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 17:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWFSPuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWFSPuN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 11:50:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:6927 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932497AbWFSPuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 11:50:11 -0400
Received: by nf-out-0910.google.com with SMTP id p48so1222123nfa
        for <git@vger.kernel.org>; Mon, 19 Jun 2006 08:50:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YWT+EQnX9/BuZMUet+YeJcJpPwcYTv4MAkb8UKQFchU46N8lSWWDpEs0xDdMbiAqKdouh3aVSipYhunHPJ4HGEKtSDpx/RdsUwsS5wS+O8PbDVwGy3nFr3f2TDj6P5tIUibY+0qxKqVFvCKd00Lkrx3a4YN8GVMYt5VvIWltSQM=
Received: by 10.49.35.3 with SMTP id n3mr4696859nfj;
        Mon, 19 Jun 2006 08:50:09 -0700 (PDT)
Received: by 10.49.90.13 with HTTP; Mon, 19 Jun 2006 08:50:08 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060619135343.GP2609@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22128>

On 6/19/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Mon, Jun 19, 2006 at 09:58:31AM CEST, I got a letter
> where Aneesh Kumar <aneesh.kumar@gmail.com> said that...
> > cd test
> >
> > kvaneesh@satan:/tmp/test$ git read-tree --prefix=test1/ $(cat
> > test1/.git/refs/heads/master)
> > fatal: failed to unpack tree object c6c049d03f0bee0ac546ff6e436d5f6f3a5f4864
> >
> > But the above command doesn't work for me. I guess i am missing something.
>
> You need to do a fetch to your /tmp/test repository first.
>


Ok that made the --read-tree part work. But the log or whatchanged
commands doesn't gets me the history of changes with resepect to the
files added.  Now i remember this is in a way simillar to gitweb
history not shown. But then using the --full-history option with git
log also doesn't show the details of history with respect to the
files.

This is what i did

git fetch ./test2/
git read-tree --prefix=test2/ $(cat test2/.git/refs/heads/master)

Now if i look at .git/objects/ I can see commit objects with respect
to changes for test2/a

-aneesh
