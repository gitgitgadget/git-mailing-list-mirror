From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: simple use case scenario for --read-tree and --write-tree with --prefix option
Date: Mon, 19 Jun 2006 13:28:31 +0530
Message-ID: <cc723f590606190058w2d7481ecsaded46095aee2355@mail.gmail.com>
References: <cc723f590606190028t65c76c74t6a90d1dcec411598@mail.gmail.com>
	 <7vpsh5a8gs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 09:58:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsEed-0006hh-He
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 09:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWFSH6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 03:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWFSH6e
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 03:58:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:3848 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751006AbWFSH6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 03:58:33 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1204766nfa
        for <git@vger.kernel.org>; Mon, 19 Jun 2006 00:58:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jao8pvcOnARMFWzJJlnN6L5Uw5Femg/OnVqSewefriaib4mRg9nRa2RRToDGxdvcUm4Ek0K9ERo2hM9b9ZcFNy2fu+2v6WFAIWjTP36eK1scFBJxfvsBUVqWS8T1sY4fAvh8xOQ5dbLp97jEDkZlHTUTyS+Awtzb7N2JXGw2IXs=
Received: by 10.48.235.2 with SMTP id i2mr3250476nfh;
        Mon, 19 Jun 2006 00:56:53 -0700 (PDT)
Received: by 10.49.90.13 with HTTP; Mon, 19 Jun 2006 00:58:31 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpsh5a8gs.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22119>

On 6/19/06, Junio C Hamano <junkio@cox.net> wrote:
> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
>
> > I searched the archives but didn't find anything. If i understand
> > correctly the sub project idea is using the gitlink object type. So
> > what is read-tree and write-tree with --prefix option supposed to
> > achieve.
>
> The --prefix option to read-tree was very useful when I did a
> hand merge of gitweb for example.  I am reasonably sure clever
> people will find other uses as well.
>

Ok i tried this
mkdir test/test1
mkdir test/test2
cd test
git init-db
cd test1
git init-db
cd ../test2
git init-db

now  i do some devel under test2
now if i want to pull this with the history to toplevel directory test
should i be doing

cd test

kvaneesh@satan:/tmp/test$ git read-tree --prefix=test1/ $(cat
test1/.git/refs/heads/master)
fatal: failed to unpack tree object c6c049d03f0bee0ac546ff6e436d5f6f3a5f4864

But the above command doesn't work for me. I guess i am missing something.

-aneesh
