From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 22:22:38 +0100
Message-ID: <CAMP44s3QNG-sxcZsWmL3RYjXkzOwerj2774t7Abh04A7QR6TCA@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
	<20121125051809.GA3670@thyrsus.com>
	<CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
	<20121125095429.GB22279@thyrsus.com>
	<CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com>
	<20121125175051.GD32394@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Nov 25 22:22:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcjfD-00058t-DT
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 22:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab2KYVWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 16:22:39 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53592 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab2KYVWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 16:22:39 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so10196680oag.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 13:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BwTZcJbcWrPl8tFaWhA++rSRSiMoHaWuIYTM126x1a0=;
        b=K1z0wRTyMnKgxSmck7uerPSGPnBNn35+QID5qYCC+NVOeRRePBoPreeFvBcWDf/bgK
         QsoKEZfM4uRLpims3gfdTNQGSJZlQqVDLqaCslYgyh4FZuCyedyfeK4fqrFjl2szo2e0
         T6qgP9jL7XlOatzRlTYegPfXOZPoMBCpkxNjInZPioqwRdyMPXWVoDhJqRuKx9cOL+sC
         Sjlk8vKn8yZuT7mcCD3TeRzh8MxB6FG0fJFDkR95n4+CpHCWbN2gHZZir1p+oq4atZDx
         qfeg8A4uWeiwxLMmCWJXKZJQASgNuM2t1KtoeoSgi2dfpvHv0VfnTYi076r0gs7mb8wZ
         0xyA==
Received: by 10.60.31.6 with SMTP id w6mr7716258oeh.65.1353878558408; Sun, 25
 Nov 2012 13:22:38 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 25 Nov 2012 13:22:38 -0800 (PST)
In-Reply-To: <20121125175051.GD32394@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210381>

On Sun, Nov 25, 2012 at 6:50 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> Not according to ohloh:
>>
>> 1) shell 33%
>> 2) tcl 9%
>> 3) perl 9.7%
>>
>> 4) python 1.8%
>
> Look in the Makefile - all that tcl code is buried in gitk.  We're
> very, very lucky the author did such a good job, because it's a
> potentially serious headache; who can maintain it?

And gitk is an integral part of git. But if you have different
numbers, what are they?

-- 
Felipe Contreras
