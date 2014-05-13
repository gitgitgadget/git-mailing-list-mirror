From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Bug - Git reset --quiet not quiet
Date: Tue, 13 May 2014 11:09:43 +0200
Message-ID: <CABPQNSaj3xwknXsrYnF35tcDAmTwK5KALOsUOgHF_hrEf2H_+g@mail.gmail.com>
References: <764966de191443d68e7ceca790b641ff@CO1PR02MB029.namprd02.prod.outlook.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Thomas-Louis Laforest <tllaforest@arbault.ca>
X-From: msysgit+bncBDR53PPJ7YHRB76CY6NQKGQEDPEQJLA@googlegroups.com Tue May 13 11:10:27 2014
Return-path: <msysgit+bncBDR53PPJ7YHRB76CY6NQKGQEDPEQJLA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB76CY6NQKGQEDPEQJLA@googlegroups.com>)
	id 1Wk8jB-0006oo-3J
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 11:10:25 +0200
Received: by mail-yk0-f186.google.com with SMTP id q9sf3079ykb.13
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 May 2014 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=9sKJf9MvUZpooO3cu/TJPtGZMnoTYgAf157tRp7S/uU=;
        b=FtCBQnk3WNJtv4hmuPr793ZTPOPitbO6BiH+HOCEDjYCQsunkkFAk8qizS4d7OE2xT
         ulsvbh4dqVZESN9K3KJCsm2hA8k8xlvp0oK4dmqJzL/Xb9NoaJllXI6GVeNqkbpZ2PNw
         5via1wNpto5zCDpScfPhDEhjI/bMl0jom7fMGVUlL9hDJ597pTH/6ILIAOsiXu/b685S
         g5Da4k01XMAH6hA+Ud38kxg+h0rgu/bHkLGShSwjrRJK0e2k4DfUc5QZ1mJsGjqcLSzm
         GfTIlCrCdaaY7gx7hiepxXiAGsbn/qKZA5ldwvVi61qJMApVdnjRQwxZH4ANc94ropsB
         lTjw==
X-Received: by 10.50.79.227 with SMTP id m3mr620150igx.3.1399972224141;
        Tue, 13 May 2014 02:10:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.102.9 with SMTP id fk9ls2175360igb.6.gmail; Tue, 13 May
 2014 02:10:23 -0700 (PDT)
X-Received: by 10.66.121.195 with SMTP id lm3mr14449406pab.24.1399972223282;
        Tue, 13 May 2014 02:10:23 -0700 (PDT)
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com [2607:f8b0:4001:c03::229])
        by gmr-mx.google.com with ESMTPS id n5si895534igk.2.2014.05.13.02.10.23
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 02:10:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::229 as permitted sender) client-ip=2607:f8b0:4001:c03::229;
Received: by mail-ie0-f169.google.com with SMTP id lx4so39534iec.28
        for <msysgit@googlegroups.com>; Tue, 13 May 2014 02:10:23 -0700 (PDT)
X-Received: by 10.50.30.6 with SMTP id o6mr54268331igh.43.1399972223177; Tue,
 13 May 2014 02:10:23 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 02:09:43 -0700 (PDT)
In-Reply-To: <764966de191443d68e7ceca790b641ff@CO1PR02MB029.namprd02.prod.outlook.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::229
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248757>

On Mon, May 12, 2014 at 9:16 PM, Thomas-Louis Laforest
<tllaforest@arbault.ca> wrote:
> Good afternoon,
>
> When running this command on Git for Windows (version 1.9.2-preview20140411)
> git reset --quiet --hard with one file having read/write lock git ask this question :
> Unlink of file 'XXXX' failed. Should I try again? (y/n)
>
> I will have expected the command --quiet to remove the question and auto-answer no.
> This broke an automated script we use.

Thanks for reporting this.

The problem here is really a nasty case of layering: the question
comes from a place deep inside the OS compatibility layer, which
doesn't know about the --quiet flag.

However, do note that if fixed, the command would still fail under
these conditions. But it won't hang forever, as it does now.

Mainline Git-folks: The problem here is essentially unlink returning
EBUSY (although that's not *exactly* what happes - but it's close
enough, implementation details in mingw_unlink), which most of the git
codebase assume won't happen. On Windows, this happens *all* the time,
usually due to antivirus-software scanning a newly written file. We
currently retry a few times with some waiting in mingw_unlink, and
then finally prompts the user. But this gives the problem described
above, as mingw_unlink has no clue about --quiet.

I guess this could be solved in a few ways.
1) Let mingw_unlink() know about the quiet-flag. This probably
involves moving the quiet-flag from each tool into libgit.a.
2) Make the quiet-flags close stdout instead of suppressing every output.
3) Make the higher level call-sites of Git EBUSY-aware. This probably
involves making an interactive convenience-wrapper of unlink, that
accepts a quiet flag - similar to what mingw_unlink does.

Option 1) seems quite error-prone to me - it's difficult to make sure
all code-paths actually set this flag, so there's a good chance of
regressions. Option 2) also sounds a bit risky, as we lose stdout
forever, with no escape-hatch. So to me option 3) seems preferable
although it might translate into a bit of churn. Thoughts?

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
