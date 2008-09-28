From: "Erez Zilber" <erezzi.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: git-describe doesn't show the most recent tag
Date: Sun, 28 Sep 2008 16:48:42 +0300
Message-ID: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com>
Reply-To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-FC1hwAUAAAA0O9VQcsxVj1UPjHD9r3x_=glio-open-iscsi=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Sep 28 15:50:23 2008
connect(): Connection refused
Return-path: <grbounce-FC1hwAUAAAA0O9VQcsxVj1UPjHD9r3x_=glio-open-iscsi=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: glio-open-iscsi@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjwfA-00023n-8G
	for glio-open-iscsi@m.gmane.org; Sun, 28 Sep 2008 15:50:16 +0200
Received: by yx-out-2122.google.com with SMTP id 22so1117527yxm.63
        for <glio-open-iscsi@m.gmane.org>; Sun, 28 Sep 2008 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:mime-version:content-type:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=w//JAH3Q5OTlX5Nh7rOhOmO/tkUKqdg3XnoTKlFsuek=;
        b=XYzo8hhiEo9UVrdFWdryxWobnsrBGIdzW7nJrVhuOISfTb1CuIszheY9nhDFGRuQVV
         c7rjfim47dIkQhmM5J0PWGQQJga8yOc7iMCoN9lXSwNo+48ZDhs/OPlnGvr1MBocVCmr
         H9imJGKanMeH6sNAuGqtsblrd5BTN3WlsSGXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :mime-version:content-type:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=UKJuTtYXeGoAO0szMGO2UB3CNG0FE5sYFgmmzG+dsbD6EQ/dEfs8UfrlRI31ELkJTY
         jAIDKGh8XfbgVhfB7/jzzlJ5DvY5tPEI6DbB8ZLJYJ5jx8AX7J4kkS8jhyyz9VwH8qN0
         3LFJ5z1qf7TeCCPovz+I3qwDW5LWfOTyf8vIg=
Received: by 10.90.56.16 with SMTP id e16mr198443aga.5.1222609738741;
        Sun, 28 Sep 2008 06:48:58 -0700 (PDT)
Received: by 10.106.66.4 with SMTP id o4gr11292pra.0;
	Sun, 28 Sep 2008 06:48:45 -0700 (PDT)
X-Sender: erezzi.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.24.1 with SMTP id 1mr813473wax.10.1222609723574; Sun, 28 Sep 2008 06:48:43 -0700 (PDT)
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250]) by mx.google.com with ESMTP id k32si1122771wah.1.2008.09.28.06.48.42; Sun, 28 Sep 2008 06:48:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of erezzi.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.250 as permitted sender) client-ip=209.85.198.250;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of erezzi.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.250 as permitted sender) smtp.mail=erezzi.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0708.google.com with SMTP id k29so1602573rvb.4 for <open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sun, 28 Sep 2008 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:mime-version:content-type:content-transfer-encoding :content-disposition; bh=p03hwA4zRjwIPLYLJ7ask8IIkw2auu1m9bXErdYzdWg=; b=esmKHF4WdxqC4DqIMF7fSQs7v4QDBiRCxtekH+3vKBcYZWtJb6acj1wN95l/UUwe02 TKFNBsC5km0ro/6VlSiSg58+sAE/hGvdgUowlVPQULM6pO5KtBUOiPYUeIT2gquTYlRY dVYFbh7cRWtgqZHeUTte51Lfu4SAeyM4eJ7m4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:mime-version:content-type :content-transfer-encoding:content-disposition; b=ojEZroBzCGtEGJa64ncY/OVE8HnL7O4v6hNXnOIRMiwpKErxgljQwfIlz8OxPhBQ5A zdX6fsO3cvqGYv5Ymp95DytNN0d2rLARdd43Nwxhvy2S8lHP3XQEY6VGb5drNVpUoO1y PXXYntiUBUiELEqzlM8dk8q5lpncCFGhqVBQA=
Received: by 10.141.172.7 with SMTP id z7mr1858202rvo.15.1222609722525; Sun, 28 Sep 2008 06:48:42 -0700 (PDT)
Received: by 10.141.91.21 with HTTP; Sun, 28 Sep 2008 06:48:42 -0700 (PDT)
Sender: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact open-iscsi+owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <open-iscsi.googlegroups.com>
List-Post: <mailto:open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:open-iscsi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/open-iscsi/subscribe>,
	<mailto:open-iscsi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-BeenThere-Env: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-BeenThere: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96966>


Hi,

I'm trying to run git-describe on the open-iscsi git tree
(git://git.kernel.org/pub/scm/linux/kernel/git/mnc/open-iscsi.git):

[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-branch -a
* master
  origin/2.0-869-bugfix
  origin/HEAD
  origin/bnx2i
  origin/cxgb3i
  origin/master
[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-describe
2.0-868-rc1-81-g31c9d42

However, there are newer tags than 2.0-868-rc1:
[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-tag
2.0-868-rc1
2.0-869
2.0-869-rc2
2.0-869-rc3
2.0-869-rc4
2.0-869.1
2.0-869.2
2.0-870-rc1

>From what I see in the man page "git-describe - Show the most recent
tag that is reachable from a commit". In this repository, it doesn't
look like that...

Now, I switch to the "2.0-869-bugfix" branch:
[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-checkout -b
2.0-869-bugfix origin/2.0-869-bugfix
Branch 2.0-869-bugfix set up to track remote branch
refs/remotes/origin/2.0-869-bugfix.
Switched to a new branch "2.0-869-bugfix"

and running again git-describe:
[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-describe
2.0-868-rc1-33-g81133dd

Only if I use the --tags flag, I get what I expected:
[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-describe --tags
2.0-869.2

Why is this happening?

Thanks,
Erez
