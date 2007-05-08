From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] remove unnecessary loop
Date: Tue, 8 May 2007 14:38:01 +0200
Message-ID: <81b0412b0705080538r2691d232r9c073bd73934b1d8@mail.gmail.com>
References: <463FEC07.8080605@gmail.com> <4640015F.1080407@gmail.com>
	 <81b0412b0705080208x3713cbc1y3c870383b586c877@mail.gmail.com>
	 <20070508101317.GC9007@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Liu Yubao" <yubao.liu@gmail.com>, git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 08 14:38:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlOxE-0003vQ-UY
	for gcvg-git@gmane.org; Tue, 08 May 2007 14:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934174AbXEHMiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 08:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934206AbXEHMiE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 08:38:04 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:18472 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934174AbXEHMiC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 08:38:02 -0400
Received: by an-out-0708.google.com with SMTP id d18so227261and
        for <git@vger.kernel.org>; Tue, 08 May 2007 05:38:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FrnKtnr5To/5HOTFMKPVaK4rHG06O5i4cumT7zH/DyBPJXrySCahpPJDWkqUJcxanLn5BuBfbsbYWr/RcZysd4Lbhr4rEOitEf5EYeB1kYp+HffOIqIQ4ve2qNfGPGkAsCHcbD5O/nR9eEq5/VsXL9PjIPyjZzsJ9RWFnzRxPYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aSGvKs3e3bH2yop2ncAkt4SZOgrlppM4JWnH1yGFlVvJUA/ArR3X8dAXT7/ZYjOpGMDbGGjSMUgqUyJnZpw68wW/OzpcYY5FB9NUZ+X4+nAKId4XjHl+ybz2BFsLwyGRhetEi/+ZVRE/pcFoW4RYra6MN4G0U892AwXlNu5nT5w=
Received: by 10.100.248.18 with SMTP id v18mr287442anh.1178627881605;
        Tue, 08 May 2007 05:38:01 -0700 (PDT)
Received: by 10.100.202.10 with HTTP; Tue, 8 May 2007 05:38:01 -0700 (PDT)
In-Reply-To: <20070508101317.GC9007@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46573>

On 5/8/07, Jan Hudec <bulb@ucw.cz> wrote:
> >
> > P.S. Somehow I have the feeling that even if it is a stupidity in cygwin
> > they will not fix it (nor will they admit it is a bug).
>
> They will not. Because it is not a bug. It seems to be (part of) workaround
> to get programs written for unix work in windows.
>

Just as I said. Why don't you just realize that windows is plainly
stupid, illogical piece of sh%t and state clearly that people have to
break their programs so-and-so to work there? Instead, everyone
has to put the most stupid workarounds POSIX ever seen in their
code just to get core functionality (which even HP-UX got right).
