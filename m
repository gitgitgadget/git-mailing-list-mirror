From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: New way of tracking remote branches -- question
Date: Tue, 9 Jan 2007 21:57:09 +1300
Message-ID: <46a038f90701090057w31d46530x4f70a76287bbef33@mail.gmail.com>
References: <776323.21089.qm@web31808.mail.mud.yahoo.com>
	 <7vejq9c9tf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ltuikov@yahoo.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 09:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4CnD-00041X-4q
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 09:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXAII5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 03:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbXAII5L
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 03:57:11 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:47060 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbXAII5K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 03:57:10 -0500
Received: by wx-out-0506.google.com with SMTP id h31so339319wxd
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 00:57:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WzT2qoNblHgpsvKZ9GvKAZzy9lsmjd1UaLZkWLUQC4XPIYgRfuoBr2TZgaDXKjl/D5tIOj3AfixUdLRqPSJDflfJg2kqXTpdyrJM4eSwBDmAB/UgckNqe9vjbrB2WRMx+7bKPqOxjmAdJJOlLYSs6VH9T1z+/S3Fvo1RK6RaLwI=
Received: by 10.90.81.14 with SMTP id e14mr2630504agb.1168333029298;
        Tue, 09 Jan 2007 00:57:09 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Tue, 9 Jan 2007 00:57:09 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vejq9c9tf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36332>

On 1/6/07, Junio C Hamano <junkio@cox.net> wrote:
> You are talking about the separate remote layout "git clone"
> creates, and talking about the fact that there is nothing in
> refs/heads/ except master while refs/remotes/origin/ mirrors
> what the remote side has faithfully, aren't you?
>
> If that is the case, I can explain.  It is a good topic to talk
> about.

It's confusing me too ;-) though I think I'm getting to understand it.
Still more comfortable with the cogito style, personally. The only
thing I see as a clear improvement in git "remotes" is that I can
fetch a bundle of heads for review. And that it can track heads that
rewind. All the magic that happens if you have multiple pull lines is
a bit scary, the kind of thing that should be disallowed or use a
different syntax.

One aspect that I am getting used to, but I still consider slightly
bogus is that as we have added a layer of indirection, what used to
point to a specific remote branch now points to a bundle or remotes
heads.

It is quite disconcerting to say git-pull origin, and see that pu is
being pulled in. And  fortunately I'm tracking repos that don't have
an 'origin' head. Otherwise I'd get origin/origin. :-(

[reading on now...]



martin
