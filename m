From: Alon Ziv <alonz@nolaviz.org>
Subject: Re: Initial support for cloning submodules
Date: Sun, 06 May 2007 07:13:18 +0300
Message-ID: <1178424798.12963.9.camel@bruno.nolaviz.org>
References: <11782762032207-git-send-email-skimo@liacs.nl>
 <7vfy6cqk0w.fsf@assigned-by-dhcp.cox.net>
 <20070505081404.GR955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun May 06 06:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkY7v-0005zF-DM
	for gcvg-git@gmane.org; Sun, 06 May 2007 06:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXEFEN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 00:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbXEFEN2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 00:13:28 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:40294 "EHLO
	mxout4.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbXEFEN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 00:13:27 -0400
Received: from mail.nolaviz.org ([194.90.198.244]) by mxout4.netvision.net.il
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTP id <0JHL0064QQEB9D50@mxout4.netvision.net.il> for
 git@vger.kernel.org; Sun, 06 May 2007 07:13:23 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])	by mail.nolaviz.org (Postfix)
 with ESMTP id D536920043A0; Sun, 06 May 2007 07:13:22 +0300 (IDT)
Received: from mail.nolaviz.org ([127.0.0.1])
	by localhost (gardener.nolaviz.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17639-04; Sun, 06 May 2007 07:13:19 +0300 (IDT)
Received: from [192.168.0.17] (bruno.nolaviz.org [192.168.0.17])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)	by mail.nolaviz.org (Postfix)
 with ESMTP id 203F420040E5; Sun, 06 May 2007 07:13:19 +0300 (IDT)
In-reply-to: <20070505081404.GR955MdfPADPa@greensroom.kotnet.org>
X-Mailer: Evolution 2.10.1
X-Virus-Scanned: Debian amavisd-new at nolaviz.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46295>

On Sat, 2007-05-05 at 10:14 +0200, Sven Verdoolaege wrote:
> We could easily have dump-config only dump a predefined "known safe"
> set of config options, although that would mean you have to upgrade
> the server side each time you add a new dumpable config option.
> Or we could do the preselection only when called from git-daemon.
> 

Or we could have the set of dumpable options itself in the config file;
a bit more cumbersome, but leaves all flexibility (including the
shoot-yourself-in-the-foot kind) in the hands of the users :)

	-az
