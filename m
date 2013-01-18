From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] git-completion.bash: replace zsh notation that breaks
 bash 3.X
Date: Fri, 18 Jan 2013 11:11:31 -0800
Message-ID: <CA+sFfMd7hurR=4n1r9RLtMYoxnM_LFH5j1McJc8+8_JumqviLg@mail.gmail.com>
References: <1358505065-16913-1-git-send-email-drafnel@gmail.com>
	<m2obgmjzz0.fsf@igel.home>
	<CA+sFfMd6FLchoOcUpNZ3AxTLNp3qe=VjijRid4sWf-A3_w88qw@mail.gmail.com>
	<7vr4liqpg4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, felipe.contreras@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:11:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwHM1-0004ql-6X
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 20:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab3ARTLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 14:11:34 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40558 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab3ARTLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 14:11:32 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so3929708vby.19
        for <git@vger.kernel.org>; Fri, 18 Jan 2013 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=w5ohmdXQxtxy2P3t+0JLLsOHdNXWoSccePEdAGBVcoo=;
        b=viimY0bSQttesw9r1OXvK/GzcWa17QIHCTbADiOXgXxx+4vA7RAwGa2Us9CnkATekx
         ZxsfMYWvWFd3yPViOS+1m0UXqlRnW58AKUdwKKhp5gRp7EUwxchKVy0Dcd0xlNC2ocDZ
         FqettH/X5gSdHyuMl16MQo2aCZxqhrRN6srYPXXjbuvnmlU8heusH7J5fmFq2P6UqwtT
         p2sFeJP7LBHftI4WDfGkuREQptT2NJTH7TBvaviXTsWsFbJDKJnpAqAbDj3jLSeDCT+N
         6pWSbiesFD2Qgt+NK5wnMRp303HF0qPfWqmqD5PGRIZh2HSsMrcLiGGxaeEoSGV+81Kj
         ZDfw==
X-Received: by 10.220.106.133 with SMTP id x5mr10702967vco.61.1358536291815;
 Fri, 18 Jan 2013 11:11:31 -0800 (PST)
Received: by 10.58.216.1 with HTTP; Fri, 18 Jan 2013 11:11:31 -0800 (PST)
In-Reply-To: <7vr4liqpg4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213929>

On Fri, Jan 18, 2013 at 11:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> On Fri, Jan 18, 2013 at 7:02 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>>> Brandon Casey <drafnel@gmail.com> writes:
>>>
>>>> +                             array[$(($#array+1))]="$c"
>>>
>>> You don't need $(( )) since the array index is already evaluated as an
>>> arithmethic expression.
>>
>> Ah, I didn't know that.  Thanks.
>>
>> I think Junio will probably fix this up if he thinks it's worth it,
>> but I can resubmit if necessary.
>
> Please; I do not have mental bandwidth to keep track of contrib/
> material myself.

No problem.

-Brandon
