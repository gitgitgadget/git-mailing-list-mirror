From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 17:42:23 +0100
Message-ID: <vpqej1wra1c.fsf@bauges.imag.fr>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
	<m37i7pggnk.fsf@localhost.localdomain>
	<f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
	<200810311726.57122.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Thanassis Tsiodras" <ttsiodras@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 17:48:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvxAk-0007Ld-Tv
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 17:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbYJaQrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 12:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753227AbYJaQrP
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 12:47:15 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:37889 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161AbYJaQrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 12:47:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m9VGiZOm015280;
	Fri, 31 Oct 2008 17:44:35 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kvx4p-0004o3-BR; Fri, 31 Oct 2008 17:42:23 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kvx4p-0003MT-91; Fri, 31 Oct 2008 17:42:23 +0100
In-Reply-To: <200810311726.57122.jnareb@gmail.com> (Jakub Narebski's message of "Fri\, 31 Oct 2008 17\:26\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 31 Oct 2008 17:44:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99601>

Jakub Narebski <jnareb@gmail.com> writes:

> Thanassis Tsiodras wrote:
>  
>> So I have to git-gc on my side (after the commits), git-gc on the remote,
>> and then git-push?
>
> Perhaps I haven't made myself clear.
>
> On the local side: git-commit creates loose (compressed, but not
> deltified) objects. git-gc packs and deltifies.
>
> On the remote side (for smart protocols, i.e. git and ssh): git
> creates _thin_ pack, deltified; 

I don't understand this point: the OP talks about pushing, so isn't
the pack created on the _local_ machine (and then sent to the remote)?

-- 
Matthieu
