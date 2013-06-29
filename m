From: David Aguilar <davvid@gmail.com>
Subject: Re: How to update git on Mac OS X Mountain Lion 10.8.4
Date: Fri, 28 Jun 2013 18:59:58 -0700
Message-ID: <CAJDDKr5Spv0=e7vbjYETKn8f6VnfSJ=rGLZoqDrCmE1Rqy6YrA@mail.gmail.com>
References: <CAN_-5Z94-OV7rHYf+mUuf_xanxu0+odwovv0mpB4GRHVsjccDw@mail.gmail.com>
	<51CDFADD.8000707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olivier de Broqueville <olivier.debroqueville@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Melton Low (devl)" <softw.devl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 29 04:00:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UskSl-0005EX-GG
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 04:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab3F2B77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 21:59:59 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:33356 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab3F2B76 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 21:59:58 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so2861078pbc.30
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 18:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sVkyoNWDdjfqbc/AnPgR8bcWN2VudnjkNy08Vv+Cpo0=;
        b=f8mDU0QpAE5b4phkvcaxTLooFGH9QNmuxgO4bUgVrMm4IpG6sEdjBM/39G7gKmvJKi
         573njFgAdS93NICEH6dD8mC1lmYeHleRFXRVXJd9+C556nsyaBEZrbIlrKBWji6PLHZH
         lzU6wwvFEoOkeL4N6j2UDVZjIuhZMWyGWmp+nby7i5B5ocOImi+InH/Ot7dKyYBACHvn
         1Sfg4hP0ZK0wJ8xWp4HuHy2k85CqsYxlA28Y5B/R69LmyQ1v+eAKftJ0swdFhavF6AV4
         DmIM0dbtM+w9P7vqLATmWXrBpDZxWgN+eGRn2ofeZG32JQSy22rmhw12N3RhT8IUd/Ho
         +YZA==
X-Received: by 10.68.222.135 with SMTP id qm7mr13928109pbc.38.1372471198081;
 Fri, 28 Jun 2013 18:59:58 -0700 (PDT)
Received: by 10.70.21.168 with HTTP; Fri, 28 Jun 2013 18:59:58 -0700 (PDT)
In-Reply-To: <51CDFADD.8000707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229249>

On Fri, Jun 28, 2013 at 2:06 PM, Melton Low (devl) <softw.devl@gmail.com> wrote:
> Hi,
>
> Did you do a "sudo make install" as the last step?
>
> As a general rule of thumb on OS X, don't update or otherwise do anything to
> stuff installed by Apple.  You have to install the newer version from the
> Git repository to a different directory, eg /usr/local or /usr/local/git .

It's never any fun doing this stuff yourself.

If you're new to this stuff then I would highly recommend using homebrew:

http://mxcl.github.io/homebrew/

Once you've installed it you can say, "brew install git".

> ./configure --prefix=/usr/local
> or
> ./configure --prefix=/usr/local/git
>
> make all
> sudo make install
>
> Then change your login profile, from the terminal, to reflect the new bin
> location, eg /usr/local/bin or /usr/local/git/bin .
>
> Hope this help.
>
> Mel
>
>
> Olivier de Broqueville wrote:
>>
>> Hello,
>>
>> I've learnt that Xcode installs git by default on the Mac. My current
>> version of git is 1.7.12.4 and it's located in /usr/bin/git.
>>
>> I wanted to update git to the latest stable version available:
>> 1.8.3.1. I proceeded with the instructions on:
>> http://git-scm.com/downloads and typed:
>>
>> git clone https://github.com/git/git.git
>>
>> (rather than using the .dmg file because I don't want to install a new
>> version of git in addition to the existing one used by Xcode.
>> Furthermore, I have no idea where the new version would end up being
>> installed and I've read that users have had trouble doing this!)
>>
>> This rendered the following results:
>> Oliviers-iMac:~ odebroqueville$ git clone https://github.com/git/git.git
>> Cloning into 'git'...
>> remote: Counting objects: 157697, done.
>> remote: Compressing objects: 100% (53116/53116), done.
>> remote: Total 157697 (delta 114700), reused 143715 (delta 102625)
>> Receiving objects: 100% (157697/157697), 39.56 MiB | 2.01 MiB/s, done.
>> Resolving deltas: 100% (114700/114700), done.
>> Oliviers-iMac:~ odebroqueville$ which git
>> /usr/bin/git
>> Oliviers-iMac:~ odebroqueville$ git --version
>> git version 1.7.12.4 (Apple Git-37)
>>
>> As you can see, nothing seems to have changed!
>>
>> Would you have any explanations?
>>
>> Thank you in advance for your help.
>> Best regards,
>> Olivier de Broqueville.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
David
