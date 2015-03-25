From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Sparse checkout not working as expected (colons in
 filenames on Windows)
Date: Wed, 25 Mar 2015 07:46:04 +0700
Message-ID: <CACsJy8AACwDPSEWdGiLLK3PTY=hLm0XOvN4_y4PbCFYrMzrnHg@mail.gmail.com>
References: <BE2660C974C9415E997F20A49ABC766E@PhilipOakley>
 <CACsJy8BOuhohQzaGzD+4cthqOaL4sz1ADRD-ekhFhKt4wMcg7A@mail.gmail.com> <90D5D4B5F2ED41A6AB07E291004AA615@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Yue Lin Ho <yuelinho777@gmail.com>, 
	msysGit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBC2ZN5PHQUMBB24KZCUAKGQEQ2DK5EA@googlegroups.com Wed Mar 25 01:46:36 2015
Return-path: <msysgit+bncBC2ZN5PHQUMBB24KZCUAKGQEQ2DK5EA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f190.google.com ([209.85.223.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBB24KZCUAKGQEQ2DK5EA@googlegroups.com>)
	id 1YaZSu-0007nY-2S
	for gcvm-msysgit@m.gmane.org; Wed, 25 Mar 2015 01:46:36 +0100
Received: by iery20 with SMTP id y20sf6048267ier.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Mar 2015 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=mPTW9jiWadrXsspJSMTIpmxQOuYsEIDEDiFoD+VM+nA=;
        b=HUDeObMznxiQ/HqPhnl/o/b1WwpWlB5LOVkQ/3FiHQ+9Cu3tbB1UzWZ1dit4nRFO64
         YEpS/laawA3zXSN8EthhaghJa6ew1/R2h5NEq39U1S42dVJhuBxJAkUbmJpTj9draEgl
         TdwPfKMSQVCUhjc6Ndq7HvatHbH8Fc/rCzrIIWkL0EvuI7ybDjtp+WNHE1XObqCWHjOV
         krFQBlLpdWXi8pcsMu5dKSgRzy1PtTfMzyMxOc/wQ18KcLUEU0sOw5I1H8nZkI2G/JvS
         2cdQq0f8HFk9a08BPxLT9yU7EC4YPz60U+6rsvMzihaXfGwC9KClSnyZ3veNPdPBsrXu
         VXZA==
X-Received: by 10.140.91.10 with SMTP id y10mr109142qgd.39.1427244395224;
        Tue, 24 Mar 2015 17:46:35 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.109.10 with SMTP id k10ls204964qgf.22.gmail; Tue, 24 Mar
 2015 17:46:34 -0700 (PDT)
X-Received: by 10.236.110.38 with SMTP id t26mr7559612yhg.1.1427244394890;
        Tue, 24 Mar 2015 17:46:34 -0700 (PDT)
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com. [2607:f8b0:4001:c03::22b])
        by gmr-mx.google.com with ESMTPS id e4si1028747igt.3.2015.03.24.17.46.34
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 17:46:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4001:c03::22b as permitted sender) client-ip=2607:f8b0:4001:c03::22b;
Received: by mail-ie0-x22b.google.com with SMTP id fl3so12536100ied.1
        for <msysgit@googlegroups.com>; Tue, 24 Mar 2015 17:46:34 -0700 (PDT)
X-Received: by 10.50.57.78 with SMTP id g14mr7121631igq.41.1427244394675; Tue,
 24 Mar 2015 17:46:34 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 24 Mar 2015 17:46:04 -0700 (PDT)
In-Reply-To: <90D5D4B5F2ED41A6AB07E291004AA615@PhilipOakley>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4001:c03::22b
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266244>

On Wed, Mar 25, 2015 at 6:50 AM, Philip Oakley <philipoakley@iee.org> wrote:
> I've corrected the sparse-checkout, but won't the command line 'git
> update-index --skip-worktree' will still need it? (demo commands below)

A "git checkout" (without arguments) or "read-trree -mu" should attach
skip-worktree properly. You don't need to do it yourself.

> That said, the final error (which I'd missed in the earlier post) is:
> fatal: make_cache_entry failed for path 'ifcfg-eth0:0'
>
> This is on the Windows (pre-compiled msysgit at v1.9.5) Git bash, so could
> be a catch path in that code for make_cache_entry (I've not checked the code
> yet). So at the moment it doesn't look like sparse checkout can be used to
> avoid colons in windows on-disk files based on the current code.

Both of your commands below fail by the same function, verify_path()
because of this msysgit commit 2e2a2d1 (NTFS: Prevent problematic
paths from being checked out - 2014-12-10). I guess that check is a
bit too strong, it should apply when new index entries are created
from worktree (not from a tree)..

> --
> Philip
>
> Philip@PHILIPOAKLEY /d/Git_repos/colons
> $ cd tortoisegit-colons/
>
> Philip@PHILIPOAKLEY /d/Git_repos/colons/tortoisegit-colons (test)
> $ git update-index --skip-worktree -- ifcfg-eth0\:0
> Ignoring path ifcfg-eth0:0
>
> Philip@PHILIPOAKLEY /d/Git_repos/colons/tortoisegit-colons (test)
> $ git reset
> error: Invalid path 'ifcfg-eth0:0'
> fatal: make_cache_entry failed for path 'ifcfg-eth0:0'
-- 
Duy

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
