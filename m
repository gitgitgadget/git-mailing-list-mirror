From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] t4210: skip command-line encoding tests on mingw
Date: Mon, 21 Jul 2014 09:59:21 -0700
Message-ID: <xmqqvbqqk5qu.fsf@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-5-git-send-email-kasal@ucw.cz>
	<CABPQNSaiogqGryK8YOzQXs_z_syvXMBqvOpvGfMNdbLkNzRq_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  Karsten Blees <karsten.blees@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRB4UNWWPAKGQEAQ7CSZI@googlegroups.com Mon Jul 21 18:59:34 2014
Return-path: <msysgit+bncBCG77UMM3EJRB4UNWWPAKGQEAQ7CSZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f59.google.com ([209.85.220.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB4UNWWPAKGQEAQ7CSZI@googlegroups.com>)
	id 1X9Gw1-0003nQ-PK
	for gcvm-msysgit@m.gmane.org; Mon, 21 Jul 2014 18:59:34 +0200
Received: by mail-pa0-f59.google.com with SMTP id eu11sf2184865pac.14
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jul 2014 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=RgG09k8rJy1dtbgcxX/1741NsJOssuXfOOZ2khA+yvE=;
        b=I/rIrJGjl0lcXnp39VQdDioYvvlNNvUm1PG3n6dSWqKAvInzN6L6QlpsUbHKowsE73
         nU6gwYBkZzH/aRXm++BdK4iNVGIeXiyg2x6koos8Qj6jKLA5U3STsLddJknT1IZqE3ZR
         RKNTuqN/S6UIMZjvWeYeDAoE4/KpO2r+5WrmGHpTThqpQe/BifsgpWNyY5oo2t7oX9tu
         CEAZqwm6hGs3Ztizt2WERWg0qunnd8AfGu6jWRMCVHPiM2EX+lRd+UHUE2Na5ZqpJMBI
         WBQkLOeWcPY9Cbjx2XucRJJWD0ey71Sz1aAawFbW8xGzq4TvdkOVvQTWi1eit4VH5sAj
         us0w==
X-Received: by 10.182.29.38 with SMTP id g6mr54095obh.12.1405961971058;
        Mon, 21 Jul 2014 09:59:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.227.133 with SMTP id sa5ls1242183obc.89.gmail; Mon, 21 Jul
 2014 09:59:29 -0700 (PDT)
X-Received: by 10.182.105.230 with SMTP id gp6mr14116614obb.18.1405961969788;
        Mon, 21 Jul 2014 09:59:29 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id l23si1060427yhg.1.2014.07.21.09.59.29
        for <msysgit@googlegroups.com>;
        Mon, 21 Jul 2014 09:59:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B4CD2A285;
	Mon, 21 Jul 2014 12:59:29 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F71F2A282;
	Mon, 21 Jul 2014 12:59:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7238A2A263;
	Mon, 21 Jul 2014 12:59:23 -0400 (EDT)
In-Reply-To: <CABPQNSaiogqGryK8YOzQXs_z_syvXMBqvOpvGfMNdbLkNzRq_w@mail.gmail.com>
	(Erik Faye-Lund's message of "Fri, 18 Jul 2014 11:52:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5D8DBBF6-10F8-11E4-93A5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253976>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Thu, Jul 17, 2014 at 5:37 PM, Stepan Kasal <kasal@ucw.cz> wrote:
>> From: Pat Thoyts <patthoyts@users.sourceforge.net>
>>
>> On Windows the application command line is provided as unicode and in
>> mingw-git we convert that to utf-8. So these tests that require a iso-8859-1
>> input are being subverted by the encoding transformations we perform and
>> should be skipped.
>> ...
>> -test_expect_success 'log --grep searches in log output encoding (latin1)' '
>> +test_expect_success NOT_MINGW 'log --grep searches in log output encoding (latin1)' '
>>         cat >expect <<-\EOF &&
>>         latin1
>>         utf8
>> @@ -43,7 +43,7 @@ test_expect_success 'log --grep searches in log output encoding (latin1)' '
>>         test_cmp expect actual
>>  '
>>
>> -test_expect_success 'log --grep does not find non-reencoded values (utf8)' '
>> +test_expect_success NOT_MINGW 'log --grep does not find non-reencoded values (utf8)' '
>
> Perhaps these checks would be more readable a few years in the future,
> if we make a separate capability along the lines of
> NON_UNICODE_LOCALE?

I do agree that having "unicode" and possibly also "locale" and
dropping "mingw" from the prerequisite makes sense, especially in
the longer term.  Please make it so _after_ the dust settles.

I however suspect that NON_UNICODE_LOCALE does not read quite well;
isn't the trouble that mingw allows nothing but unicode strings on
the command line (there is no trouble for non unicode strings that
appear as payload)?

Oh by the way, can somebody remind me why we spell these as
NOT_MINGW,  instead of !MINGW?




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
