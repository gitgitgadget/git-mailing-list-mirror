From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Sun, 11 Sep 2005 20:39:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509112038020.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org> <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
 <52irx7cnw5.fsf@cisco.com> <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
 <Pine.LNX.4.58.0509111431400.3242@g5.osdl.org> <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 05:41:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEfAr-0006Dh-Vd
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 05:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVILDkB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 23:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVILDkB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 23:40:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbVILDkA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 23:40:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8C3dlBo014963
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 20:39:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8C3dk59003538;
	Sun, 11 Sep 2005 20:39:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8365>



On Sun, 11 Sep 2005, Junio C Hamano wrote:
> 
> For kernel.org, you could say '/pub/scm/blah' in your alternates
> and expect it to work, only because http://kernel.org/pub
> hierarchy happens to match the absolute path /pub on the
> filesystem, but for most people's default HTTP server
> installation, they would need to say /var/www/scm/blah to have
> alternate work locally, but somebody has to know that the named
> directory is served as http://machine.xz/pub/scm/blah somewhere.

Yes. We should probably have some well-defined meaning for relative paths
in there regardless (eg just define that they are always relative to the
main GIT_OBJECT_DIRECTORY or something).

That would also allow mirrors to mirror the git archives in different 
places, without upsetting the result (as long as they are mirrored 
together).

		Linus
