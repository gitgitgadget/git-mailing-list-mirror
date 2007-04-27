From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Fri, 27 Apr 2007 18:13:26 -0300
Organization: Mandriva
Message-ID: <20070427181326.14bbbf5c@localhost>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
	<1177693212202-git-send-email-lcapitulino@mandriva.com.br>
	<7vabwtobpg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 23:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhXlf-0007yM-PN
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 23:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757312AbXD0VNm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 17:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757314AbXD0VNm
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 17:13:42 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:33702 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313AbXD0VNk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 17:13:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5FC3B1823F;
	Fri, 27 Apr 2007 18:13:38 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Ijnvak0PKHsb; Fri, 27 Apr 2007 18:13:27 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 2DE7618247;
	Fri, 27 Apr 2007 18:13:27 -0300 (BRT)
In-Reply-To: <7vabwtobpg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45754>

Em Fri, 27 Apr 2007 12:32:11 -0700
Junio C Hamano <junkio@cox.net> escreveu:

| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
| writes:
| 
| > From: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
| >
| > This macro may be used to iterate over revisions, so, instead of
| > doing: ...
| 
| I am not a big fan of magic control-flow macros, as it makes the
| code harder to grok for people new to the codebase.

 Yeah, I agree. But I think that any experienced programmer will
understand it.

 Anyways, I don't want to raise polemic discussions for minor
changes. Feel free to drop this one then.

-- 
Luiz Fernando N. Capitulino
