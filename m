From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Thu, 3 Jan 2008 13:43:59 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801031342200.2811@woody.linux-foundation.org>
References: <477822C3.9060002@gbarbier.org> <alpine.LNX.1.00.0712302145500.13593@iabervon.org> <47791F90.8030302@pobox.com> <20080101113301.GC9214@efreet.light.src> <477A26FD.7020408@gbarbier.org> <m3myrpo1p0.fsf@roke.D-201> <20080101202352.GA4295@efreet.light.src>
 <477D3401.2010005@gbarbier.org> <20080103211521.GA4225@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:45:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAXsY-0000fW-KX
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 22:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbYACVpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 16:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbYACVpE
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 16:45:04 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41028 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752036AbYACVpD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2008 16:45:03 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m03Lhxre000547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Jan 2008 13:44:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m03Lhx6U023886;
	Thu, 3 Jan 2008 13:43:59 -0800
In-Reply-To: <20080103211521.GA4225@efreet.light.src>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.683 required=5 tests=AWL,BAYES_00,TW_BZ
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69539>



On Thu, 3 Jan 2008, Jan Hudec wrote:
> 
> That's not quite true -- bzr has both dumb (walker over plain HTTP) and smart
> (CGI) methods. But their CGI is really just tunelling their custom protocol
> over HTTP and that protocol will not be anywhere near what we want for git
> because of vastly different design of the storage.

Well, tunnelling the native git protocol is *exactly* what you'd want to 
do with some git CGI thing. So no, I don't think the actual stuff you 
tunnel would have any relationship, but the actual code to set up a tunnel 
and making it all look like some fake html sequence might be something 
that can be used as a base.

		Linus
