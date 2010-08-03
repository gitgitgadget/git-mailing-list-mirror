From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-compat-util.h: Don't define NORETURN under __clang__
Date: Tue, 03 Aug 2010 16:23:21 +0200
Message-ID: <vpqvd7rzsfa.fsf@bauges.imag.fr>
References: <1280840883-24540-1-git-send-email-avarab@gmail.com>
	<vpq62zr24zw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 16:23:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgIP1-0002Y9-O1
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 16:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800Ab0HCOX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 10:23:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34307 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756759Ab0HCOX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 10:23:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o73ELHwC011943
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Aug 2010 16:21:19 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgIOn-0002cg-JY; Tue, 03 Aug 2010 16:23:21 +0200
In-Reply-To: <vpq62zr24zw.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue\, 03 Aug 2010 15\:35\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 03 Aug 2010 16:21:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o73ELHwC011943
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281450079.76141@1mtESq2zxddrfu+vus09/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152522>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> (other than that, it's cool to see someone testing another
> compiler ;-) )

BTW, the only warnings remaining with -Wall with my clang are:

imap-send.c:548:27: warning: data argument not used by format string [-Wformat-extra-args]
                           cmd->tag, cmd->cmd, cmd->cb.dlen);
                                               ^
imap-send.c:1089:41: warning: conversion specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                snprintf(portstr, sizeof(portstr), "%hu", srvc->port);
                                                    ~~^   ~~~~~~~~~~
2 diagnostics generated.

and the tests pass.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
