From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH v2] config: preserve config file permissions
 on edits
Date: Mon, 19 May 2014 21:21:15 +0200
Message-ID: <CABPQNSYj1fLZAqUdOJFq5wxDU3KCOwyBG=Wt4AVrXtnjnXFTYA@mail.gmail.com>
References: <20140505215853.GA23299@dcvr.yhbt.net> <20140506001714.GA29049@dcvr.yhbt.net>
 <5379AF29.4000508@viscovery.net> <CABPQNSZMExeXXMEUNE9HneK1rfXeLoK=vHZkm38xKt_2VctjXQ@mail.gmail.com>
 <CABPQNSbja2x1boJDGbJHGGxq6OiVe_gG56ROFhWyfAf4sNQkRQ@mail.gmail.com> <1400527078.32635.5.camel@thomas-debian-x64>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, Eric Wong <normalperson@yhbt.net>, 
	Junio C Hamano <gitster@pobox.com>, GIT Mailing-list <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBDR53PPJ7YHRBVFT5GNQKGQEAZIPQIQ@googlegroups.com Mon May 19 21:22:00 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBVFT5GNQKGQEAZIPQIQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f189.google.com ([209.85.214.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBVFT5GNQKGQEAZIPQIQ@googlegroups.com>)
	id 1WmT8H-0005Z9-Sk
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 21:21:58 +0200
Received: by mail-ob0-f189.google.com with SMTP id nu7sf1274713obb.6
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=AEZcGWieP/6244JqlZZ3/HXg6CEf8H8e7Uz0Nlnel3E=;
        b=j6Fk4UXvv+iP/X5NmPa0MfqUtqZMMfLLr+2rGyQtFC1GqbSft9OLLJaHz7MDOYRtxt
         Twe/Ly4geiGbv/ksomRAg9gpG85hGLSjjTI7IjAbizmiAgJDcXkIAFY+zIHYwQLsM7So
         sRMP3CITShsUHgShEJiVj28064ZFPHPTJlssZ76TERjCcmaMbhoI+Pfp/kLIQGPQ8HWv
         3BQk+Det6SH4k+/MBkGHbz2IHNq6HujiofqMO7+tqpuETbSA4aZDMdF9P5de2YEvh1ao
         fP6XDASWpi4Ll3p8zC8Tfq46UgApt9FV9GQ7s5cafJrLHtEfl8eRV7UEhsXMtn1X7m8j
         Im5Q==
X-Received: by 10.50.66.166 with SMTP id g6mr11049igt.16.1400527316995;
        Mon, 19 May 2014 12:21:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.112.71 with SMTP id io7ls11652igb.23.gmail; Mon, 19 May
 2014 12:21:56 -0700 (PDT)
X-Received: by 10.67.5.165 with SMTP id cn5mr15670942pad.9.1400527316042;
        Mon, 19 May 2014 12:21:56 -0700 (PDT)
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com [2607:f8b0:4001:c03::229])
        by gmr-mx.google.com with ESMTPS id 6si735365igs.1.2014.05.19.12.21.56
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 May 2014 12:21:56 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::229 as permitted sender) client-ip=2607:f8b0:4001:c03::229;
Received: by mail-ie0-f169.google.com with SMTP id at1so2814822iec.28
        for <msysgit@googlegroups.com>; Mon, 19 May 2014 12:21:55 -0700 (PDT)
X-Received: by 10.50.154.67 with SMTP id vm3mr333741igb.43.1400527315918; Mon,
 19 May 2014 12:21:55 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 19 May 2014 12:21:15 -0700 (PDT)
In-Reply-To: <1400527078.32635.5.camel@thomas-debian-x64>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249615>

On Mon, May 19, 2014 at 9:17 PM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
> Am Montag, den 19.05.2014, 11:59 +0200 schrieb Erik Faye-Lund:
>> On Mon, May 19, 2014 at 9:44 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> > On Mon, May 19, 2014 at 9:13 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> >> Am 5/6/2014 2:17, schrieb Eric Wong:
>> >>> Users may already store sensitive data such as imap.pass in
>> >>> ..git/config; making the file world-readable when "git config"
>> >>> is called to edit means their password would be compromised
>> >>> on a shared system.
>> >>>
>> >>> [v2: updated for section renames, as noted by Junio]
>> >>>
>> >>> Signed-off-by: Eric Wong <normalperson@yhbt.net>
>> >>> ---
>> >>>  config.c               | 16 ++++++++++++++++
>> >>>  t/t1300-repo-config.sh | 10 ++++++++++
>> >>>  2 files changed, 26 insertions(+)
>> >>>
>> >>> diff --git a/config.c b/config.c
>> >>> index a30cb5c..c227aa8 100644
>> >>> --- a/config.c
>> >>> +++ b/config.c
>> >>> @@ -1636,6 +1636,13 @@ int git_config_set_multivar_in_file(const char *config_filename,
>> >>>                       MAP_PRIVATE, in_fd, 0);
>> >>>               close(in_fd);
>> >>>
>> >>> +             if (fchmod(fd, st.st_mode & 07777) < 0) {
>> >>> +                     error("fchmod on %s failed: %s",
>> >>> +                             lock->filename, strerror(errno));
>> >>> +                     ret = CONFIG_NO_WRITE;
>> >>> +                     goto out_free;
>> >>> +             }
>> >>
>> >> This introduces a severe failure in the Windows port because we do not
>> >> implement fchmod. Existing fchmod invocations do not check the return
>> >> value, and they are only interested in removing the write bits, and we
>> >> generally don't care a lot if files remain writable.
>> >>
>> >> I'm not proficient enough to add any ACL fiddling to fchmod that would be
>> >> required by the above change, whose purpose is to be strict about
>> >> permissions. Nor am I interested (who the heck is sharing a Windows box
>> >> anyway? ;-)
>> >>
>> >> Therefore, here's just a work-around patch to keep things going on
>> >> Windows. Any opinions from the Windows corner?
>> >>
>> >
>> > Since we use MSVCRT's chmod implementation directly which only checks
>> > for S_IWRITE,and Get/SetFileAttributes to simply set or clear the
>> > FILE_ATTRIBUTE_READONLY-flag, perhaps we could do the same except
>> > using Get/SetFileInformationByHandle instead? That takes us in a
>> > better direction, IMO. Adding full ACL support seems like a bigger
>> > project.
>> >
>> > If there's no objection, I'll sketch up a patch for that...
>>
>> OK, this turned out a bit more yucky than I assumed, because
>> SetFileInformationByHandle is only available on Windows Vista and up.
>> There's a static library (FileExtd.lib) that ships with MSVC that
>> emulates it for legacy support, I guess I should have a look at what
>> that does.
>
> Do we still want to fully support Windows XP?
> Adding a work around here for a EOL operating system sounds like a lot
> of effort.

I personally don't care about Windows XP, but some other influential
people (J6T IIRC) disagreed the last time this was discussed. I don't
want to step on anyone's toes.

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
