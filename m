From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Thu, 13 May 2010 12:59:15 +0200
Message-ID: <961B7250-F65E-4C67-8C5C-6701F68C2FC0@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 13 12:59:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCW8V-0006gK-3L
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 12:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539Ab0EMK7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 06:59:20 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:63573 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab0EMK7T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 06:59:19 -0400
Received: by ewy8 with SMTP id 8so468733ewy.28
        for <git@vger.kernel.org>; Thu, 13 May 2010 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=OgjqARqFePE3RL5I2K85E8Zd3aGJHIuR8t80kEUFo/s=;
        b=gg6bTEYEOnpLC35mxG3oZwdjF6sr+pGPyz/rkiKRybaKV5pmxHMGfbYgldbLz/piXA
         XdVz9xs++CJrissy6kBL6t/sO7AIIXafaZN2HvzVmu5lOk+lgZXyDia1Bc0A62NvDeu4
         aTSW3Xt47xRUbgbk/gHy8W5ZemJu78aUJzzDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=CstQxFmkkt9SV7wL2hBmTotjajkR1uuDxNPCewGtkstrYldV63GLuTquFLt7C84UrS
         InfQ6xhdptNXPWQfhFd5JFeVtGyoeGPaQIzVEa8Yim3vSzyf1NkcvW/UZdokd5zP9rlA
         5kxBNYBXIB2nGJZQt/6QTOsqranXkW5MHJsvo=
Received: by 10.213.67.207 with SMTP id s15mr1279468ebi.76.1273748358096;
        Thu, 13 May 2010 03:59:18 -0700 (PDT)
Received: from [172.16.3.204] (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm625015ewy.6.2010.05.13.03.59.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 03:59:17 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146987>

On 13. mai 2010, at 03.38, Linus Torvalds wrote:

> so now you can write:
> 
> 	*.jpg -text
> 	*.txt text
> 	*.vcproj eol=crlf
> 	*.sh eol=lf
> 	* text=auto

[...]

> Doesn't that look finally sane?
> 
> Because if we really renaem the attributes, let's rename them _right_.

Beautiful.

Do you agree that "native" eol should only be CRLF if autocrlf is true?  Otherwise, if .gitattributes looks like this:

	*.txt text

git will put CRLFs in .txt files but LFs in .c files, and I don't think that makes much sense.
-- 
Eyvind
