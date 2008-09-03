From: "Alexander Gladysh" <agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Git Gui does not want to work on chunk level
Date: Wed, 3 Sep 2008 23:23:19 +0400
Message-ID: <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Sep 03 21:24:33 2008
Return-path: <grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from wf-out-1516.google.com ([209.85.200.166])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaxxt-0000DC-Og
	for gcggu-git-users@m.gmane.org; Wed, 03 Sep 2008 21:24:30 +0200
Received: by wf-out-1516.google.com with SMTP id n22so786294wfa.33
        for <gcggu-git-users@m.gmane.org>; Wed, 03 Sep 2008 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:in-reply-to:mime-version:content-type
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=kFxKimdWd9lXE6x37WK0adukIFUbIp1sfmxnlwvzu4I=;
        b=gJNJQAEHezzbi9lPw5B2GTGfRb4Ht0FspGRd5R3QkpOUB+y0EdVUfxReR6lJdiD6Qh
         KN5sulrYkNXPXxkGBvItaCG8NSvmxkXKV7P80ys8RmasJZLyJ2ayiScEvP+A5nrh9sc9
         Ima4HqRM8oQxrlPH/UvBKTF6Zo6hddTNY+NTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :in-reply-to:mime-version:content-type:references:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=lC7vxW3Zpz7FsgrY3WUBbBAdk3PqthcrV2owGpi5PXzPxEg9PArqACD/rNsRzpMN0f
         oHjh2DhqavzI/DA9dqMjUC63NxJ36HHg/S9nFSYHGvTk2Fv96+qzXNxGzXLkOnCpmN1p
         4FBuTNwEixX1wArVfy/H1wUr3+lfotjhcZ7ZA=
Received: by 10.142.131.5 with SMTP id e5mr259760wfd.28.1220469801160;
        Wed, 03 Sep 2008 12:23:21 -0700 (PDT)
Received: by 10.106.151.34 with SMTP id y34gr139prd.0;
	Wed, 03 Sep 2008 12:23:21 -0700 (PDT)
X-Sender: agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.214.244.12 with SMTP id r12mr11309889qah.19.1220469800784; Wed, 03 Sep 2008 12:23:20 -0700 (PDT)
Received: from yx-out-1718.google.com ([172.21.9.3]) by mx.google.com with ESMTP id 7si15841508yxg.0.2008.09.03.12.23.20; Wed, 03 Sep 2008 12:23:20 -0700 (PDT)
Received-SPF: neutral (google.com: 172.21.9.3 is neither permitted nor denied by domain of agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) client-ip=172.21.9.3;
Authentication-Results: mx.google.com; spf=neutral (google.com: 172.21.9.3 is neither permitted nor denied by domain of agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) smtp.mail=agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by yx-out-1718.google.com with SMTP id 3so1310377yxi.52 for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 03 Sep 2008 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references; bh=zLB9c+e2cP/tckLuOEf1UrcdC8nYTcefCmsFNcoZC5U=; b=h1ItTzYTDG3vOfqnfb6kFf/4jjHLRgH7ENC1GdoQGp0gRjnwGcIVflZRBSFGiIiXtY SJd2p8N8dJbJ60Km5AmNy7POW1zt+zLShtB/nScNO7w1ymGa76Cb/o/EjJrCOupla2Bn 7lYJzxWnSmF5mwMyPhV+rA2fJBM1it99t8jZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:in-reply-to:mime-version :content-type:content-transfer-encoding:content-disposition :references; b=er3ZheN73yL36IeFavWWef00YrjeTOfrxis1lgKCNs0WC5yfDHvDyyvVIuQfVd6aCP Kg6KLO5620JSo+qy5VUag2FRIbwb+gIU3Xs6MegGHncR0z3Ce0qPBUPOKT8MZZKtuPxu 5/juJBSAhd1FWPOHuNFoqNzu4eg1J8wPNq30Y=
Received: by 10.114.205.1 with SMTP id c1mr7999172wag.171.1220469799703; Wed, 03 Sep 2008 12:23:19 -0700 (PDT)
Received: by 10.115.95.8 with HTTP; Wed, 3 Sep 2008 12:23:19 -0700 (PDT)
In-Reply-To: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact git-users+owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <git-users.googlegroups.com>
List-Post: <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/git-users/subscribe>,
	<mailto:git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-BeenThere-Env: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94841>


Hi, list!

On Wed, Aug 27, 2008 at 1:16 PM, Alexander Gladysh <agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> $ git --version
> git version 1.6.0.GIT
>
> $ git gui --version
> git-gui version 0.11.GITGUI
>
> I like 'stage hunk for commit' feature in Git Gui, but often it gives
> me an error message box:
>
> fatal: git-apply: bad git-diff - inconsistent old filename on line 4

Please advise how should I formulate this question to get an answer. I
understand that it is hard to say something on the subject with that
little info I provide, but anyway. I'm encountering this problem on
roughly every fifth commit, and it is quite annoying, since I've got
used to small feature-based per-chunk commits.

Does anyone else encounter this kind of error? Any debugging advice?
Perhaps I can instrument git gui with logging somewhere (dump diffs
for example). (I have no experience with TCL though.)

If error appears for single file diff, it would be reproduced each
time I try to stage hunk from that diff. I have one such uncommitted
diff now (can't send it, sorry), please advise what can I do to debug
it.

Alexander.
