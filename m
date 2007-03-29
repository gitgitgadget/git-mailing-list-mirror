From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH] checkout -d: explicitly detach HEAD even when switching to the tip of a branch
Date: Thu, 29 Mar 2007 12:44:42 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703291044.l2TAig5M021533@localhost.localdomain>
References: <7vr6r879zp.fsf@assigned-by-dhcp.cox.net>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 18:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWxOA-0003kA-VJ
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 18:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbXC2QWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 12:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932991AbXC2QWM
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 12:22:12 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:44602 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932411AbXC2QWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 12:22:11 -0400
Received: from zogzog.home (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 62BCF38463;
	Thu, 29 Mar 2007 18:22:09 +0200 (CEST)
Received: from zogzog.home (IDENT:25@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l2TFJEmG001355;
	Thu, 29 Mar 2007 17:19:14 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2TAig5M021533;
	Thu, 29 Mar 2007 12:44:42 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <7vr6r879zp.fsf@assigned-by-dhcp.cox.net> (junkio@cox.net)
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43454>

   This allows you to detach your HEAD and place it at such a

       $ git checkout -d master

Hum, excuse my ignorance, but can you explain what exactly could
be a use case of this ?

Xavier
