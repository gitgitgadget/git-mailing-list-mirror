From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: git-format-patch-script bug?
Date: Sun, 7 Aug 2005 13:53:42 -0700 (PDT)
Message-ID: <20050807205342.8497.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 22:53:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1s9T-0002j8-8v
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 22:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbVHGUxo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbVHGUxo
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 16:53:44 -0400
Received: from web26304.mail.ukl.yahoo.com ([217.146.176.15]:42603 "HELO
	web26304.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1752732AbVHGUxn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 16:53:43 -0400
Received: (qmail 8499 invoked by uid 60001); 7 Aug 2005 20:53:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JUZcQJW4Tx6msy6tltz6q+kE2j1u2FNIiceYgKyEGZFlsbZMEzvdqGSQWyUD/Xip0zKhFNhoo7x68J/McgI153FQnHSNSlSh0783fsSmoZY4VxXxj8QlLKiTsNjLxNE8HhJY74MW4UzHXynRBxHe3yXP9urXvytQCrTgKKEAzMU=  ;
Received: from [151.38.109.179] by web26304.mail.ukl.yahoo.com via HTTP; Sun, 07 Aug 2005 13:53:42 PDT
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>
>I am reluctant to actually do this right away, because this is
>an incompatible change from the current format:
>
>    $ git format-patch his mine
>


Of course this breaks qgit interface to git-format-patch-script
but if you think it's better this way....


>The same goes for rebase (and therefore cherry).  I could use an
>ugly heuristics for backward compatibility like "if invoked with
>exactly two parameters, and there is no prefix ^ nor .. in these
>two, then use the old interpretation, otherwise give them to
>rev-parse", but I think this is ugly.
>
>So my question to the list is: do people mind this change?
>

I think it's ugly too, in this early phase of git development 
better go with proper solution then compatibility compromises.

A suggestion I would like to present is if can be useful a
kind of scheduling/list of planned compatibility break features so
 that developers can know in advance when and what will break
 their stuff and users can know when they will need to upgrade.







		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
