From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Annotating patches inside diff
Date: Wed, 10 Dec 2008 17:58:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812101755480.25069@eeepc-johanness>
References: <200812101445.48034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 17:58:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LASO6-0001a4-Px
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 17:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbYLJQ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 11:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbYLJQ45
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 11:56:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:60777 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753567AbYLJQ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 11:56:56 -0500
Received: (qmail invoked by alias); 10 Dec 2008 16:56:54 -0000
Received: from ini-firewall.unizh.ch (EHLO eeepc-johanness.st-andrews.ac.uk) [130.60.5.218]
  by mail.gmx.net (mp007) with SMTP; 10 Dec 2008 17:56:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HMY8FLWuH9SInrCaJO0MJzJTDE0aR/6D0cNsa18
	rLBMZRDW4WJOsb
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200812101445.48034.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102697>

Hi,

On Wed, 10 Dec 2008, Jakub Narebski wrote:

> I remember that long time ago on git mailing list there was discussed 
> extending git-apply and friends (including git-am), to be able to 
> ignore lines in patches with selected special prefix, different from 
> '@' for chunks headers, ' ' for context, '+'/'-' for added/deleted 
> lines.  IIRC it was chose '|' for this purpose.
> 
> This way you could annotate patch
> 
> @@ -4667,7 +4667,6 @@ HTML
>                                   hash_base => $parent_commit);
>                 print "<td class=\"linenr\">";
>                 print $cgi->a({ -href => "$blamed#l$orig_lineno",
> | moved to <tr>
> -                               -id => "l$lineno",
>                                 -class => "linenr" },
>                               esc_html($lineno));
>                 print "</td>";
> 
> 
> Was it accepted or dropped, or is this feature present but not 
> documented?

As I said on IRC, I think that if you are too good in the hiding-comments 
business, you can just spare the time to write them, 'cause nobody will 
find them.

IOW such a comment needs to go either into the commit message (if it is an 
important API change), so that people who do not remember discussions on 
the mailing list still have a chance to find the comment, or between the 
message and the diffstat (if it is less important).

Ciao,
Dscho
