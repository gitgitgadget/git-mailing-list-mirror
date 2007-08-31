From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Fri, 31 Aug 2007 09:48:39 -0300
Organization: Mandriva
Message-ID: <20070831094839.362352ec@localhost>
References: <20070814164453.400b9c55@localhost>
	<46D7D0F7.1050302@trolltech.com>
	<46D7D284.30004@telecom.at>
	<46D7D48D.6000503@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 14:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR5w2-0000Dw-8D
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 14:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbXHaMsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 08:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbXHaMsr
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 08:48:47 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:41562 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbXHaMsq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 08:48:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id EBDC718FF6;
	Fri, 31 Aug 2007 09:48:44 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 3DnewXvE-Nn1; Fri, 31 Aug 2007 09:48:40 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id F170E18FEF;
	Fri, 31 Aug 2007 09:48:39 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by fox.conectiva (Postfix) with ESMTP id 91EBF2F56A;
	Fri, 31 Aug 2007 09:48:39 -0300 (BRT)
In-Reply-To: <46D7D48D.6000503@trolltech.com>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.11.6; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57164>

Em Fri, 31 Aug 2007 10:42:53 +0200
Marius Storm-Olsen <marius@trolltech.com> escreveu:

| Johannes Sixt said the following on 31.08.2007 10:34:
| > Marius Storm-Olsen schrieb:
| >> This functions needs to be further down in the file for MinGW
| >> builds, since mkstemp() is forward declared later in the file.
| >> So, something like this:
| > 
| > Please consider using the lates MinGW port. It's already fixed
| > there.
| 
| Right. (That's the whole 4msysgit.git mingw.git discussion on the 
| msysgit mailinglist these days)
| 
| Just wanted to let the original author know, so he would be aware of 
| it, and we wouldn't have to go the extra round-trips with patches to 
| fix patches. (And for MinGW awareness when adding code to 
| git-compat-util.h)

 ACKed, thank you Marius.

-- 
Luiz Fernando N. Capitulino
