From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bpush: Pushing to a bundle
Date: Tue, 9 Dec 2008 11:07:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812091100470.2916@eeepc-johanness>
References: <adf1fd3d0812090149m158fcb9as15bacce58c61a1a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-1391502559-1228817258=:2916"
Cc: git list <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9zVE-0007lz-US
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbYLIKGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 05:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYLIKGX
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:06:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:41323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751733AbYLIKGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 05:06:22 -0500
Received: (qmail invoked by alias); 09 Dec 2008 10:06:19 -0000
Received: from ini-firewall.unizh.ch (EHLO eeepc-johanness.st-andrews.ac.uk) [130.60.5.218]
  by mail.gmx.net (mp016) with SMTP; 09 Dec 2008 11:06:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AZW8d9m2AbesUUPz1gVTwY1yQdg43cmS4dArJOG
	s5QOqqmYHqinbO
X-X-Sender: user@eeepc-johanness
In-Reply-To: <adf1fd3d0812090149m158fcb9as15bacce58c61a1a3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102619>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-1391502559-1228817258=:2916
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 9 Dec 2008, Santi Béjar wrote:

> The basic idea is:
> 
> - Easily create bundles with the current branch.
> - Be able to push to defined bundles in remote.<remote>.url
> - Only add new objects by default (do not lose objects)

That is probably not what people need.  Usually, when bundles are sent 
around, you need _incremental_ bundles.  IOW if you already have a bundle, 
you want to create a new bundle that contains everything that is new, _in 
addition_ to the existing bundle.

> while [ $# != 0 ] ; do

Heh, I did not realize just how _used_ I got to the conventions in Git's 
shell programming, until I thought "Should this not use 'test' instead 
of brackets?"

> while [ $# != 0 ] ; do
>     refs="$refs$LF$1" && shift
> done

That is equivalent to refs="$*", no?

Anyway, I found reading your shell script quite hard, because of excessive 
use of brackets and single line && chains (which lack proper error 
handling, BTW).

Ciao,
Dscho

--658432-1391502559-1228817258=:2916--
