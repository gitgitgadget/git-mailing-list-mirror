From: Sean <seanlkml@sympatico.ca>
Subject: Re: A test failing with python 2.2 -- ok?
Date: Sat, 3 Jun 2006 03:12:14 -0400
Message-ID: <BAYC1-PASMTP090E371090E5CDBA2C56B9AE960@CEZ.ICE>
References: <93c3eada0606022348l3c39f966u781327b14b0bc3d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 09:42:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmQmI-0004Wk-TV
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 09:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWFCHmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 03:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWFCHmT
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 03:42:19 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:40813 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750750AbWFCHmS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 03:42:18 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 3 Jun 2006 00:44:06 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id CE757644C28;
	Sat,  3 Jun 2006 03:12:52 -0400 (EDT)
To: geoff@austrics.com.au
Message-Id: <20060603031214.e65c1744.seanlkml@sympatico.ca>
In-Reply-To: <93c3eada0606022348l3c39f966u781327b14b0bc3d5@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 03 Jun 2006 07:44:06.0984 (UTC) FILETIME=[7E358C80:01C686E1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 3 Jun 2006 16:18:32 +0930
"Geoff Russell" <geoffrey.russell@gmail.com> wrote:

> I'm not sure how far back you are supporting, but I'm running a python
> 2.2 machine
> and make test fails with a missing python module. Whatever criss-cross merges
> are, I don't need them, but figured if you were intending to support older
> environments, then you may be interested.

Hi Geoff,

You need Python version 2.3 or newer; from the INSTALL file:

       - "python" 2.3 or more recent; if you have 2.3, you may need
          to build with "make WITH_OWN_SUBPROCESS_PY=YesPlease".

Sean
