From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge no longer handles add/add
Date: Tue, 20 Nov 2007 01:15:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711200114290.27959@racer.site>
References: <46a038f90711181918s2743137amc6a827db6d1a6a0@mail.gmail.com>
 <46a038f90711181929x4bf0794eue73a5dbac8e2688a@mail.gmail.com>
 <7vtznipweu.fsf@gitster.siamese.dyndns.org>
 <46a038f90711191033s4bc5ab50kd3e4f30d6b301e43@mail.gmail.com>
 <7vabpanilk.fsf@gitster.siamese.dyndns.org> <fhspor$9ci$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 02:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuHkS-0006H4-1J
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 02:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979AbXKTBQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 20:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756699AbXKTBQG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 20:16:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:47873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756921AbXKTBQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 20:16:04 -0500
Received: (qmail invoked by alias); 20 Nov 2007 01:16:01 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp044) with SMTP; 20 Nov 2007 02:16:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IYFURJFaIMIk6oK3unRkzPWvfPw6Wc2pRBm8/4R
	RTAlARptCZu7uH
X-X-Sender: gene099@racer.site
In-Reply-To: <fhspor$9ci$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65521>

Hi,

On Mon, 19 Nov 2007, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > Exactly. ?We may keep conflict markers in the file left in the work 
> > tree to highlight which lines are unique to the side that added more 
> > (iow, one group of lines delimited by <<< === >>> is empty while the 
> > other is not) but this is currently treated as "fishy, needs human 
> > validation" to catch mismerges.
> 
> BTW can xdifflib merge use original diff3 conflict markers, i.e. <<< 
> [main] |||| [ancestor] === [branch] >>>?

There was a patch floating around which added git-diff3, just after I went 
public with my xmerge patch.  This seemed to have the code you look for.

Ciao,
Dscho

P.S.: I will refuse to reply to you in future whenever you do not Cc: me.
