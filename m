From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Re: [PATCH v2] config: preserve config file permissions
 on edits
Date: Mon, 19 May 2014 21:17:58 +0200
Message-ID: <1400527078.32635.5.camel@thomas-debian-x64>
References: <20140505215853.GA23299@dcvr.yhbt.net>
	 <20140506001714.GA29049@dcvr.yhbt.net> <5379AF29.4000508@viscovery.net>
	 <CABPQNSZMExeXXMEUNE9HneK1rfXeLoK=vHZkm38xKt_2VctjXQ@mail.gmail.com>
	 <CABPQNSbja2x1boJDGbJHGGxq6OiVe_gG56ROFhWyfAf4sNQkRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, Eric Wong <normalperson@yhbt.net>,
  Junio C Hamano <gitster@pobox.com>, GIT Mailing-list
 <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: msysgit+bncBCL7JHHTPAIOVMPJTMCRUBH6KVGL4@googlegroups.com Mon May 19 21:18:03 2014
Return-path: <msysgit+bncBCL7JHHTPAIOVMPJTMCRUBH6KVGL4@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIOVMPJTMCRUBH6KVGL4@googlegroups.com>)
	id 1WmT4V-00075D-1Q
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 21:18:03 +0200
Received: by mail-wi0-f192.google.com with SMTP id z2sf360756wiv.29
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=wcteOAtdMtCK6cSj4zwEL5gpooU11USzAKEC7QVeYck=;
        b=wWvo7w82B6KYZ22mlDYTK/UIOMRWwwIoVmohJ5m1czhmjkrj9xKXPOowbEuZG3cSDV
         dF1FXZAA2yew7zcre/9A5ysjk2/EqcCFpd5rtdnOUj5R8uXV77HLnSDdxVX8h4i7M/1Q
         y+3yiA9cDsaxDvXbEA6G3szGjfkNX9lP7BpH2imsoMe1GwSlCiIGIvso1J3drmc3RlV7
         DhtUd5AYy1RP99knf48J9yqNSe2gJ070FZwo22T5Ma6adwXlfhqF/LOcDlZE6DIM0TiI
         YXNVYYu/hYCYPVgxQegepwtPXHbpNHscrR7gHzLSViUWype1kcIUMI1ZdTYUHkzed+95
         yNtg==
X-Received: by 10.152.28.101 with SMTP id a5mr411110lah.4.1400527082730;
        Mon, 19 May 2014 12:18:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.2.170 with SMTP id 10ls309660lav.108.gmail; Mon, 19 May
 2014 12:18:01 -0700 (PDT)
X-Received: by 10.112.140.170 with SMTP id rh10mr3057762lbb.7.1400527081967;
        Mon, 19 May 2014 12:18:01 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id r49si209804eep.0.2014.05.19.12.18.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 May 2014 12:18:01 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc1dd3.dip0.t-ipconnect.de ([93.220.29.211] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1WmT4Q-000126-PB; Mon, 19 May 2014 21:17:58 +0200
In-Reply-To: <CABPQNSbja2x1boJDGbJHGGxq6OiVe_gG56ROFhWyfAf4sNQkRQ@mail.gmail.com>
X-Mailer: Evolution 3.4.4-3
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1400527081;ccc274a0;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249614>

Am Montag, den 19.05.2014, 11:59 +0200 schrieb Erik Faye-Lund:
> On Mon, May 19, 2014 at 9:44 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> > On Mon, May 19, 2014 at 9:13 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> >> Am 5/6/2014 2:17, schrieb Eric Wong:
> >>> Users may already store sensitive data such as imap.pass in
> >>> ..git/config; making the file world-readable when "git config"
> >>> is called to edit means their password would be compromised
> >>> on a shared system.
> >>>
> >>> [v2: updated for section renames, as noted by Junio]
> >>>
> >>> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> >>> ---
> >>>  config.c               | 16 ++++++++++++++++
> >>>  t/t1300-repo-config.sh | 10 ++++++++++
> >>>  2 files changed, 26 insertions(+)
> >>>
> >>> diff --git a/config.c b/config.c
> >>> index a30cb5c..c227aa8 100644
> >>> --- a/config.c
> >>> +++ b/config.c
> >>> @@ -1636,6 +1636,13 @@ int git_config_set_multivar_in_file(const char *config_filename,
> >>>                       MAP_PRIVATE, in_fd, 0);
> >>>               close(in_fd);
> >>>
> >>> +             if (fchmod(fd, st.st_mode & 07777) < 0) {
> >>> +                     error("fchmod on %s failed: %s",
> >>> +                             lock->filename, strerror(errno));
> >>> +                     ret = CONFIG_NO_WRITE;
> >>> +                     goto out_free;
> >>> +             }
> >>
> >> This introduces a severe failure in the Windows port because we do not
> >> implement fchmod. Existing fchmod invocations do not check the return
> >> value, and they are only interested in removing the write bits, and we
> >> generally don't care a lot if files remain writable.
> >>
> >> I'm not proficient enough to add any ACL fiddling to fchmod that would be
> >> required by the above change, whose purpose is to be strict about
> >> permissions. Nor am I interested (who the heck is sharing a Windows box
> >> anyway? ;-)
> >>
> >> Therefore, here's just a work-around patch to keep things going on
> >> Windows. Any opinions from the Windows corner?
> >>
> >
> > Since we use MSVCRT's chmod implementation directly which only checks
> > for S_IWRITE,and Get/SetFileAttributes to simply set or clear the
> > FILE_ATTRIBUTE_READONLY-flag, perhaps we could do the same except
> > using Get/SetFileInformationByHandle instead? That takes us in a
> > better direction, IMO. Adding full ACL support seems like a bigger
> > project.
> >
> > If there's no objection, I'll sketch up a patch for that...
> 
> OK, this turned out a bit more yucky than I assumed, because
> SetFileInformationByHandle is only available on Windows Vista and up.
> There's a static library (FileExtd.lib) that ships with MSVC that
> emulates it for legacy support, I guess I should have a look at what
> that does.

Do we still want to fully support Windows XP?
Adding a work around here for a EOL operating system sounds like a lot
of effort.



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
