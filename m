From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 23:50:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605292349510.18299@wbgn013.biozentrum.uni-wuerzburg.de>
References: <v0irnpn8ea.fsf@marajade.sandelman.ca> <e5d6i0$rnf$1@sea.gmane.org>
 <Pine.LNX.4.63.0605290910210.8863@wbgn013.biozentrum.uni-wuerzburg.de>
 <447ADAEF.3030806@Intel.com> <Pine.LNX.4.64.0605290956190.5623@g5.osdl.org>
 <20060529212830.GA4074@limbo.home>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-820428490-1148939435=:18299"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:50:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkpdJ-0002Hw-1D
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWE2Vui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWE2Vuh
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:50:37 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2510 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751316AbWE2Vug (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 17:50:36 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id BF69E14F2;
	Mon, 29 May 2006 23:50:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B35A914DF;
	Mon, 29 May 2006 23:50:35 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 94E3214DB;
	Mon, 29 May 2006 23:50:35 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20060529212830.GA4074@limbo.home>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20979>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-820428490-1148939435=:18299
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 29 May 2006, Alex Riesen wrote:

> [...]
> Reading man sshd:
> 
>      $HOME/.ssh/rc
>              If this file exists, it is run with /bin/sh after reading the
>              environment files but before starting the user's shell or com­
>              mand.  It must not produce any output on stdout; stderr must be
>              used instead.  If X11 forwarding is in use, it will receive the
>              "proto cookie" pair in its standard input (and DISPLAY in its
>              environment).  The script must call xauth(1) because sshd will
>              not run xauth automatically to add X11 cookies.
> and
> 
>      /etc/ssh/sshrc
>              Like $HOME/.ssh/rc.  This can be used to specify machine-specific
>              login-time initializations globally.  This file should be
>              writable only by root, and should be world-readable.
> 
> 
> This guaranteed to work (at least for ssh).

But not for bash. Back to square 1.

Ciao,
Dscho

---1148973799-820428490-1148939435=:18299--
