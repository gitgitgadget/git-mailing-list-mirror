From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 21:04:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601312104190.7301@g5.osdl.org>
References: <1138446030.9919.112.camel@evo.keithp.com>
 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <1138529385.9919.185.camel@evo.keithp.com>
 <43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
 <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org> <20060131220148.GA19411@steel.home>
 <20060201013901.GA16832@mail.com> <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
 <7v64nzollt.fsf@assigned-by-dhcp.cox.net> <20060201045337.GC25753@mail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 06:14:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4AKO-00049w-2u
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 06:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWBAFOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 00:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWBAFNi
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 00:13:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030339AbWBAFNI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 00:13:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1154lDZ028615
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 21:04:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1154kAO019472;
	Tue, 31 Jan 2006 21:04:47 -0800
To: Ray Lehtiniemi <rayl@mail.com>
In-Reply-To: <20060201045337.GC25753@mail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15386>



On Tue, 31 Jan 2006, Ray Lehtiniemi wrote:
> 
> what if the user wants to change the mode bits of an assume-unchanged
> file with the twiddled permissions, but forgets to clear the flag
> first?  seems like that change is likely to get lost, especially if the
> new mode is read-only....

Remember - git only cares about execute permissions. The write permissions 
are entirely ignored by git ..

		Linus
