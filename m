From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Merge problems with git-mingw
Date: Mon, 8 Oct 2007 21:59:56 +0200
Message-ID: <8c5c35580710081259j6d7e8587r546d4c35d42a67a6@mail.gmail.com>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se>
	 <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com>
	 <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se>
	 <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com>
	 <Pine.LNX.4.64.0710081555480.29570@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <j.sixt@viscovery.net>
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Oct 08 22:00:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ieylv-0003tM-JK
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 22:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbXJHT77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 15:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbXJHT77
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 15:59:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:2149 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbXJHT76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 15:59:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1777208wah
        for <git@vger.kernel.org>; Mon, 08 Oct 2007 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WJyyIxQd6YDLMaIoMP/jJUbbN/MjA/rVWB+MC9msyws=;
        b=aP0utR03Hmk62nZAOJ6E6BHVpux97gMc8zjvIVAuRQrfwQpVAStkvqGzuVvgf4fAUMsTwHl3AhjH/rUfPWfAvyWWITkGWLLtLNQyabDTZgzUp2yuI6+XJqNIYhngNfWofSDjZbtb4ovA4CppNyoTB/P4b4HHQ2PG1ivYuyfFEFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Shd46ng5E/sq2ZglCcny8agaqpxtNtuV9GpySGAkUm1Krtv/36zM2x1yhIfttP5NEyB9++i0TcpY8+59MFbVRXfTEqUS3T3pBpcJCXP7BDxJ7bkP2c2n91F4r4K5ZJdwYhHzbASMyWm88YINU42YwDQ+IsdFQ7SQ5ZpCw8buoDY=
Received: by 10.115.92.2 with SMTP id u2mr11190348wal.1191873596764;
        Mon, 08 Oct 2007 12:59:56 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Mon, 8 Oct 2007 12:59:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710081555480.29570@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60335>

[Johannes CC'ed as the mingw.git maintainer]

On 10/8/07, Peter Karlsson <peter@softwolves.pp.se> wrote:
> $ git var GIT_COMMITTER_IDENT
> usage: git-var [-l | <variable>]

Does 'git var -l' work as expected? Also, could you try the latest
git-package provided by the cygwin installer? If CRLF-handling was
your problem, take a look at the description of core.autocrlf with
'git help config'.

[This does look like an issue with running mingw.git under Cygwin.
Johannes, is this even supposed to work?]

--
larsh
