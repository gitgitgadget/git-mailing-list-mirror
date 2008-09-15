From: "Pico Geyer" <picogeyer@gmail.com>
Subject: Re: Help using Git(-svn) for specific use case
Date: Tue, 16 Sep 2008 00:53:05 +0200
Message-ID: <aa2b76740809151553v70206abhe02d0859fdc62378@mail.gmail.com>
References: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com>
	 <37fcd2780809151255q278b1786ub4caec9022d7b082@mail.gmail.com>
	 <bd6139dc0809151359i357987c5vb2544b1b5c99802f@mail.gmail.com>
	 <48CED08F.5040602@drmicha.warpmail.net>
	 <20080915214740.GI28210@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:54:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfMxT-0006BX-JT
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 00:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYIOWxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 18:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755379AbYIOWxG
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 18:53:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:28225 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbYIOWxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 18:53:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2367632rvb.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 15:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4kDD2U0mWMGZxEQjVDkfyeJi5MC9G6UAtXsATEdGQdQ=;
        b=ggK2TjyB4pCfQOxvRkzBJfY35uIZSoUyC2GHTob8Cpj2GIYTG+i2MA/1dJ2p3P29uM
         ApFEukqHVx9uFGI1flkHJC7iz67ZsV3hgxbfU+HphqcXI1foCTfSxWMGzKej5h7b4ee5
         9I7PLmi2MFz/Im/FoBqJVZ1RI0/wLDD5VbySY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Dlsyim72MmV26O0BHw8IWZM+Nj7RpZncMv0iLNmDZmPXyOZ3VjctbQDY1k6o8C7zod
         BXtsw5eeIVF1V5XoNZ0ZxgfobFw3Ec5SZb9lufoRXSF463UH4nvhZmi3d7sj9JBg7x5r
         wzVtt9Sg6jb05FF/8xHWb6Yy0iEViLL+Kzr70=
Received: by 10.140.144.6 with SMTP id r6mr5171646rvd.293.1221519185053;
        Mon, 15 Sep 2008 15:53:05 -0700 (PDT)
Received: by 10.141.193.16 with HTTP; Mon, 15 Sep 2008 15:53:04 -0700 (PDT)
In-Reply-To: <20080915214740.GI28210@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95955>

Thanks guys for your replies and advice.

I'm going to be trying to configure such a setup tomorrow.
I'll probably have more questions :-)

Regards,
Pico Geyer

On Mon, Sep 15, 2008 at 11:47 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Mon, Sep 15, 2008 at 11:15:59PM +0200, Michael J Gruber wrote:
>> Sverre Rabbelier venit, vidit, dixit 15.09.2008 22:59:
>> >
>> > I thought this was fixed in a more recent version of git-svn? Didn't
>> > it even work both ways?
>>
>> Kind of. You can't fake a different author when committing to svn.
>
> This is not exactly correct as you can fake author if you have the right
> to change the svn:author property (or what is its name?), but by default
> this is not allowed to anyone, and git-svn does not support this method
> anyway.
>
>> But
>> "--add-author-from" makes dcommit embed the author in the svn commit
>> message (if there's no from nor sob), and "--use-log-author" makes fetch
>> look for that info and use it.
>
> Yes, it works. And it is very useful especially you are going eventually
> convert your SVN repository in Git (so all authorship information will
> be retain). Probably, I should have mentioned this possibility.
>
> Thanks,
> Dmitry
>
