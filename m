From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Marking file as non-binary
Date: Wed, 02 Feb 2011 16:05:11 +0100
Message-ID: <vpqtygm8ok8.fsf@bauges.imag.fr>
References: <iibrce$a8g$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Wed Feb 02 16:05:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkeGu-0004N7-JN
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 16:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab1BBPFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 10:05:23 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49763 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab1BBPFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 10:05:23 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p12F5Ad2005699
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 Feb 2011 16:05:10 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PkeGd-0000Tv-J3; Wed, 02 Feb 2011 16:05:11 +0100
In-Reply-To: <iibrce$a8g$1@dough.gmane.org> (Maaartin's message of "Wed\, 02 Feb 2011 15\:57\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Feb 2011 16:05:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p12F5Ad2005699
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297263913.92815@SQtU2S3nC/6IclHXS3D3Tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165914>

Maaartin <grajcar1@seznam.cz> writes:

> For whatever reason, git claims that my foo.cpp (c++ source) is
> binary,

There is probably a null character in your source ('\0'). You usually
don't want that, regardless of Git.

> *.cpp diff=true text=true

*.cpp diff

works for me. Otherwise, "git log -p -a".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
