From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not trust PWD blindly
Date: Mon, 11 Jul 2011 00:59:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1107110057120.3379@bonsai2>
References: <CABNJ2GKgzXGDq9FhKcVP380bs=rEKqYdrOaCb+A99_TBm7A4_A@mail.gmail.com> <alpine.DEB.1.00.1107091935210.1985@bonsai2> <4E1A0FCC.7080308@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@gmail.com>, gitster@pobox.com,
	msysGit <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 00:59:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qg2y2-00052B-IZ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 00:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767Ab1GJW7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jul 2011 18:59:10 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:55032 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756766Ab1GJW7H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2011 18:59:07 -0400
Received: (qmail invoked by alias); 10 Jul 2011 22:59:05 -0000
Received: from pD9EB124F.dip0.t-ipconnect.de (EHLO noname) [217.235.18.79]
  by mail.gmx.net (mp032) with SMTP; 11 Jul 2011 00:59:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sGo93rAwsamVnLsbkR8A0w03IIICm/2ATzoIGRt
	NqCaocoaeTD1g8
X-X-Sender: gene099@bonsai2
In-Reply-To: <4E1A0FCC.7080308@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176829>

Hi,

On Sun, 10 Jul 2011, Johannes Sixt wrote:

> Am 09.07.2011 19:38, schrieb Johannes Schindelin:
> > 
> > At least on Windows, chdir() does not update PWD.
> 
> Very strange wording. chdir() should not update PWD even on POSIX.

Well, you might think it is strange wording. But then, it expresses 
exactly what I meant it to say. chdir() does not update PWD on Windows.

You might be very surprised, but that is not true on the Linux system 
where one of the 4msysgit.git test cases does _not_ break, while it does 
on Windows.

I hoped to make that clear with the wording, but apparently I failed 
rather blatantly.

All the more surprising do I find that:

> Acked-by: Johannes Sixt <j6t@kdbg.org>

Ciao,
Johannes
