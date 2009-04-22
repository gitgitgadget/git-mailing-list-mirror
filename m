From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-svn init/fetch: wow that's slow
Date: Wed, 22 Apr 2009 13:16:04 +0200
Message-ID: <vpqmya9rlaj.fsf@bauges.imag.fr>
References: <E26B8975-74D3-4F01-A9D9-DAAB96C8FC85@gmail.com>
	<fabb9a1e0904220255w55c8fee1uf534aad07cefa818@mail.gmail.com>
	<1240398352.20236.26.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Lachlan Deck <lachlan.deck@gmail.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 13:21:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwaVa-0001WI-Sn
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 13:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbZDVLTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 07:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbZDVLTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 07:19:09 -0400
Received: from imag.imag.fr ([129.88.30.1]:54382 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbZDVLTG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 07:19:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3MBG8jB021083
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Apr 2009 13:16:08 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LwaQu-0007Yg-CM; Wed, 22 Apr 2009 13:16:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LwaQu-0000Rq-9v; Wed, 22 Apr 2009 13:16:04 +0200
In-Reply-To: <1240398352.20236.26.camel@maia.lan> (Sam Vilain's message of "Wed\, 22 Apr 2009 23\:05\:52 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 22 Apr 2009 13:16:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117192>

Sam Vilain <sam@vilain.net> writes:

> One workaround is to use SVK to do the initial mirroring, 

Probably svnsync can help here too. Dunno whether it's gonna be
faster ...

-- 
Matthieu
