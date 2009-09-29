From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 19:07:50 +0200
Message-ID: <vpqws3hsmqh.fsf@bauges.imag.fr>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	<fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
	<vpq1vlp962h.fsf@bauges.imag.fr>
	<fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
	<970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com>
	<vpq63b1u1p6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Ben Bennett <benbennett@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 19:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsgBO-00070n-Cf
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 19:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbZI2RHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 13:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbZI2RHz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 13:07:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36126 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbZI2RHy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 13:07:54 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2009 13:07:54 EDT
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8TH4O43019727
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Sep 2009 19:04:24 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MsgB5-0004Ky-81; Tue, 29 Sep 2009 19:07:51 +0200
In-Reply-To: <vpq63b1u1p6.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue\, 29 Sep 2009 18\:59\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Sep 2009 19:04:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8TH4O43019727
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1254848666.44299@cxSb6l8QXwCB6jm5eLUvzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129315>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> In short, you have to use %40 to escape the @, and curl does it this
> way because the RFC doesn't allow @ in usernames.

I've added a FAQ on the wiki. Feel free to improve:

http://git.or.cz/gitwiki/GitFaq#Myusernamecontainsa.27.40.27.2CIcan.27tclonethroughHTTP.2BAC8-HTTPS

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
