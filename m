From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH bc/connect-plink] t5601-clone: remove broken and
 pointless check for plink.exe
Date: Tue, 11 Aug 2015 15:53:31 -0700
Message-ID: <xmqq7fp1o2s4.fsf@gitster.dls.corp.google.com>
References: <55CA6066.5070500@kdbg.org>
	<CAPig+cS2CPFPBK+4W56dRVUas8UDpV1FZfMmOqxm6mprW+O_mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,  Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: msysgit+bncBCG77UMM3EJRB3XZVGXAKGQE5NTBMMY@googlegroups.com Wed Aug 12 00:53:35 2015
Return-path: <msysgit+bncBCG77UMM3EJRB3XZVGXAKGQE5NTBMMY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f63.google.com ([209.85.220.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB3XZVGXAKGQE5NTBMMY@googlegroups.com>)
	id 1ZPIQJ-0003cP-9Z
	for gcvm-msysgit@m.gmane.org; Wed, 12 Aug 2015 00:53:35 +0200
Received: by pacum4 with SMTP id um4sf24947pac.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=poBAawMd6JeP+vZJMiJFiKtINF6XGy8/GlTvpBILn44=;
        b=cczi9bxihUcN9maUSRi5kv8cvup74MaqUJzRffizhVXyY9j3sof/EZ2pETfLk5E8MD
         gZ/jUndQui16hPc/qHGWQB4ydSi9SN1SBHl+DC+SnPKZ9HUZuqe6x87FJUiqntd+AujD
         R0v9mYsIQT8xVag7yO4frAhuSHqCRLFSa/TXGa8X/8agbe/JNAJ/ICy7rM/pvN9E127F
         grUmq+PTVvZtmckMvUOIpRKCvpUPpz91bNmtYR+Vz5CvHXUgXme9HBPAHZwNClo4i64c
         jktg25KD16MEBrazQy5LEmY2DrXqBzVxZm2ghGUMZfCZwLcZVkEirIYNPVYoTJqcbrX+
         pqBw==
X-Received: by 10.50.103.73 with SMTP id fu9mr284686igb.17.1439333614492;
        Tue, 11 Aug 2015 15:53:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.50.240 with SMTP id f16ls17293igo.31.gmail; Tue, 11 Aug
 2015 15:53:33 -0700 (PDT)
X-Received: by 10.70.43.163 with SMTP id x3mr16963166pdl.3.1439333613885;
        Tue, 11 Aug 2015 15:53:33 -0700 (PDT)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com. [2607:f8b0:400e:c03::230])
        by gmr-mx.google.com with ESMTPS id eq2si371375pbb.2.2015.08.11.15.53.33
        for <msysgit@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 15:53:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c03::230 as permitted sender) client-ip=2607:f8b0:400e:c03::230;
Received: by mail-pa0-x230.google.com with SMTP id gr6so52064pac.2
        for <msysgit@googlegroups.com>; Tue, 11 Aug 2015 15:53:33 -0700 (PDT)
X-Received: by 10.68.241.6 with SMTP id we6mr61532944pbc.127.1439333613645;
        Tue, 11 Aug 2015 15:53:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id ob4sm3939793pbb.40.2015.08.11.15.53.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 15:53:32 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <CAPig+cS2CPFPBK+4W56dRVUas8UDpV1FZfMmOqxm6mprW+O_mw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 11 Aug 2015 18:50:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c03::230
 as permitted sender) smtp.mailfrom=jch2355@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275740>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Aug 11, 2015 at 4:51 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Invoking plink requires special treatment, and we have support and even
>> test cases for the commands 'plink' and 'tortoiseplink'. We also support
>> .exe variants for these two and there is a test for 'plink.exe'.
>>
>> On Windows, however, where support for plink.exe would be relevant, the
>> test case fails because it is not possible to execute a file with a .exe
>> extension that is actually not a binary executable---it is a shell
>> script in our test. We have to disable the test case on Windows.
>>
>> Considering, that 'plink.exe' is irrelevant on non-Windows, let's just
>> remove the test and assume that the code "just works".
>
> putty and plink are used on Unix as well. A quick check of Mac OS X,
> Linux, and FreeBSD reveals that package managers on each platform have
> putty and plink packages available.

... so we should do the same !MINGW prereq instead?

>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  t/t5601-clone.sh | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
>> index 9b34f3c..df69bf6 100755
>> --- a/t/t5601-clone.sh
>> +++ b/t/t5601-clone.sh
>> @@ -353,12 +353,6 @@ test_expect_success 'plink is treated specially (as putty)' '
>>         expect_ssh "-P 123" myhost src
>>  '
>>
>> -test_expect_success 'plink.exe is treated specially (as putty)' '
>> -       copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
>> -       git clone "[myhost:123]:src" ssh-bracket-clone-plink-1 &&
>> -       expect_ssh "-P 123" myhost src
>> -'
>> -
>>  test_expect_success 'tortoiseplink is like putty, with extra arguments' '
>>         copy_ssh_wrapper_as "$TRASH_DIRECTORY/tortoiseplink" &&
>>         git clone "[myhost:123]:src" ssh-bracket-clone-plink-2 &&
>> --
>> 2.3.2.245.gb5bf9d3
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

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
