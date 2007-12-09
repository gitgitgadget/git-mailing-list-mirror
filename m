From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Where has "git ls-remote" reference pattern matching gone?
Date: Sat, 8 Dec 2007 21:20:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712082048570.5349@iabervon.org>
References: <4E5E5B1E-A303-45C9-9944-57D54FD50F80@orakel.ntnu.no>
 <7vve78tzw1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 03:21:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Bn7-0004B2-EQ
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 03:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbXLICUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 21:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbXLICUw
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 21:20:52 -0500
Received: from iabervon.org ([66.92.72.58]:49060 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbXLICUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 21:20:52 -0500
Received: (qmail 14598 invoked by uid 1000); 9 Dec 2007 02:20:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Dec 2007 02:20:50 -0000
In-Reply-To: <7vve78tzw1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67585>

On Sat, 8 Dec 2007, Junio C Hamano wrote:

> Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:
> 
> > ls-remote was recently made a builtin; was reference filtering
> > deliberately removed, or was it just lost in translation from the
> > shell script?
> 
> I suspect that to be the case.  Daniel, I think this is yours.

Ah, sure enough. I didn't see that feature there, I guess. Am I right that 
it's supposed to have "git ls-remote origin db/*" return refs of the 
form "*/db/*", interpreted as for globs?

Eyvind: can I get a test case? I haven't ever used this feature, and I'm 
not sure I'll implement it correctly.

	-Daniel
*This .sig left intentionally blank*
