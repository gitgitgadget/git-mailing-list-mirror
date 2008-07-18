From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Addremove equivalent [was: Re: Considering teaching plumbing to
 users harmful]
Date: Sat, 19 Jul 2008 01:03:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807190102390.3064@eeepc-johanness>
References: <alpine.DEB.1.00.0807161804400.8950@racer>  <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>  <20080717155538.GE11759@fieldses.org>  <alpine.DEB.1.00.0807171915420.8986@racer>  <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807171940160.8986@racer>
  <48806897.1080404@fastmail.fm> <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 01:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJyzC-00007S-73
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 01:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbYGRXCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 19:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755806AbYGRXCh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 19:02:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:40081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753101AbYGRXCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 19:02:36 -0400
Received: (qmail invoked by alias); 18 Jul 2008 23:02:35 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp031) with SMTP; 19 Jul 2008 01:02:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zpOYIppjzYE/9W3baoqJxBgJju4BqAgSVNc2wZB
	8lKv7RfQ0AAvve
X-X-Sender: user@eeepc-johanness
In-Reply-To: <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89085>

Hi,

On Fri, 18 Jul 2008, Jay Soffian wrote:

> On Fri, Jul 18, 2008 at 5:55 AM, Michael J Gruber
> <michaeljgruber+gmane@fastmail.fm> wrote:
> > sometimes I find my self wanting an "addremove", such as in a situation like
> 
> I have the following aliased as "addremove":
> 
>   git ls-files -d -m -o -z --exclude-standard \
>   | xargs -0 git update-index --add --remove

But that is everything, _except_ easy for newbies!!!

I still suggest "git add -u && git add .".

Hth,
Dscho
