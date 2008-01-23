From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 12:24:13 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801231221120.5731@racer.site>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <7vabmxqnz8.fsf@gitster.siamese.dyndns.org> <7v63xlqnd0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 13:24:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHeez-00077M-63
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 13:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbYAWMYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 07:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYAWMYX
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 07:24:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:40542 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751357AbYAWMYX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 07:24:23 -0500
Received: (qmail invoked by alias); 23 Jan 2008 12:24:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 23 Jan 2008 13:24:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9UQU1Y6m9sY5EtZcSx8/VbRYgz9Gwym2PIsatvv
	xDa3eH5tUePUkp
X-X-Sender: gene099@racer.site
In-Reply-To: <7v63xlqnd0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71533>

Hi,

On Tue, 22 Jan 2008, Junio C Hamano wrote:

>  * We certainly do not necessarily want to store this in the
>    index right now.  The hash algorithms would be improved from
>    the version you are almost ashamed of ;-).  That sounds as if
>    I am retrating the other half, but not quite.
> 
>  * Once we have a mechanism to detect that the extension section
>    stores a precomputed hash that was done with a different
>    algorithm and ignore it (and recompute afresh when needed),
>    then we can afford to put a more elaborate hashing algorithm,
>    slightly loosening one of your "Guiding principles", and keep
>    the result in the generated index to be reused by the next
>    user.  So that is why I am retracting only half of the
>    suggestion to save it in the extension section (which in turn
>    is a half of my suggestion).

Both issues (and the config variable issue Linus raised) are easily helped 
with: store not only the hashmap in the extension, but also an identifier 
for the hash method used.

Then you can improve on the hash function all you like, and add the config 
variable dependent choice of the hashing everybody seems to want all of a 
sudden, as long as you change the method identifier, too.

Ciao,
Dscho
