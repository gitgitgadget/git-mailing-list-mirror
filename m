From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-completion: workaround zsh COMPREPLY bug
Date: Sat, 28 Jan 2012 19:18:07 +0200
Message-ID: <CAMP44s27i=5iX9Dr+TmOLKaAa0=TC-JwED5WuiDguBuBbfMEhQ@mail.gmail.com>
References: <1327455422-22340-1-git-send-email-felipe.contreras@gmail.com>
	<vpqwr8g8c03.fsf@bauges.imag.fr>
	<CAMP44s16L0GJUh4JcQgjBXUf4ftT7yQFgPy0p6zCNMnZjZGQww@mail.gmail.com>
	<vpqr4ynzbj7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jan 28 18:40:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCFs-0000o9-Qa
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab2A1RSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 12:18:10 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56382 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752722Ab2A1RSJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jan 2012 12:18:09 -0500
Received: by lagu2 with SMTP id u2so1518099lag.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 09:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ivS6acM63oXVfenC5M//mIboSqekE+QGVY+y+D7GuFA=;
        b=rEVvi/8yX3yuGAKNB1zaAHKlEk9yDPvNnIRvDTFh3UQx3bZJWKskIncMVgZ4JoqKT0
         3X0KWFTriyJWtjVQZ2CGgKpsParm+R1ZB+cfQudOXRRs23S+enhYfLNl6TUBDtYmQhL4
         LBx1R0H3lTcbEElHiH9UscakkStAWgOXrzuRA=
Received: by 10.112.101.134 with SMTP id fg6mr2973452lbb.63.1327771087798;
 Sat, 28 Jan 2012 09:18:07 -0800 (PST)
Received: by 10.112.10.169 with HTTP; Sat, 28 Jan 2012 09:18:07 -0800 (PST)
In-Reply-To: <vpqr4ynzbj7.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189257>

On Thu, Jan 26, 2012 at 12:02 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I still have a minor comment: maybe part of your commit message could go
> to a comment in the code as well, in particular the "Once zsh is fixed"
> part, to help future contributors to actually disable the workaround
> when possible in the future.

FTR, I've fixed all the issues in zsh's bash completion:

http://thread.gmane.org/gmane.comp.shells.zsh.devel/24290

Now I don't need the workaround and it works just like in bash :)
However, zsh devs seem very quiet.

Cheers.

-- 
Felipe Contreras
