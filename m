From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: utf8 BOM
Date: Sun, 16 May 2010 12:37:54 +0200
Message-ID: <00E0B9AC-2A2E-4F95-9B35-F3F63EBC3CF3@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org> <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com> <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com> <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com> <20100514101648.GB6212@dpotapov.dyndns.org> <61355CFC-EB9E-4B76-9450-F2DF1B2903C0@gmail.com> <20100516051927.GA17200@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Robert Buck <buck.robert.j@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 12:38:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODbES-00072t-VJ
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 12:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114Ab0EPKiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 06:38:00 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:53093 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab0EPKh6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 May 2010 06:37:58 -0400
Received: by ewy8 with SMTP id 8so1413520ewy.28
        for <git@vger.kernel.org>; Sun, 16 May 2010 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=b65JqBAjw4RuYGiINYyZcW09AXfDOG2LqN0vJxpIXUs=;
        b=TLEEvJe0jKoCjNakX2jql2+Rs/FJ3HqLdwwiYeGLMjlR5usCapmqWR7dT0rONzfc/b
         asKnBR3hK1BI1NS/5zTOWcjGKWGJ4/JlS4RkJIZb+KupCxeHWnsco6NBkWoNwZsIYb30
         2CN3BP+HdZdQ5/zRpxm3BHiHQrVu3yXTT0WU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=O9Mbu7rbLnuCT4UloYJyGH2eEfEk25VFWnjAjeZaNSIUEzJky6s67GYNtYOdOEPjhG
         yG1Zfgqv0VcTccbu14KQwfza70WDysmgwi3OsBpjV5g60SqosJlFbnTd6d4cD9MRL0YZ
         qV7T38XmWXv+LKNRrejqjh3Z21r9s0kXRwZA0=
Received: by 10.213.63.75 with SMTP id a11mr1953784ebi.9.1274006276687;
        Sun, 16 May 2010 03:37:56 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm2221181ewy.13.2010.05.16.03.37.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 03:37:56 -0700 (PDT)
In-Reply-To: <20100516051927.GA17200@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147184>

On 16. mai 2010, at 07.19, Dmitry Potapov wrote:

> On Sat, May 15, 2010 at 10:23:52PM +0200, Eyvind Bernhardsen wrote:
>> (which hopefully works no matter what your code
>> page is?  I don't know much about Windows i18n).
> 
> Yes, it does. I am not an expert on Windows either, but as far as I
> know, BOM are used to mark unicode files, which could be either UTF-8
> or UTF-16. BTW, UTF-16 are treated by Git as "binary" now, which may
> not always convenient, because impossible to do "merge" or "diff".

Okay, so something that checks text files to see if they're utf16 (maybe just accept anything with a utf16 BOM as utf16?) and converts them to utf8 might be useful on any platform.  Stripping utf8 BOMs and optionally re-adding them on output would be a natural extension.  "core.autoutf", anyone?

>> Adding this to convert.c would be more difficult, at least
>> politically, since I assume it would be Windows-specific code.
> 
> I don't think it needs any Windows-specific code. We already have some
> functions to convert text from different charsets, which could be used.
> But this feature should be developed and tested by people who work on
> Windows regularly and need this feature, because there is no substitute
> for testing and experience of how well it works in practice. Currently,
> I rarely use Windows and can get by clean/smudge filters.

Yeah, the problem is finding someone who needs the feature _and_ is able/willing to implement it.  I try to keep a Unix-like experience on Windows, so I don't usually run into utf8 BOMs.
-- 
Eyvind
