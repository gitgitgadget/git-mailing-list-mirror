From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] git-grep: add --color to highlight matches
Date: Sat, 24 May 2008 16:20:39 +0700
Message-ID: <fcaeb9bf0805240220x78943f8ap67344a508531faa0@mail.gmail.com>
References: <20080524043118.GA23118@laptop>
	 <m3ve142jkc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 11:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzpwp-0003Vo-L7
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 11:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbYEXJUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 05:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbYEXJUl
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 05:20:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:1540 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbYEXJUl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 05:20:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so655491fgg.17
        for <git@vger.kernel.org>; Sat, 24 May 2008 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nDi6WOWYWDjWDNXSxiasBHmFsQgUmZMe2wHBVJrmgsk=;
        b=JJKmZdC858tI8Rn4P85aMu8eCJeDBPln7JVNJODTl/mWnqMdmVmsLRhsdIqVDF4LcXE5OwPOVwZAoZ/8LLgnbvQMXap8o9Hqajcv41Zc0ieOJZ2nMDHdDBQvoNaHHQfzuTNb5pPIu/hQvYpleTzJfb1Vu5KFkxphIDjA8zqMd8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SoiAfNk0xU2PICjB+aFfHyhfiGxTLZrgWamWo3csIeelqgBLgBWcuosletSR+UNLufZHym1Lz0Yg2jopqotH/FOTQPmukmQBQAzYxIcRm2rUbcad8/8dwTk7xvbEOxVks5SxkAeLXsmoriMkjagT+Dvq3uJUW4cgW5kIS4eRG4o=
Received: by 10.86.70.11 with SMTP id s11mr1330444fga.71.1211620839075;
        Sat, 24 May 2008 02:20:39 -0700 (PDT)
Received: by 10.86.62.13 with HTTP; Sat, 24 May 2008 02:20:39 -0700 (PDT)
In-Reply-To: <m3ve142jkc.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82806>

On Sat, May 24, 2008 at 3:28 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> +--color::
>> +     Show colored matches.
>> +
>
> Why not borrow from GNU grep manpage?
>
>   --colour[=WHEN], --color[=WHEN]
>      Surround  the  matching  string  with  the marker find in GREP_COLOR
>      environment variable. WHEN may be 'never', 'always', or 'auto'
>
> We probably would also want it configurable (via config variables),
> as `color.grep' I guess.

Yes. But this patch was really to scratch my itch and I felt good
after having it colorized so did not bother with configuration system.
I will probably make it a config var when I get tired of typing
--color too often ;)

> I think compatibility with grep (using GREP_COLOR) would be good idea,
> and easily implemented.

I had no idea that variable existed.

> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>



-- 
Duy
