From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help
 option.
Date: Wed, 24 Oct 2007 09:28:18 +0900
Message-ID: <471E91A2.5010001@gmail.com>
References: <bqaujirk.fsf@blue.sea.net> <Pine.LNX.4.64.0710202126430.25221@racer.site> <odetifoh.fsf@blue.sea.net> <Pine.LNX.4.64.0710210001390.25221@racer.site> <20071021020653.GA14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 02:29:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkU7U-0001uY-KO
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 02:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbXJXA3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 20:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbXJXA3B
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 20:29:01 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:50430 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbXJXA3A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 20:29:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so25379rvb
        for <git@vger.kernel.org>; Tue, 23 Oct 2007 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=hFBTVjQI3oVNpVxwbVtV29AiSgr4vMzrH4xhIY7krE0=;
        b=S58RPjuAvXVpZUg7DwWYNC6/rQOOVOqsGWIzyWjeTx5ray0mg5V6tOydPRw6zgH//gM4HQGu4NPkB0HrCnxwce5ZS3/ZZueX1mlzUmlgqqjcrXRauBK1goAJuWIlyK8cYwh6/xGlOlVJMircb/zKMmAzh0VXvA1mDKjTHT5P1lI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sOSzLAWgQ7SypJzhItyzSWjwe0YjzK8Waw9PuTLhMzadBW06GYTReBz4wLhIWOBwKBmY2Z4BuNcg6QjK6lk7j/m0YEIKu8WotRrnL79gwuLhBp6TmxzBd/m2gV0twf3VafV+jNyEuI5Idkb3aHMb+pIMl4P/NzNQdEhmGgo337U=
Received: by 10.141.172.6 with SMTP id z6mr3400rvo.1193185739475;
        Tue, 23 Oct 2007 17:28:59 -0700 (PDT)
Received: from ?221.115.75.108? ( [221.115.75.108])
        by mx.google.com with ESMTPS id b34sm246233rvf.2007.10.23.17.28.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Oct 2007 17:28:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070819)
In-Reply-To: <20071021020653.GA14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62175>

Shawn O. Pearce wrote:
> Hmm.  Lets see.
> 
>   "cvs foo":
>     Big spew of commands.  Like "git foo".
> 
>   "svn foo":
>     Unknown command: 'foo'
>     Type 'svn help' for usage.
> 
> Both are considered to be more newbie friendly then Git.  So clearly
> SVN's output of almost nothing is friendly.  And so is CVS'
> big spew of frequently used commands.  Either way is apparently
> newbie friendly.
> 
> Though I find SVN's message a little insulting, asking me to type.
> I know I have to type the command, thanks.

On the contrary, I consider CVS and current Git output more insulting,
as it assumes I forgot all the commands every time I made a typo.

The polite part of the message is to point out a typo, 
as "Unknown command 'foo'" above. The "Type "svn help" for usage" part
is just a reminder for complete newbies, which doesn't take too much space
and can be reasonably ignored by experienced users.
