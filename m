From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Makefile: Remove usage of deprecated Python "has_key"
 method
Date: Mon, 29 Mar 2010 04:16:40 +0200
Message-ID: <201003290416.40774.johan@herland.net>
References: <1269737112-21631-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 04:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw4Z5-0006lT-Vb
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 04:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692Ab0C2CSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 22:18:50 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49824 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628Ab0C2CSt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 22:18:49 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L0000EFCUBUL970@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 29 Mar 2010 04:16:42 +0200 (MEST)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L0000CIVUBT4U10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 29 Mar 2010 04:16:42 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.29.20325
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <1269737112-21631-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143427>

On Sunday 28 March 2010, David Aguilar wrote:
> "has_key" is a deprecated dictionary method in Python 2.6+.
> Simplify the sys.path manipulation for installed scripts by
> passing a default value to os.getenv().
> 
> SCRIPT_PYTHON is currently empty but this future-proofs us.
> It also fixes things for users who maintain local git forks
> with their own SCRIPT_PYTHON additions.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>

Acked-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
