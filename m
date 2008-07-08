From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: uninstalling Git
Date: Tue, 08 Jul 2008 08:28:33 +0200
Message-ID: <vpqtzf0vqi6.fsf@bauges.imag.fr>
References: <4872F3B0.6050406@jaeger.mine.nu>
	<87od59c58s.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Hanchrow <offby1@blarg.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 08:30:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG6iO-0007F1-DC
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 08:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbYGHG3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 02:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYGHG3S
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 02:29:18 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:55951 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbYGHG3S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 02:29:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m686SXpq007576;
	Tue, 8 Jul 2008 08:28:33 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KG6gj-0006Op-Rv; Tue, 08 Jul 2008 08:28:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KG6gj-0000v8-OH; Tue, 08 Jul 2008 08:28:33 +0200
In-Reply-To: <87od59c58s.fsf@offby1.atm01.sea.blarg.net> (Eric Hanchrow's message of "Mon\, 07 Jul 2008 22\:30\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 08 Jul 2008 08:28:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87722>

Eric Hanchrow <offby1@blarg.net> writes:

> * Failing that, I run
>
>         find /usr -printf '%T@ ' -ls | sort -n | cut -d\  -f 2-
>

I usualy do

touch /tmp/dumb.txt
make install
find /usr -newer /tmp/dumb.txt

for that.

-- 
Matthieu
