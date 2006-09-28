From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 15:25:42 -0700
Message-ID: <451C4BE6.20407@gmail.com>
References: <20060928221237.85837.qmail@web51015.mail.yahoo.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Rogan Dawes <discard@dawes.za.net>
X-From: git-owner@vger.kernel.org Fri Sep 29 00:26:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT4Ke-0005E1-6y
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161336AbWI1WZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 18:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWI1WZs
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:25:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:30805 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161336AbWI1WZr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 18:25:47 -0400
Received: by nz-out-0102.google.com with SMTP id n1so325686nzf
        for <git@vger.kernel.org>; Thu, 28 Sep 2006 15:25:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Lmniu3hIYoRwVyDcMs2aUadiXdMjMR0OsEOlEVSR87r9EJ2G83+xOlx0wh61zlD81f8CGCkWZLTw7KExOL7AmNwtcfLU7UvWdqhWUdRJnqsub74IJRLjAoB33nWEoXPZ22/Xa7uHIK9Q2gsFnhHdNCWspXhbSHTHKzjDHXDPHLs=
Received: by 10.65.204.7 with SMTP id g7mr2643855qbq;
        Thu, 28 Sep 2006 15:25:46 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id d2sm2606169qbc.2006.09.28.15.25.45;
        Thu, 28 Sep 2006 15:25:46 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060928221237.85837.qmail@web51015.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28058>

Matthew L Foster wrote:
> --- A Large Angry SCM <gitzilla@gmail.com> wrote:
> 
>> Sounds like you're suggesting that Git should not record any timestamps 
>> at all. After all, Git doesn't need them.
> 
> Yeah kind of, since distributed git doesn't need timestamps and can't guarantee them the only time
> that might make any sense to use locally is local commit time. 

There is no local commit time for things you get from a remote repository.

When I wrote "Sounds like you're suggesting that Git should not record 
any timestamps at all", I meant _you_ don't think Git should record 
_any_ timestamps since they can't be guaranteed to match the DAG.
