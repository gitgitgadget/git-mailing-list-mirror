From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Blamming a diff between two commits?
Date: Tue, 17 Feb 2009 15:03:58 +0100
Message-ID: <vpqocx1qhwx.fsf@bauges.imag.fr>
References: <499AB8A1.7090909@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:16:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQji-0001O7-8z
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbZBQOOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbZBQOOW
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:14:22 -0500
Received: from imag.imag.fr ([129.88.30.1]:38955 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbZBQOOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 09:14:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n1HE47Q0006252
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Feb 2009 15:04:07 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LZQYI-0006Ki-TE; Tue, 17 Feb 2009 15:03:58 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LZQYI-0004aa-Qs; Tue, 17 Feb 2009 15:03:58 +0100
In-Reply-To: <499AB8A1.7090909@datacom.ind.br> (Samuel Lucas Vaz de Mello's message of "Tue\, 17 Feb 2009 10\:16\:17 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 17 Feb 2009 15:04:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110386>

Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br> writes:

> Hi,
>
> Is there any way to git blame (or annotate) a diff between two commits?

I don't think this is implemented (but would be nice).

> Using a git-blame in the resulting file give me the commits for the
> lines added, but not for the deleted ones.

A preliminary implementation of "git blame --reverse" was proposed by
Junio here:

  http://kerneltrap.org/mailarchive/git/2008/4/3/1338234

And an approximation of it is proposed in the thread:

  http://kerneltrap.org/mailarchive/git/2008/4/3/1343554

I don't know the status of this patch (dropped?).

-- 
Matthieu
