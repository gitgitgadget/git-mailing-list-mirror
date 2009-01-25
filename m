From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/10] run test suite without dashed git-commands in
 PATH
Date: Sun, 25 Jan 2009 02:59:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901250255250.14855@racer>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-8-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-9-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Sun Jan 25 03:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQuIq-0001qu-AC
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 03:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbZAYB71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 20:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbZAYB70
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 20:59:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:52942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754483AbZAYB7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 20:59:25 -0500
Received: (qmail invoked by alias); 25 Jan 2009 01:59:23 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp016) with SMTP; 25 Jan 2009 02:59:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18V2d1J1oUVaaUztLnDcY0j22U2DPfYdMmdf6fBia
	XAtyVUfaPUWFrN
X-X-Sender: gene099@racer
In-Reply-To: <1232840601-24696-9-git-send-email-mmogilvi_git@miniinfo.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107034>

Hi,

On Sat, 24 Jan 2009, Matthew Ogilvie wrote:

>  .gitignore          |    1 +
>  Makefile            |   42 +++++++++++++++++++++++++++++++-----------
>  t/test-lib.sh       |   14 +++++++++++++-
>  test-bin-wrapper.sh |   12 ++++++++++++
>  4 files changed, 57 insertions(+), 12 deletions(-)
>  create mode 100644 test-bin-wrapper.sh

I am strongly opposed to a patch this big, just for something as 3rd class 
as CVS server faking.  We already have a big fallout from all that bending 
over for Windows support, and I do not like it at all.

Note: I do not even have to look further than the diffstat to see that it 
is wrong.

The point is: if cvsserver wants to pretend that it is in a fake bin where 
almost none of the other Git programs are, fine, let's do that _in the 
test for cvsserver_.

Let's not fsck up the whole test suite just for one user.

Ciao,
Dscho
