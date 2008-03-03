From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add test for cloning with "--reference" repo being a
 subset of source repo
Date: Mon, 3 Mar 2008 13:21:33 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803031318000.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <alpine.LSU.1.00.0803020743170.22527@racer.site> <alpine.LNX.1.00.0803021128510.19665@iabervon.org> <200803031004.16568.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:22:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWFIz-0003mS-B4
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 19:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbYCCSVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 13:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbYCCSVr
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 13:21:47 -0500
Received: from iabervon.org ([66.92.72.58]:47971 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbYCCSVq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 13:21:46 -0500
Received: (qmail 13998 invoked by uid 1000); 3 Mar 2008 18:21:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Mar 2008 18:21:33 -0000
In-Reply-To: <200803031004.16568.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75961>

On Mon, 3 Mar 2008, Johan Herland wrote:

> Not sure what's going on here, yet, but I thought I'd give you a heads up.

I figured it out, and pushed out a fix; it was doing everything correctly, 
but it wrote to the alternates files after the library had read that file, 
so it then didn't notice that it actually had the objects that are in the 
second alternate repository.

	-Daniel
*This .sig left intentionally blank*
