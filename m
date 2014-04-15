From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] send-email: recognize absolute path on Windows
Date: Tue, 15 Apr 2014 12:42:15 +0200
Message-ID: <CABPQNSafmC-7zNJZJSZm598pF37_xUMUopgZ3c=ttL_wRDYsfQ@mail.gmail.com>
References: <1397551465-10968-1-git-send-email-kusmabite@gmail.com> <534D0ADB.7070702@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: msysgit+bncBDR53PPJ7YHRBL42WSNAKGQEIJY4A6I@googlegroups.com Tue Apr 15 12:42:57 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBL42WSNAKGQEIJY4A6I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f188.google.com ([209.85.128.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBL42WSNAKGQEIJY4A6I@googlegroups.com>)
	id 1Wa0pM-0000S4-W1
	for gcvm-msysgit@m.gmane.org; Tue, 15 Apr 2014 12:42:57 +0200
Received: by mail-ve0-f188.google.com with SMTP id db12sf2020941veb.15
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Apr 2014 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=ZARIxAlueTfm/N10qCgGy8s6cx9VHamblBI8SrVTi4A=;
        b=A0TSa0wbqYfTEx+6utbV3geqgX2UFAeLQe76xHseYZY/pLAItBRYLXwdmcznaIGVO/
         wd71JoA14a8o81kc1VXrYbZGEk26fC3T7ZBIir99xaA4phhRAvrcwGFC/7+RdnvwX2cX
         tZx0aNAXE+/bjATcPBaslL+D7mOroZuUvsSmUwm5fwsfT1/oLUdT1Y4H+7fv4h0kY/a7
         TGvwv0w821iVumHDYc9jZXKBEEtsEfencseebQ104fqcYLQT9MO1vOSjw8+zfEJUXy+7
         Evmu2QjZsHfGBdP9vHUrMnXaXD/f5mLE2mDU9nu6XlIiH6cT9vZ+cJXaUKnpkn3FfOko
         sBQA==
X-Received: by 10.182.24.1 with SMTP id q1mr7943obf.4.1397558576215;
        Tue, 15 Apr 2014 03:42:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.160.6 with SMTP id xg6ls23024obb.5.gmail; Tue, 15 Apr 2014
 03:42:55 -0700 (PDT)
X-Received: by 10.182.16.199 with SMTP id i7mr437482obd.42.1397558575556;
        Tue, 15 Apr 2014 03:42:55 -0700 (PDT)
Received: from mail-vc0-x22e.google.com (mail-vc0-x22e.google.com [2607:f8b0:400c:c03::22e])
        by gmr-mx.google.com with ESMTPS id qa17si4693207vdb.1.2014.04.15.03.42.55
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Apr 2014 03:42:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:400c:c03::22e as permitted sender) client-ip=2607:f8b0:400c:c03::22e;
Received: by mail-vc0-x22e.google.com with SMTP id ld13so8695790vcb.19
        for <msysgit@googlegroups.com>; Tue, 15 Apr 2014 03:42:55 -0700 (PDT)
X-Received: by 10.58.181.170 with SMTP id dx10mr723695vec.25.1397558575463;
 Tue, 15 Apr 2014 03:42:55 -0700 (PDT)
Received: by 10.52.162.103 with HTTP; Tue, 15 Apr 2014 03:42:15 -0700 (PDT)
In-Reply-To: <534D0ADB.7070702@viscovery.net>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:400c:c03::22e
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246284>

On Tue, Apr 15, 2014 at 12:32 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 4/15/2014 10:44, schrieb Erik Faye-Lund:
>> From: Erik Faye-Lund <kusmabite@googlemail.com>
>>
>> On Windows, absolute paths might start with a DOS drive prefix,
>> which this check fails to recognize.
>>
>> Unfortunately, we cannot simply use the file_name_is_absolute
>> helper in File::Spec::Functions, because Git for Windows has an
>> MSYS-based Perl, where this helper doesn't grok DOS
>> drive-prefixes.
>>
>> So let's manually check for these in that case, and fall back to
>> the File::Spec-helper on other platforms (e.g Win32 with native
>> Perl)
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> Here's a patch that we've been running with a variation of in
>> Git for Windows for a while. That version wasn't quite palatable,
>> as it recognized DOS drive-prefixes on all platforms.
>
> Did you consider patching msysgit's lib/perl5/5.8.8/File/Spec.pm by
> inserting a line "msys => 'Win32'," near the top of the file; it is the
> hash table that decides which path "style" is selected depending on $^O.
> Then File::Spec->file_name_is_absolute($path) could be used without a wrapper.

I did not, but that works, and is IMO much nicer. Thanks for the idea!

>>
>>  git-send-email.perl | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index fdb0029..c4d85a7 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1113,6 +1113,18 @@ sub ssl_verify_params {
>>       }
>>  }
>>
>> +sub file_name_is_absolute {
>> +     my ($path) = @_;
>> +
>> +     # msys does not grok DOS drive-prefixes
>> +     if ($^O eq 'msys') {
>> +             return ($path =~ m#^/# || $path =~ m#[a-zA-Z]\:#)
>> +     }
>> +
>> +     require File::Spec::Functions;
>> +     return File::Spec::Functions::file_name_is_absolute($path);
>> +}
>> +
>>  # Returns 1 if the message was sent, and 0 otherwise.
>>  # In actuality, the whole program dies when there
>>  # is an error sending a message.
>> @@ -1197,7 +1209,7 @@ X-Mailer: git-send-email $gitversion
>>
>>       if ($dry_run) {
>>               # We don't want to send the email.
>> -     } elsif ($smtp_server =~ m#^/#) {
>> +     } elsif (file_name_is_absolute($smtp_server)) {
>>               my $pid = open my $sm, '|-';
>>               defined $pid or die $!;
>>               if (!$pid) {
>>
>
> There's another instance in the non-$quiet code path around line 1275 that
> needs the same treatment.

Good catch, thanks!

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
