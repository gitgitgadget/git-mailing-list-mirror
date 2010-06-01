From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git send-email should always ask for in-reply-to
Date: Tue, 01 Jun 2010 17:46:37 +0200
Message-ID: <vpqtypmn4bm.fsf@bauges.imag.fr>
References: <201006011641.12401.alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
X-From: git-owner@vger.kernel.org Tue Jun 01 17:46:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTfy-0006D3-P0
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab0FAPql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 11:46:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57633 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756171Ab0FAPqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 11:46:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o51FdHLY002741
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Jun 2010 17:39:17 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OJTfp-0006Bf-OC; Tue, 01 Jun 2010 17:46:37 +0200
In-Reply-To: <201006011641.12401.alexander.stein@informatik.tu-chemnitz.de> (Alexander Stein's message of "Tue\, 1 Jun 2010 16\:41\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Jun 2010 17:39:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o51FdHLY002741
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1276011557.57424@gmKwl36/JWO9R8RX5mknRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148130>

Alexander Stein <alexander.stein@informatik.tu-chemnitz.de> writes:

> i currently have the problem that, if I set sendemail.from and sendemail.to in 
> git-config (from global and to project-specific but that doesn't matter) git 
> send-email doesn't ask me for a in-reply-to message-ID.
[...]
> What do you think about it?

I do find this annoying: my name doesn't change often, so I want to
give it in ~/.gitconfig, but then the prompt for a message-id
disapears. But I didn't find time to make a patch :-(.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
