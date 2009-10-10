From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Merging non-git releases of a project
Date: Sat, 10 Oct 2009 09:58:01 +0100
Message-ID: <26ae428a0910100158s5233841byd303377aa20eb45f@mail.gmail.com>
References: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com>
	 <32541b130910091427i7c8a2426hb69a9914aabde8bc@mail.gmail.com>
	 <26ae428a0910091433v2c959a70g9bfc6c54382f370d@mail.gmail.com>
	 <32541b130910091543x19b3b46an109f90be5c5bfaa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 10:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwXmx-0008Iy-Ke
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 10:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914AbZJJI6j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Oct 2009 04:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbZJJI6j
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 04:58:39 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:56900 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901AbZJJI6i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Oct 2009 04:58:38 -0400
Received: by ewy4 with SMTP id 4so1247690ewy.37
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=IaFMWmmm+6NBNud3ICU6kuT/nvWV7TR+Gp8OQBjRsbc=;
        b=aOU2wHqIqRtRMzvM06Tvs1DHVBLuihQy2ScK7hwmXISAq7/D8XZPGZTcj8zUhK+EK0
         0myJ73VoRgmBV8t1prrR/w9zBW1LRaATDwP+FrEq+n0quCVxNafDjYzOshhOzUeSfU0X
         CR7m1ssVay+LPGiy7beJAQGDjdiztkJQJzjtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ZtgOuex7eDtMhJtXkTiY1+bASPeh4nnINgpQa6kIcC+RHBQCS5y2bUdSYeexbZU70B
         Vhk53BaU9YD38ktcfBeJgnJw1aiYkPBxZHQiJUNwAmtVxbqDb2ghufANFgDhSchsMcHH
         /Llr8meiq3MJTkRFN5L6aOtRB99CRw3YrUSxI=
Received: by 10.216.86.17 with SMTP id v17mr1186542wee.192.1255165081668; Sat, 
	10 Oct 2009 01:58:01 -0700 (PDT)
In-Reply-To: <32541b130910091543x19b3b46an109f90be5c5bfaa2@mail.gmail.com>
X-Google-Sender-Auth: 5af73a3f1600ebd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129873>

2009/10/9 Avery Pennarun <apenwarr@gmail.com>:
> On Fri, Oct 9, 2009 at 5:33 PM, Howard Miller
> <howard@e-learndesign.co.uk> wrote:
>> I'm missing the point here though. Where/when =A0do I actually add t=
he
>> new pristine code? If I checkout, as you suggest, my initial commit =
I
>> just have (say) v1.0 of the vendor's code. I can't just copy (say)
>> version 1.2 on top as the files probably won't match one-one.
>>
>> Sorry - I'm probably completely failing to understand.
>
> Try this:
>
> =A0 cd mygitproject
> =A0 git rm -rf .
> =A0 cp -a /tmp/wherever/vendor-1.2/. .
> =A0 git add .
> =A0 git commit
>
> Don't worry, git won't double-store files that are identical between
> the old 1.0 and new 1.2 versions.
>
> Avery
>

Adding Unix ignorance to git ignorance... doesn't that delete the .git
directory too?

I don't have cp -a (on a mac) but, IIRC, that's just -rp or somesuch?

But I see, basic idea is to ditch the files, replace them with the new
vendor release a commit. I did think of that but it seemed too simple
:-)

Cheers.
