From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Fri, 17 Apr 2015 07:40:27 +0530
Message-ID: <8B5A4F0C-B550-4875-AE4C-3C38CDB25CDA@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117174-4968-1-git-send-email-karthik.188@gmail.com> <xmqqtwwhjg8b.fsf@gitster.dls.corp.google.com> <xmqqiocxjeqn.fsf@gitster.dls.corp.google.com> <552F6429.9050304@gmail.com> <xmqq618wjiwn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 04:10:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yivjw-0003pN-G2
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 04:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbbDQCKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 22:10:41 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34865 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbbDQCKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 22:10:39 -0400
Received: by pabtp1 with SMTP id tp1so109219062pab.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 19:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=iaFe1Oih0Unu858rFydSfzREPPcSN2qkfkOquZfBIpc=;
        b=HSFQeTl4Fjf3njHDa4mQ8jfMnEq331QSEZxpP+tY8miPbbcI1RBCv75TeIn23CpSPG
         7QtdAN27QoGL8qJoGSNIWLRHEW3PBytgib8s3t0GHeIWS4ayN++dZyY3HwiO944SslxU
         VO+ALrLyl6346HQJG3hihvqs2+5xaJIuUWg0QuyU7Ias0ly5zdIzC0E5McXL6+7757w3
         10hrzrZLhe79Q+Jy3LmSMWroBfQxCAs3hPfYw7L7jSODk0uTPypqQvozZ8UFcxSYp5Ol
         GVQbGxSUgIpFSIQtnzuPpLWoz/FbbkbwPY5YF/4gMDDkmWC9+P6/iEAce1tuoQPqo0UL
         EiMw==
X-Received: by 10.70.50.199 with SMTP id e7mr1263369pdo.124.1429236639151;
        Thu, 16 Apr 2015 19:10:39 -0700 (PDT)
Received: from [100.104.160.27] ([27.97.199.91])
        by mx.google.com with ESMTPSA id r7sm8411484pdm.16.2015.04.16.19.10.36
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 16 Apr 2015 19:10:38 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqq618wjiwn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267346>



On April 16, 2015 7:05:04 PM GMT+05:30, Junio C Hamano <gitster@pobox.com> wrote:
>karthik nayak <karthik.188@gmail.com> writes:
>
>> On 04/16/2015 02:22 AM, Junio C Hamano wrote:
>>
>>> This is a tangent, but while we are in the vicinity, we may want to
>>> rethink the help message we attach to the '-e' option.  Technically
>>> the current message is _not_ wrong per-se, but it misses the point.
>>> The primary thing the option does is to check the (e)xistence of the
>>> named object, and the fact that it does so silently is merely a
>>> detail of the operation.  The current help text omits the more
>>> important part of what the option is.
>>
>> Would you rather check '-e' and go on to check '-p' or do you merely
>> just want a different message.
>
>I meant just a different message.  The point of -e is to see if the
>thing exists.  It is good to mention _how_ the result is reported
>back to the user (i.e. via the exit code, not via an output to the
>standard output "exists" vs "missing", for example), but that is
>secondary.  Telling how it reports is meaningless without telling
>what it reports in the first place.

I see what you mean. But I think it's beyond the scope of this patch series. If no one does, I'll work on it

>
>> ... when a user is giving the '-e' option he just expects a silent
>> output if the object exists, hence we rather have the option '-e'
>> behave as a mutually exclusive option...
>
>Yes, and that is in line with the switch to OPT_CMDMODE.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
