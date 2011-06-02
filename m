From: Qingning Huo <qingninghuo@gmail.com>
Subject: Re: out of memory error with git push and pull
Date: Thu, 2 Jun 2011 23:13:14 +0100
Message-ID: <BANLkTimSoqbg6LgunovaKRefX78OH=xLMg@mail.gmail.com>
References: <BANLkTin3-XnVsVd1-CAiWDBzQG6m=a4Rvw@mail.gmail.com>
	<20110602044603.GB5081@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:13:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSG8n-0001IT-Jg
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 00:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab1FBWNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 18:13:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50883 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab1FBWNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 18:13:15 -0400
Received: by vws1 with SMTP id 1so990919vws.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LARzRqXLIltWZmurWL4aqVATJrmkEOlUwSepVFMqa+4=;
        b=CYsymbMP5HJ1BoAlCN8svhhbcnkwWxhD0EeTnoLC/4J+45l1d8BB6o/82mg7OGlGkW
         ZHXAL/RL0ZteNC5bOqcuX+xBkWQ/CdGeAUgZiOGBCFTzfKlrqHgEpPtVvrrkF6F5jnEq
         jCoxtqbpTygLvjnXlEUk8JowvE5RW+WM9Y9A4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jFhyakUOUEMRtp7dINjjAkEARr61JLvv3Hq1JxBIB+x5RWsZ9xxkiRiB0HZOrwVnso
         n9uMs3MjfESsFctyNl0gFWHII8H4vbNnk+Qx/r4JtZzV3mPhmEPaNNPEBuxUg8JQayJI
         AFQ3vsNgWONlv5f0tYyY2ENT9UxNchR3e59dk=
Received: by 10.52.38.104 with SMTP id f8mr1713570vdk.264.1307052794486; Thu,
 02 Jun 2011 15:13:14 -0700 (PDT)
Received: by 10.52.181.201 with HTTP; Thu, 2 Jun 2011 15:13:14 -0700 (PDT)
In-Reply-To: <20110602044603.GB5081@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174980>

Hi Joey,

On Thu, Jun 2, 2011 at 5:46 AM, Joey Hess <joey@kitenet.net> wrote:
> Qingning Huo wrote:
>> I tried to use git to manage my digital photos but encountered some
>> problems. The typical file sizes are hundreds of KB or a few MB. In
>> total, about 15GB data in about 10,000 files. My intention is to get
>> them into a git repository and cloned into a few computers. Probably I
>> will make some occasionally changes like editing and deleting. But I
>> think most of the files would stay at version one.
>
> I try not to mention git-annex too much here, but this is a perfect
> use-case for it. http://git-annex.branchable.com/
>
> Well, it would be more perfect if you had enough data in your repo that
> you didn't necessarily want to clone it all to every computer. Like so:
>
> # git annex status
> local annex size: 58 megabytes
> total annex keys: 38158
> total annex size: 6 terabytes
>
> :)

Thanks a lot for the pointer. I'd love to use git-annex if I can get
my hand to it.
I had a look of the web site and searched a bit on the web, but there does not
seem to be an easy way to install it on windows/cygwin.

I might try the bigFileThreshold setting first. And maybe git-bigfiles.

>
>> I wonder whether anyone has tried using git in a similar scenario. Is
>> git capable of handling this kind of data? And, are there any settings
>> and/or command line options that I should use? I had a quick look of
>> git help push (and pull/fetch) but cannot see anything obvious.
>
> There is a tunable you can use to improve things, see core.bigFileThreshold
>
> That originally came from this project.
> http://caca.zoy.org/wiki/git-bigfiles -- it may have some other
> improvements that have not landed in git, I'm not sure.
>
> --
> see shy jo
>

Thanks
Qingning
