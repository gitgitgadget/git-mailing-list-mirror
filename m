From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Merge, rebase and whitespace fixes
Date: Tue, 30 Jun 2009 11:18:53 +0200
Message-ID: <cb7bb73a0906300218k64e23bc1uf9e1ab72c2819e24@mail.gmail.com>
References: <cb7bb73a0906291218m3ba43109s35cad87efc5161a7@mail.gmail.com>
	 <4A493287.20106@dawes.za.net>
	 <cb7bb73a0906300037w6b61cae0jeecd2f97b1095b17@mail.gmail.com>
	 <4A49D4C5.8090700@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 11:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLZUW-0000z4-Sr
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 11:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbZF3JSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 05:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbZF3JSw
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 05:18:52 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62358 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZF3JSv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 05:18:51 -0400
Received: by fxm18 with SMTP id 18so1472358fxm.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ob2KPJFs625yMRvyHosHlQANnUZ0wz09fANiWJ/TK+g=;
        b=oEoerEn+c+2dOTB6BS2ILKBsev30SSoPAe0bZOEJtg+pxjMm40MoB9NYHPmroQrM05
         TAd0K7ODvS3k3a7CUf1j8XwutIXQEpx0LkyIUQ9olg3KcHAoKfaCEOByUnwF8iGJ8Afo
         Loefpdp+ArpuduQPfP1QMMJ5fr5INLx+w4oms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hgKC3pOeVkOxFXCWsy+BoWkORXrEuj9H8C4l9E/RTcXK+YYUIDTYkw2dJx5F4qIGHz
         ckw2JZ19tQVbtfXwECO3JPBPcOyIssPhwEsDDUFufRXhTkIZ4S/+SIKIyZemvqau34mj
         Xf2N9eDaRKruTPPG0PSjxYChfLeeEV/+CPe5I=
Received: by 10.204.62.135 with SMTP id x7mr8166912bkh.95.1246353533966; Tue, 
	30 Jun 2009 02:18:53 -0700 (PDT)
In-Reply-To: <4A49D4C5.8090700@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122502>

On Tue, Jun 30, 2009 at 11:03 AM, Rogan Dawes<lists@dawes.za.net> wrote:
>> I tried doing the whitespace cleanup on top of the last patch, but the
>> merge still conflicted.
>>
>> The interesting thing is that there's patchset from Robert Fitzsimons
>> that goes back to August 2005 (!) that does a couple of git apply
>> cleanups and in particular adds the --ignore-whitespace option that I
>> would need ...
>>
>> http://permalink.gmane.org/gmane.comp.version-control.git/7876
>>
>> but the patch apparently never made it into mainline ...
>>
>
> One thing I have done in the past when trying to merge two diverged
> trees was to format each commit in each tree to a common standard.
>
> One of the ways in which the trees had diverged was whitespace
> (non-meaningful) changes, so I used the Eclipse formatter as part of a
> "git filter-branch" script to make sure that I was ony looking at
> meaningful changes between the trees at each point. This significantly
> simplified the process.

I can also reply all the patches manually, of course, but the question
is: why should I be doing something manually when it can be done
programmatically?

BTW, I tried updating Robert's patch to the new code base, but it's
WAY too different ...

-- 
Giuseppe "Oblomov" Bilotta
