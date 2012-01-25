From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 1/5] t0061: Fix incorrect indentation
Date: Wed, 25 Jan 2012 08:08:17 +0100
Message-ID: <op.v8mor3m40aolir@keputer>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-2-git-send-email-fransklaver@gmail.com>
 <20120124224000.GE8222@burratino> <op.v8mmwftk0aolir@keputer>
 <7vd3a8466u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@gmail.com>, git@vger.kernel.org,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 08:08:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpwy3-0000A3-4Q
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 08:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab2AYHIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 02:08:22 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38021 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab2AYHIW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 02:08:22 -0500
Received: by eekc14 with SMTP id c14so2487154eek.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 23:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=TLybV1CNVN+WgOEbheVDT8A6PE+x/Ynj8ub3YvtvJNc=;
        b=PBObGMHHoWzsk0RKKVQ9p5uVvfTbOy02byIHrcy1X1h+HFtjxAZRt2vuz5HflsOO2t
         kZ29WZP9r4WS4HnxGtLc30mRS0HgzRzuU0lwD7UfOjhW0yyX9dA8a5qoZaS/JcVLycbf
         /vff0lf4gkNRzc8UYQSGvreJtmG4mP+Z5TRWI=
Received: by 10.14.16.98 with SMTP id g74mr5462669eeg.77.1327475300931;
        Tue, 24 Jan 2012 23:08:20 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id y12sm77755584eeb.11.2012.01.24.23.08.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 23:08:20 -0800 (PST)
In-Reply-To: <7vd3a8466u.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189100>

On Wed, 25 Jan 2012 08:00:57 +0100, Junio C Hamano <gitster@pobox.com>  
wrote:

> "Frans Klaver" <fransklaver@gmail.com> writes:
>
>> On Tue, 24 Jan 2012 23:40:00 +0100, Jonathan Nieder
>> <jrnieder@gmail.com> wrote:
>>
>>> Frans Klaver wrote:
>>>
>>>> +++ b/t/t0061-run-command.sh
>>>> @@ -8,8 +8,8 @@ test_description='Test run command'
>>>> . ./test-lib.sh
>>>>
>>>> cat >hello-script <<-EOF
>>>> -	#!$SHELL_PATH
>>>> -	cat hello-script
>>>> +#!$SHELL_PATH
>>>> +cat hello-script
>>>>  EOF
>>>
>>> Looks like a no-op --- the script already started with #! and no
>>> leading tab for me.  Does it behave differently on your machine?
>>
>> Hurr? I'm fairly sure the script ended up being indented for me. I'll
>> recheck.
>
> It could be that your shell is broken and does not understand the
> distinction between the "<<-EOF" vs "<<EOF". What system are you on?

Gentoo Linux, using bash. Would be hard to believe bash on plain old linux  
mucks this up, wouldn't it?


> If
> the problem is real and widespread, we might want to mention it in  
> INSTALL
> or Makefile, just like we label Solaris /bin/sh as unusable and advise
> people to use /usr/xpg[46]/bin variant.

I'll check and notify.
