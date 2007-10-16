From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] tail -n not supported in all OSs
Date: Tue, 16 Oct 2007 22:37:42 +0200
Message-ID: <878x62dcdl.fsf@mid.deneb.enyo.de>
References: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 22:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhtAr-0000cn-Vc
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 22:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760411AbXJPUhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 16:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbXJPUhr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 16:37:47 -0400
Received: from mail.enyo.de ([212.9.189.167]:4584 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965337AbXJPUhq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 16:37:46 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IhtAd-0001pK-Vz
	for git@vger.kernel.org; Tue, 16 Oct 2007 22:37:44 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.68)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IhtAc-00066V-Po
	for git@vger.kernel.org; Tue, 16 Oct 2007 22:37:42 +0200
In-Reply-To: <1192553837-18302-1-git-send-email-jari.aalto@cante.net> (Jari
	Aalto's message of "Tue, 16 Oct 2007 19:57:14 +0300")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61252>

* Jari Aalto:

> $ uname -a
> SunOS host 5.9 Generic_118558-35 sun4u sparc SUNW,Serverblade1
>
> $ echo | tail -n 1
>
> usage: tail [+/-[n][lbc][f]] [file]
>        tail [+/-[n][l][r|f]] [file]                     

What about /usr/xpg4/bin/tail?  Why aren't you using that?
