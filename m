X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to the index
Date: Sat, 2 Dec 2006 00:18:32 +0000
Message-ID: <200612020018.32672.alan@chandlerfamily.org.uk>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home> <7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 00:18:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32995>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqIaU-0004XY-3z for gcvg-git@gmane.org; Sat, 02 Dec
 2006 01:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161841AbWLBASf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 19:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161992AbWLBASf
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 19:18:35 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:47502 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1161841AbWLBASf (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1
 Dec 2006 19:18:35 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GqIaQ-0001vu-5k for git@vger.kernel.org; Sat, 02 Dec 2006 00:18:34 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 01 December 2006 22:31, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
...
>
> > +Contrary to other SCMs, with GIT you have to explicitly "add" all the
> > +changed file content you want to commit together to form a changeset
> > +with the 'add' command before using the 'commit' command.
>
> ... "before a new commit is made"; it is not an offence to leave
> local changes outside the index.  Staging such changes to all
> files is done using the "-a" flag and that is done "before a new
> commit is made", but not "before using the 'commit' command" --
> it is done at the same time.

How about

Contrary to other SCM's, with GIT you have to explicitly "add" the content 
that you want to commit before it is made; it is not an offence to leave 
changes outside the index if you want to leave them to a later commit.  
However if you do want all changes from your working tree to be added to the 
commit before it is made use the "-a" flag with the commit command and the 
content will be added just before the commit is made.


-- 
Alan Chandler
