From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH v2] config: preserve config file permissions
 on edits
Date: Mon, 19 May 2014 09:44:38 +0200
Message-ID: <CABPQNSZMExeXXMEUNE9HneK1rfXeLoK=vHZkm38xKt_2VctjXQ@mail.gmail.com>
References: <20140505215853.GA23299@dcvr.yhbt.net> <20140506001714.GA29049@dcvr.yhbt.net>
 <5379AF29.4000508@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>, Junio C Hamano <gitster@pobox.com>, 
	GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: msysgit+bncBDR53PPJ7YHRBDXN42NQKGQEEHEE5BA@googlegroups.com Mon May 19 09:45:21 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBDXN42NQKGQEEHEE5BA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f56.google.com ([209.85.220.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBDXN42NQKGQEEHEE5BA@googlegroups.com>)
	id 1WmIG8-0005kO-Fu
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 09:45:20 +0200
Received: by mail-pa0-f56.google.com with SMTP id fb1sf1531538pad.1
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Api0Nr3vM5fumLWakrxoQEk2jxxpJ0yCsbLn20MHXwg=;
        b=ErJJ9BTvuVWYef+h16S/dXkieBM7g0GtxGQBxsMokZvsZUosG1BcH8WbYLSJuupl1w
         iZhqcLNMgKTLHfmep9oy0NKdqozddGKHnG/2aCsNPlKUNNeafrParY5dktxiK9Tzuwo/
         S2mNm4/aRpnca2qosIOs/Se4iQN/W8iOEyYMTitrykvx8BEdsjMzGwvEC49a2KQAX1iO
         Zj50z8dAKm/S9QOHiBasXBR0NiiYyqfvWm3fMeLrWwlypVzjxDdYUCDgwM7T3ZjrXnnp
         x+9sWdZ068eX8EZvAzEowiFlMvwI2SeaFnJYWPIdAbas0MBp1gTz+WBnAHXYsQjpG4fe
         Vw4A==
X-Received: by 10.50.137.67 with SMTP id qg3mr32433igb.2.1400485519148;
        Mon, 19 May 2014 00:45:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.36.65 with SMTP id o1ls1632741igj.33.gmail; Mon, 19 May
 2014 00:45:18 -0700 (PDT)
X-Received: by 10.42.187.198 with SMTP id cx6mr13274537icb.8.1400485518314;
        Mon, 19 May 2014 00:45:18 -0700 (PDT)
Received: from mail-ig0-x229.google.com (mail-ig0-x229.google.com [2607:f8b0:4001:c05::229])
        by gmr-mx.google.com with ESMTPS id 6si559793igs.1.2014.05.19.00.45.18
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 May 2014 00:45:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::229 as permitted sender) client-ip=2607:f8b0:4001:c05::229;
Received: by mail-ig0-f169.google.com with SMTP id hl10so3915830igb.0
        for <msysgit@googlegroups.com>; Mon, 19 May 2014 00:45:18 -0700 (PDT)
X-Received: by 10.42.204.197 with SMTP id fn5mr51026icb.95.1400485518195; Mon,
 19 May 2014 00:45:18 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 19 May 2014 00:44:38 -0700 (PDT)
In-Reply-To: <5379AF29.4000508@viscovery.net>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::229
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249564>

On Mon, May 19, 2014 at 9:13 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 5/6/2014 2:17, schrieb Eric Wong:
>> Users may already store sensitive data such as imap.pass in
>> ..git/config; making the file world-readable when "git config"
>> is called to edit means their password would be compromised
>> on a shared system.
>>
>> [v2: updated for section renames, as noted by Junio]
>>
>> Signed-off-by: Eric Wong <normalperson@yhbt.net>
>> ---
>>  config.c               | 16 ++++++++++++++++
>>  t/t1300-repo-config.sh | 10 ++++++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/config.c b/config.c
>> index a30cb5c..c227aa8 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1636,6 +1636,13 @@ int git_config_set_multivar_in_file(const char *config_filename,
>>                       MAP_PRIVATE, in_fd, 0);
>>               close(in_fd);
>>
>> +             if (fchmod(fd, st.st_mode & 07777) < 0) {
>> +                     error("fchmod on %s failed: %s",
>> +                             lock->filename, strerror(errno));
>> +                     ret = CONFIG_NO_WRITE;
>> +                     goto out_free;
>> +             }
>
> This introduces a severe failure in the Windows port because we do not
> implement fchmod. Existing fchmod invocations do not check the return
> value, and they are only interested in removing the write bits, and we
> generally don't care a lot if files remain writable.
>
> I'm not proficient enough to add any ACL fiddling to fchmod that would be
> required by the above change, whose purpose is to be strict about
> permissions. Nor am I interested (who the heck is sharing a Windows box
> anyway? ;-)
>
> Therefore, here's just a work-around patch to keep things going on
> Windows. Any opinions from the Windows corner?
>

Since we use MSVCRT's chmod implementation directly which only checks
for S_IWRITE,and Get/SetFileAttributes to simply set or clear the
FILE_ATTRIBUTE_READONLY-flag, perhaps we could do the same except
using Get/SetFileInformationByHandle instead? That takes us in a
better direction, IMO. Adding full ACL support seems like a bigger
project.

If there's no objection, I'll sketch up a patch for that...

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
