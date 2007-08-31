From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Fri, 31 Aug 2007 13:57:26 -0300
Organization: Mandriva
Message-ID: <20070831135726.783305e5@localhost>
References: <20070814164453.400b9c55@localhost>
	<46D7D0F7.1050302@trolltech.com>
	<46D7D284.30004@telecom.at>
	<46D7D48D.6000503@trolltech.com>
	<46D7D60C.8090608@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:57:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR9oV-0004EJ-OV
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760814AbXHaQ5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760827AbXHaQ5i
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:57:38 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:45883 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760814AbXHaQ5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:57:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 764621A5EC;
	Fri, 31 Aug 2007 13:57:35 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 6yyjkRb7FFrd; Fri, 31 Aug 2007 13:57:27 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id E5C9D1A55E;
	Fri, 31 Aug 2007 13:57:26 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by fox.conectiva (Postfix) with ESMTP id BED1A2F584;
	Fri, 31 Aug 2007 13:57:26 -0300 (BRT)
In-Reply-To: <46D7D60C.8090608@telecom.at>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.11.6; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57188>

Em Fri, 31 Aug 2007 10:49:16 +0200
Johannes Sixt <j.sixt@telecom.at> escreveu:

| Marius Storm-Olsen schrieb:
| > Just wanted to let the original author know, so he would be aware of it, 
| > and we wouldn't have to go the extra round-trips with patches to fix 
| > patches. (And for MinGW awareness when adding code to git-compat-util.h)
| 
| You can't expect a lot of MinGW awareness from non-MinGW users when they 
| make changes to git-compat-util.h since upstream does not have _any_ 
| references to MinGW there, yet.

 Droping people from the CC doesn't help either.

 Please, do not do that.

-- 
Luiz Fernando N. Capitulino
