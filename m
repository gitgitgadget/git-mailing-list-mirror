From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Thu, 31 Mar 2011 20:35:47 +0700
Message-ID: <AANLkTi=S9WUWHE8DZvQ2sxMLAJigi1wm3iU_PL5h4Mzd@mail.gmail.com>
References: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net>
 <4D94322A.8030409@drmicha.warpmail.net> <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net>
 <AANLkTik4wy3B1S=7_2opLdAVy5LBq55VsfZnkj0=QskC@mail.gmail.com> <4D948105.3050009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 15:36:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5I2x-0003Pd-AD
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 15:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502Ab1CaNgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 09:36:18 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:54691 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab1CaNgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 09:36:17 -0400
Received: by pxi2 with SMTP id 2so533577pxi.10
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Hu0UdHf6MVhZSUU23Xov+7V44nznNqvTLVUfPcWbXxw=;
        b=toskupTIKN3U+IblwiB30ccv6Sc6yIZonJ/h8SdkurPW9ACw16+Uau+055bCZ/BOVo
         b0D3a/OW7hYQzm+x00Gfxs1AbnOlS1HJ6Nk/3NOkwDmNyCUMpZQSNYomWTL6A8kNGZtk
         +78lxUpuUaY+Dr1JQxuc24sFDxwrkbpPx5aFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=A0dtF6KxvjGGpAw0cs+YoBsEFlw4HxnjAj3baHjh6NTP2XWwh2+Dtg7K6/Q7DvVwHd
         3msl8LCgBlr8oU86NXAlInRcfsQXeQWO5og8sd2bxbjlKGj+vA4EpTULwfcHqfoif83y
         DRCttElV3xNmRkXjrRY5tBAsIyWbfFYOwsy8o=
Received: by 10.142.142.4 with SMTP id p4mr2161613wfd.43.1301578577044; Thu,
 31 Mar 2011 06:36:17 -0700 (PDT)
Received: by 10.68.42.234 with HTTP; Thu, 31 Mar 2011 06:35:47 -0700 (PDT)
In-Reply-To: <4D948105.3050009@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170489>

On Thu, Mar 31, 2011 at 8:26 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>> Tests please?
>
> Heck, we don't have any to begin with, and this is marked RFC. Given our
> usual reluctance to change even undocumented behavior I'm not going to
> bother with tests for an RFC.

Ugh.. I missed the "RFC" part on the subject. Sorry.

>>> As an intended side effect, users mistaking "git show commit -- path"
>>> for "git show commit:path" are automatically reminded that they asked
>>> git to show a commit, not a blob.
>>
>> Nor a tree. I don't really see how "git show commit:path" and "git how
>> commit -- path" are relevant for it to be mentioned here.
>
> "git show commit:path" is relevant because that is what the OP was
> trying to do, and "git show commit:path" is relevant because that is
> what the OP tried and confused him because there was no output at all.
> Not to mention that this is the command this patch is about.

Thanks. I see I also missed the original thread somewhere. Someone
needs a sleep, me thinks :)
-- 
Duy
