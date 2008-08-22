From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: some questions
Date: Fri, 22 Aug 2008 10:53:41 +0200
Message-ID: <vpqtzddtoq2.fsf@bauges.imag.fr>
References: <48AE6B41.1070005@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Pasch <thomas.pasch@jentro.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 11:00:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWSVN-0007aK-Qy
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 11:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbYHVI7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 04:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbYHVI7V
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 04:59:21 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:64962 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbYHVI7T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 04:59:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m7M8uso1010089;
	Fri, 22 Aug 2008 10:56:54 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KWSOr-0000Cd-MW; Fri, 22 Aug 2008 10:53:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KWSOr-0000IH-JG; Fri, 22 Aug 2008 10:53:41 +0200
In-Reply-To: <48AE6B41.1070005@jentro.com> (Thomas Pasch's message of "Fri\, 22 Aug 2008 09\:31\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 22 Aug 2008 10:56:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93276>

Thomas Pasch <thomas.pasch@jentro.com> writes:

> Hello,
>
> I try to migrate our old cvs repo to git.
> However, I still have to following questions
> that I found difficult to answer with
> the documentation.
>
> - Is there a way to convert a indexVersion 1
>   repo to indexVersion 2? (And vice versa?)

The index itself is just a little file in .git/index. There might be a
better solution, but just

  rm .git/index
  git reset

seems to do it (of course, don't do while you have staged changes in
the index !).

> - http for git seems to be read-only/fetch.
>   Would it be (theoretically) possible to
>   support write/push (with WebDAV or so)?

http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt

(BTW, that's the first result in
http://www.google.com/search?q=git+webdav ;-) )

-- 
Matthieu
