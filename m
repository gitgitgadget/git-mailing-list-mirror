From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Tue, 22 Sep 2009 19:17:25 +1000
Message-ID: <d2e97e800909220217y5bda4698pc286711a3535f87d@mail.gmail.com>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com> 
	<4AB869EE.1020200@viscovery.net> <4AB87B6B.1070808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 11:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq1VO-0007xz-R8
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 11:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbZIVJRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 05:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbZIVJRl
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 05:17:41 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:59003 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbZIVJRl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 05:17:41 -0400
Received: by yxe37 with SMTP id 37so4037999yxe.33
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=jBRcyNKp98VaM83lSkjFx0IXhpzc44QeVaAH3M1h60Y=;
        b=X5dBuyxEbWRxCJqqr5gP3uabuRRCu966+kgtEy7v99sZ5BmD1o+BayIZhzeDOF5NKV
         Qor46keaX5zv4GWlBdNyYDMrTWmBAhzCqoqSje1qkMxXTcRquqg1l5gYK5IOHFIit+lw
         UESPgw21GFRNGR1t12+5ungf9lJygV+aE5nw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XFs5No4tGfyNPZ4O2p6YKJshWuH8meflJfuVYtpFAbhJbv18xwr3AtZmHqknG2Dqjx
         63cKgnZljkRJkgXK1Ekt3FPxkApxpWSv24D2FlNeSP0pgOgOL0HkLFasurcPJ1pS8SEW
         CSEX2eFfEzT/K7uCi5FEKK7CFDzI96gDk3WLE=
Received: by 10.101.190.9 with SMTP id s9mr680024anp.198.1253611065094; Tue, 
	22 Sep 2009 02:17:45 -0700 (PDT)
In-Reply-To: <4AB87B6B.1070808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128926>

2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
> Michael, how are you trying to compile git? With the IDE or
> the GNU Make? Which version of MSVC? If you use the IDE, can
> you make sure it doesn't contain the UNICODE define in the
> compiler section of the properties of the projects?

I'm using the VS 2008 Professional IDE (the solution doesn't open in
VS 2005). I made no changes to the build settings. In the Preprocessor
section of the project, UNICODE is defined.

On another note, I see *many* build warnings for things like
"signed/unsigned compares". I'd be willing to work through these
warnings and fix them. Thoughts?
