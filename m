From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH] checkout -d: explicitly detach HEAD even when switching to the tip of a branch
Date: Sat, 31 Mar 2007 16:55:17 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703311455.l2VEtHO5021300@localhost.localdomain>
References: <7vr6r879zp.fsf@assigned-by-dhcp.cox.net> <euk8ps$vu1$1@sea.gmane.org>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYP4J-0002S0-Tv
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 18:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbXDBQHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933215AbXDBQHj
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 12:07:39 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:60076 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932508AbXDBQHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 12:07:39 -0400
Received: from zogzog.home (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 8F34838440;
	Mon,  2 Apr 2007 18:07:37 +0200 (CEST)
Received: from zogzog.home (IDENT:25@localhost [127.0.0.1])
	by zogzog.home (8.13.8/8.13.8) with ESMTP id l32F4VjS001331;
	Mon, 2 Apr 2007 17:04:34 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2VEtHO5021300;
	Sat, 31 Mar 2007 16:55:17 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <euk8ps$vu1$1@sea.gmane.org> (jnareb@gmail.com)
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43603>


   > You cannot currently checkout the tip of an existing branch
   > without moving to the branch.
   > 
   > This allows you to detach your HEAD and place it at such a
   > commit, with:
   > 
   >     $ git checkout -d master

   What about

	 $ git checkout master^0

   trick to force detaching?

I love this idea.

Xavier
