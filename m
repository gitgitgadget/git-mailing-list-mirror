From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Errors pushing tags in "next"
Date: Fri, 23 Mar 2007 02:38:41 -0700 (PDT)
Message-ID: <409322.88629.qm@web31809.mail.mud.yahoo.com>
References: <200703230913.12742.andyparkins@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 10:39:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUgEr-0006S4-2r
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 10:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422760AbXCWJin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 05:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422759AbXCWJin
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 05:38:43 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:47993 "HELO
	web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422758AbXCWJim (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2007 05:38:42 -0400
Received: (qmail 90827 invoked by uid 60001); 23 Mar 2007 09:38:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=LtivfTlcwUWkeBxKgEADJL1djeHrW+/rMEreF76s6YuIGEfIHzYKxlugz/1OhUi6WYdr5Q6lmZrCLwhcfGgkk8QTcSuADvkBj3O+dkI9ZxDTZAjur/fgTyXy6wWfCNvGSaju41T92Ymdb8TugvAT0SK4yFH3OkATVQULwZ5nY+w=;
X-YMail-OSG: xQ4Zp9sVM1nBOhd0GOczgXqW6aTzIALC8bOLvtpgR6gZX3vLj2XsIuQDQ_uszOHOZ1cWn6DF_Zm0h3SzAsXbeBZWQzY4beXGo7kxj8Ok.Ixp6zryzNhugI9z7bZKmHPJlXShssVkGSKS.wCeFg5cqA--
Received: from [68.186.59.161] by web31809.mail.mud.yahoo.com via HTTP; Fri, 23 Mar 2007 02:38:41 PDT
In-Reply-To: <200703230913.12742.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42919>

--- Andy Parkins <andyparkins@gmail.com> wrote:
> The output you show is from the update hook from an older version of git, but 
> the git you're running on the remote end is a newer version.  The hook 
> scripts don't get updated when you upgrade git because they're copied to the 
> repository from the latest template when you clone or init.

Yeah, most of my git repos, especially the web exported ones are
truly of an ancient git...

> The fix:  My own suggestion would be to just swap the update hook on the 
> server for the one that came with the latest version of git (although I'm 
> completely biased :-)).  Remember to do this on the remote repository, not 
> your local one.

Yeah, I'll cp(1) the most recent "update" hook I got in "next" to the
ancient web exported repos I own...

> Alternatively; I've got a further update to the notification email script 
> prepared that I'm finishing testing and will send today that updates to use 
> the post-receive hook rather than the update hook and fixes a number of bugs.

Ok, sounds good.

Thanks,
   Luben
