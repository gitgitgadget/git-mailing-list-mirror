From: Jeenu V <jeenuv@gmail.com>
Subject: Re: Git reset -p on working tree
Date: Tue, 23 Nov 2010 15:56:08 +0530
Message-ID: <AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com> <AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 11:27:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKq5U-00073d-T8
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 11:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab0KWK0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 05:26:42 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63929 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab0KWK0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 05:26:41 -0500
Received: by wyb28 with SMTP id 28so8113671wyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 02:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=IxmTYgo4C5TmpoZB5qsN0zwSVGbYfBpVrVm6R1h0BQ0=;
        b=gnnmAJuBMJBsNsIW1ChlNhJyvy6fKZUT5bb3W6mh0BuQ26uIfJLewLCDiaLVNXErFC
         sn1lGBYo7vLXHwfOojykSWvpY8B2FhAv5J+m6PibWcL79jWKxMSUxpT3EzWY8Njv3vq+
         e+y4QQyRS5rc33cdcEmjqY9Nvg/EeAIrC4Y7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=msWOil3dPTVpWrKv1gsfIAebky87Apcb2Ym4insfcdL8jGDUnKWIZOIT8IPvwhjDvx
         UmL0kLSx/b6cxUkLcMU6X54vDW/5IJcnEgZLvR6dficSko79YpIFzhEkwjVaUX73emqm
         k7rNhEVyyQzXJdNrPQFy7bWgyvL/Hqm8tWY54=
Received: by 10.216.21.9 with SMTP id q9mr861339weq.3.1290507998931; Tue, 23
 Nov 2010 02:26:38 -0800 (PST)
Received: by 10.216.10.209 with HTTP; Tue, 23 Nov 2010 02:26:08 -0800 (PST)
In-Reply-To: <AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161939>

On Tue, Nov 23, 2010 at 2:50 PM, knittl <knittl89@googlemail.com> wrote:
> On Tue, Nov 23, 2010 at 10:11 AM, Jeenu V <jeenuv@gmail.com> wrote:
>> Often I find it useful to selectively undo the modifications that I
>> did to my working tree. The -p option to 'reset' that selectively
>> resets changes back to a given commit. Unfortunately the option
>> reports itself to be incompatible with --{hard,soft,mixed} and thus
>> can't be applied to working tree.
>>
>> Right now I do this with vimdiff, by applying 'git diff' in reverse.
>> Wish reset supports -p on working tree operations as well because the
>> -p framework (of add, and reset) feels good to use.
>
>
> there's `git checkout -p` to selectively remove changes from your working tree.
> (also `git stash -p` to selectively stash changes temporarily)

Surprised to know that checkout and stash supports it! Thanks a lot
for pointing out.

-- 
Jeenu
