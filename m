From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: utf8 BOM
Date: Sun, 16 May 2010 09:19:27 +0400
Message-ID: <20100516051927.GA17200@dpotapov.dyndns.org>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
 <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
 <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
 <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com>
 <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com>
 <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com>
 <20100514101648.GB6212@dpotapov.dyndns.org>
 <61355CFC-EB9E-4B76-9450-F2DF1B2903C0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Buck <buck.robert.j@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 07:21:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODWI9-0008NF-K5
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 07:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab0EPFTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 01:19:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50790 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0EPFTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 01:19:33 -0400
Received: by fxm6 with SMTP id 6so2710076fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 22:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ysWA+0V9XWpaTgYeU1sIMJLF2CYbm0QGoGHPU4yWK/U=;
        b=jhziEvKDq07keYNTCENQUJlmYxtFWO+C7kKqa7IkCYMBjsVP48OrHEZ8yua+xPOakh
         VHnXk5RxjXGmjj9CH/u/SAAc8NnZzc7O7f99GwAEibXvOC3CQOJtAXZDiOEmR8QgH3xa
         ljJmreinxWhnSxIeaDavkfTeNphnMknMwdpr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ja8xnvrN4jOdDAVyI7LhY/zFzzXTKrj2a0WeheXGxVqQ7kP7m5ddJ+EUbn7OpFdrvN
         aNOLk7lFE89tMKs685ufksYFNbnUl0n59IfHUVtWy6ibyicE1AK1Nr74AZ+if2rzIRln
         +/DrEZaRqDO0o35K7ra6TuDRbKv1NzL1jBtFc=
Received: by 10.223.17.197 with SMTP id t5mr4105226faa.84.1273987171542;
        Sat, 15 May 2010 22:19:31 -0700 (PDT)
Received: from localhost (ppp85-140-167-233.pppoe.mtu-net.ru [85.140.167.233])
        by mx.google.com with ESMTPS id y12sm19166903faj.5.2010.05.15.22.19.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 22:19:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <61355CFC-EB9E-4B76-9450-F2DF1B2903C0@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147175>

On Sat, May 15, 2010 at 10:23:52PM +0200, Eyvind Bernhardsen wrote:
> On 14. mai 2010, at 12.16, Dmitry Potapov wrote:
> 
> > Probably, ability of automatic add utf8 BOM on Windows to text files
> > (which are marked as "unicode") can be helpful, but it is just a part
> > of the problem of how to deal with text files in "legacy" encoding,
> > which are still widely used on Windows.
>
> Sounds like something a clean/smudge filter should be able to do.

Yes, it should if you handful files that need such conversion. However,
if you want it for every text file, running filters are slow (especially
on Windows), and they are not capable to autodetect text.

> (which hopefully works no matter what your code
> page is?  I don't know much about Windows i18n).

Yes, it does. I am not an expert on Windows either, but as far as I
know, BOM are used to mark unicode files, which could be either UTF-8
or UTF-16. BTW, UTF-16 are treated by Git as "binary" now, which may
not always convenient, because impossible to do "merge" or "diff".

> Adding this to convert.c would be more difficult, at least
> politically, since I assume it would be Windows-specific code.

I don't think it needs any Windows-specific code. We already have some
functions to convert text from different charsets, which could be used.
But this feature should be developed and tested by people who work on
Windows regularly and need this feature, because there is no substitute
for testing and experience of how well it works in practice. Currently,
I rarely use Windows and can get by clean/smudge filters.


Dmitry
