From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-push hook to update remote working copy safely
Date: Fri, 23 Feb 2007 17:40:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702231737300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1172220709.10221.1176113191@webmail.messagingengine.com>  
 <7v649t5ebq.fsf@assigned-by-dhcp.cox.net> <1172248500.32514.1176151445@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Sam Watkins <swatkins@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Feb 23 17:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKdSs-0002lW-CM
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 17:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbXBWQkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 11:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbXBWQkG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 11:40:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:42256 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965134AbXBWQkE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 11:40:04 -0500
Received: (qmail invoked by alias); 23 Feb 2007 16:40:03 -0000
X-Provags-ID: V01U2FsdGVkX1/e7ktCXnTeiqi4z+ThT2goEQc3MQo3PPlUqky8ar
	S2Xw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1172248500.32514.1176151445@webmail.messagingengine.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40450>

Hi,

On Sat, 24 Feb 2007, Sam Watkins wrote:

> it should merge the changes as if I'd run git-pull on the remote box, 
> and handle conflicts in the same way.

But that leaves conflicts in the working directory! You _have_ to resolve 
them (or reset) before proceding.

> I don't understand git very well yet but that will work I think.  I 
> thought "push" would be symmetrical to "pull" more or less, maybe it is 
> symmetrical to "fetch" ?

Yes, that was the idea of the naming.

> The app "arcs" we are writing, it is peer to peer, not necessarily using 
> a central repository, it commits pulls and pushes all changes made to 
> working copies automatically or when asked to.  currently I'm 
> implementing push as a remote pull because of this problem, but that 
> can't connect back through firewalls and suchlike.

Don't you have any user interaction? I.e. if the remote working directory 
is only ever changed by your hook, you can use what Junio sent. It is even 
overkill for that purpose.

Hth,
Dscho
