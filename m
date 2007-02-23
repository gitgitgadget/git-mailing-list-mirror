From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 23 Feb 2007 15:48:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702231258400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net> <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 15:48:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKbix-0007qi-Ha
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 15:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbXBWOsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 09:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXBWOsg
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 09:48:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:42967 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932440AbXBWOsf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 09:48:35 -0500
Received: (qmail invoked by alias); 23 Feb 2007 14:48:33 -0000
X-Provags-ID: V01U2FsdGVkX18B0XY9VAIBtbCoUTKOuicX2356/p1BbCAf1/zZGc
	iHhw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40443>

Hi,

On Fri, 23 Feb 2007, Junio C Hamano wrote:

> * js/fetch-progress (Tue Feb 20 03:01:44 2007 +0100) 1 commit
>  + fetch & clone: do not output progress when not on a tty
> 
> I'll see it in action from my cron job.

That's how I tried to test it. It does not work. The problem is that the 
remote git-upload-pack is unlikely to understand the option 
"--no-progress".

So maybe we have to make this a new pack protocol option?

Ciao,
Dscho
