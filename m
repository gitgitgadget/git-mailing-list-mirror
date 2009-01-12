From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git/webdav is refusing to authenticate properly.
Date: Tue, 13 Jan 2009 00:04:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901130003490.3586@pacific.mpi-cbg.de>
References: <137c54e10901121354l284f11ag675abb003fc83e93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Spierenburg <ionlyusethisaddressforlists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMVqS-0002qR-U8
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 00:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbZALXD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 18:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbZALXD4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 18:03:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:39938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753060AbZALXDz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 18:03:55 -0500
Received: (qmail invoked by alias); 12 Jan 2009 23:03:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 13 Jan 2009 00:03:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BSfEPzP7BATgXOFJkQImdQmwBI3WtNKLh/WuP2y
	EzecksTFuwbPQh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <137c54e10901121354l284f11ag675abb003fc83e93@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105412>

Hi,

On Mon, 12 Jan 2009, Peter Spierenburg wrote:

> I'm trying to push a local git repository to a remote site using WebDAV, 
> but it is eating my lunch.

Please see Documentation/howto/setup-git-server-over-http.txt.

In short, http-push does not ask for a password interactively, but you 
have to use .netrc.

Hth,
Dscho
