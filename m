From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 09:56:50 +0100
Message-ID: <CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
	<20121125051809.GA3670@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Nov 25 09:57:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcY1S-0006SP-D5
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 09:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab2KYI4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 03:56:51 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33707 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2KYI4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 03:56:51 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so9986560obb.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 00:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FwZ0PClfRy/RpPQbu7A2ISDe5FB1orgr3y2m0XSo4Tg=;
        b=rEXxwDAM+1M+xsfi/Wb9wa2D+DG78s+g5VDlk5xRzAeEW1QigCnbc4aL2sraCMOrRy
         d1Fh5bWcbWwuVuqceCH00pO23SKqTudtWvkyc+Qb2+J06nKpdMUaHpkdvdpWfgXQkytJ
         0voU9Fqq12xO4/ryQpv67p4yQKf8F4z3Moi0i/EUhd/vnz2YKft3Xv6nrwibR+kYJwFf
         MwS5O3lllKx+gYyvjm04uOUKykUUN/uvg8Bg7Cpb+ibHqUEMMjbFOn5wZdcdaXLgRVkq
         f9tVCkJSJsbVZ7fW6nSLcf5ad6Fyka8/N1PE/gUCTdRomsjDuHdVh2O8KmpfszqrSG1Q
         mZ+g==
Received: by 10.182.21.175 with SMTP id w15mr6743441obe.28.1353833810394; Sun,
 25 Nov 2012 00:56:50 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 25 Nov 2012 00:56:50 -0800 (PST)
In-Reply-To: <20121125051809.GA3670@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210338>

On Sun, Nov 25, 2012 at 6:18 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>> These may apply to other languages as well. Where do we draw a line?
>
> I'm in favor of the general policy of avoiding scripting languages
> other than the top three most widely deployed.  At the moment that
> means shell, Python, Perl; on present trends, in a few years Perl
> (dropping in popularity) might be passed by Ruby on the way up.

Top three according to whom?

According to TIOBE it's python, perl, and ruby (if you don't count VB
or PHP), and perl is beating ruby only by a small margin that will
probably disappear soon. However, shell has advantages none of the
above have.

http://1.1.1.4/bmi/www.tiobe.com/content/paperinfo/tpci/images/tpci_trends.png

Cheers.

-- 
Felipe Contreras
