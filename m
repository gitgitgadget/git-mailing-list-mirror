From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] config: preserve config file permissions on edits
Date: Mon, 19 May 2014 09:13:45 +0200
Message-ID: <5379AF29.4000508@viscovery.net>
References: <20140505215853.GA23299@dcvr.yhbt.net> <20140506001714.GA29049@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
 msysGit <msysgit@googlegroups.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: msysgit+bncBCJYV6HBKQILFXXGTMCRUBHOMUOQO@googlegroups.com Mon May 19 09:13:58 2014
Return-path: <msysgit+bncBCJYV6HBKQILFXXGTMCRUBHOMUOQO@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQILFXXGTMCRUBHOMUOQO@googlegroups.com>)
	id 1WmHlj-0001Iy-Vq
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 09:13:56 +0200
Received: by mail-wi0-f191.google.com with SMTP id r20sf279801wiv.28
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Q2iG0/35+m4S0ellUPnRh9bIAs0ZrH3iVe5CkZFExzk=;
        b=ACOBLuCE4IpAFlDDa01z5tOURH9oVQqN93s/5C5Z2z755f/OEE6F9LzOzbJ+898AVH
         4Ct07g8/gTzSeXiW0C18FcoLimjqzMS7//ApNIhg1kp+o0T+gGwKCDOuYTeD6tk/HVVh
         1t0BrOvMBEvOd4QNlOGSCJIzE3oCYeK19bU1x82eGyt5ndXsMXpA4SQ2lNyl/tgfm/Bp
         h3y35GSCioGQPieWO+NnT1NMMy0wLNqKgYpD77ZBt8fg5UcoqKpVoit5oW1HH2Eai7NN
         7SqZzL7wcDPO870A2i1qHhoBgrvOtJD9nVjnFvauhlZLz8UBE32D7EGC/P37RSOCsqqw
         duiQ==
X-Received: by 10.152.8.193 with SMTP id t1mr2846laa.11.1400483635667;
        Mon, 19 May 2014 00:13:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.30.2 with SMTP id o2ls246136lah.40.gmail; Mon, 19 May 2014
 00:13:54 -0700 (PDT)
X-Received: by 10.112.156.138 with SMTP id we10mr94904lbb.12.1400483634557;
        Mon, 19 May 2014 00:13:54 -0700 (PDT)
Received: from so.liwest.at (so.liwest.at. [212.33.55.23])
        by gmr-mx.google.com with ESMTPS id r49si18598eep.0.2014.05.19.00.13.54
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 May 2014 00:13:54 -0700 (PDT)
Received-SPF: none (google.com: j.sixt@viscovery.net does not designate permitted sender hosts) client-ip=212.33.55.23;
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WmHla-0002ia-Jn; Mon, 19 May 2014 09:13:49 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3402216613;
	Mon, 19 May 2014 09:13:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20140506001714.GA29049@dcvr.yhbt.net>
X-Spam-Score: -1.0 (-)
X-Original-Sender: j.sixt@viscovery.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j.sixt@viscovery.net does not designate permitted sender hosts) smtp.mail=j.sixt@viscovery.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249562>

Am 5/6/2014 2:17, schrieb Eric Wong:
> Users may already store sensitive data such as imap.pass in
> ..git/config; making the file world-readable when "git config"
> is called to edit means their password would be compromised
> on a shared system.
> 
> [v2: updated for section renames, as noted by Junio]
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  config.c               | 16 ++++++++++++++++
>  t/t1300-repo-config.sh | 10 ++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/config.c b/config.c
> index a30cb5c..c227aa8 100644
> --- a/config.c
> +++ b/config.c
> @@ -1636,6 +1636,13 @@ int git_config_set_multivar_in_file(const char *config_filename,
>  			MAP_PRIVATE, in_fd, 0);
>  		close(in_fd);
>  
> +		if (fchmod(fd, st.st_mode & 07777) < 0) {
> +			error("fchmod on %s failed: %s",
> +				lock->filename, strerror(errno));
> +			ret = CONFIG_NO_WRITE;
> +			goto out_free;
> +		}

This introduces a severe failure in the Windows port because we do not
implement fchmod. Existing fchmod invocations do not check the return
value, and they are only interested in removing the write bits, and we
generally don't care a lot if files remain writable.

I'm not proficient enough to add any ACL fiddling to fchmod that would be
required by the above change, whose purpose is to be strict about
permissions. Nor am I interested (who the heck is sharing a Windows box
anyway? ;-)

Therefore, here's just a work-around patch to keep things going on
Windows. Any opinions from the Windows corner?

--- >8 ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] mingw: turn the always-failing fchmod stub into always-succeeding

A recent change introduced new call sites of fchmod, but these new call
sites check the return value. The test suite can't get past t0001
without a dozen or so failures.

Just fake that the call was successful even though it did nothing.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index c3859cc..7b2455c 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -89,7 +89,7 @@ static inline int readlink(const char *path, char *buf, size_t bufsiz)
 static inline int symlink(const char *oldpath, const char *newpath)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes, mode_t mode)
-{ errno = ENOSYS; return -1; }
+{ /* do nothing */ return 0; }
 static inline pid_t fork(void)
 { errno = ENOSYS; return -1; }
 static inline unsigned int alarm(unsigned int seconds)
-- 
2.0.0.rc3.1741.g0520b9e

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
