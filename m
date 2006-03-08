From: Christopher Faylor <me@cgf.cx>
Subject: Re: Update hook in Cygwin
Date: Wed, 8 Mar 2006 10:54:00 -0500
Message-ID: <20060308155400.GE11231@trixie.casa.cgf.cx>
References: <ad8ce5c20603080416g5ed6d77el@mail.gmail.com> <440EDDE4.9070405@op5.se> <20060308144413.GA516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 08 16:57:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH0zN-00021m-W8
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 16:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWCHPyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 10:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWCHPyE
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 10:54:04 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:50565 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751086AbWCHPyD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 10:54:03 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id C6B4513C41B; Wed,  8 Mar 2006 10:54:00 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>, Niklas H?glund <nhoglund@gmail.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060308144413.GA516@spearce.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17375>

On Wed, Mar 08, 2006 at 09:44:13AM -0500, Shawn Pearce wrote:
>BTW: chmod a-x .git/hooks/* also works as the Cygwin unixy permission
>layer will remember the change.

Using "chmod a-x" should work like linux as long as you're using an NTFS
filesystem and have not specifically turned off Cygwin's handling of this
kind of thing with the CYGWIN=nontsec environment variable.

i.e., it should work in most cases on W2K+

cgf
