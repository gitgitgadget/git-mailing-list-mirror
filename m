X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to the index
Date: Sat, 2 Dec 2006 18:05:08 +0000
Message-ID: <200612021805.09143.alan@chandlerfamily.org.uk>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home> <200612020828.57989.alan@chandlerfamily.org.uk> <87psb22qgu.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 18:05:27 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <87psb22qgu.wl%cworth@cworth.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33031>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqZEp-0002gv-CE for gcvg-git@gmane.org; Sat, 02 Dec
 2006 19:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424309AbWLBSFU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 13:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424313AbWLBSFT
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 13:05:19 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:3474 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1424309AbWLBSFS (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2
 Dec 2006 13:05:18 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GqZEi-0005SH-JQ; Sat, 02 Dec 2006 18:05:16 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 16:49, Carl Worth wrote:
> On Sat, 2 Dec 2006 08:28:57 +0000, Alan Chandler wrote:
> > There is a conceptual difference between thinking that git-add is about
> > adding a file and git-add adding the current state of a files content.
>
> Yes, there is.
>
> >                                                                 If your
> > conceptual model is the first of these - then I can see why you see a
> > problem with git-add being used to say a files contents have changed.
>
> Yes. (And of course, I personally understand the second conceptual
> model. But there are a lot of "brain-damaged" people out there.)
>
> > However, if you regard the git-add command is "adding the current content
> > of the file to a staging area" , and you say this is an SCM which by
> > definition keeps the history of things once its been told about them I
> > don't see why there is a need for a different name for the operation the
> > first time and for the operation later.
>
> Yes, that's also true. Once you know the model then you wouldn't need
> two different commands. One can certainly get by with just the
> functionality of "update-index" for everything.
...
> So all of the conditions above, ("if your conceptual model is", "if
> you regard the git-add command", "if taught to use git-add up front",
> "if we effectively teach 'commit -a' first"), are barriers to learning
> git. We can't guarantee these are all met for new users, and when
> they're not, the users can get confused.
>

The argument I was _trying_ to make was that we should teach the second 
conceptual model not the first one AND stick with just the git add command 
(in response to your (Carl's) statement earlier in the thread that there 
needs to be two separate commands) .  My if statements were to illustrate 
that there are two fundamental ways of looking at this, not lots of ifs that 
newbies would have to consider.  We should up-front (in the tutorial, in 
appropriate man pages) use the one conceptual model (and I also like Junio's 
argument that git should take an aggressive stance of this is how the 
conceptual model is rather than the "contrary to ..." approach).



-- 
Alan Chandler
