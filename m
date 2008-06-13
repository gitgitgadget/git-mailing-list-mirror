From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Added mergetool.kdiff3.doubledash config option
Date: Fri, 13 Jun 2008 10:58:03 -0400
Message-ID: <20080613145803.GE24675@mit.edu>
References: <7vve0ez8z3.fsf@gitster.siamese.dyndns.org> <911589C97062424796D53B625CEC0025E46159@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Patrick.Higgins@cexp.com
X-From: git-owner@vger.kernel.org Fri Jun 13 16:59:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7AkG-0003zS-Rt
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbYFMO6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbYFMO6W
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:58:22 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:47080 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755343AbYFMO6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:58:22 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1K7Aj9-0007tg-5j; Fri, 13 Jun 2008 10:58:07 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1K7Aj5-00062P-UH; Fri, 13 Jun 2008 10:58:03 -0400
Content-Disposition: inline
In-Reply-To: <911589C97062424796D53B625CEC0025E46159@USCOBRMFA-SE-70.northamerica.cexp.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84889>

On Thu, Jun 12, 2008 at 04:44:03PM -0600, Patrick.Higgins@cexp.com wrote:
> I have found the following to be a way to distinguish the two
> versions based solely on exit status. The broken one exits with 255.
> 
> kdiff3 --auto -o /dev/null -- /dev/null /dev/null
> 
> I'll work up another patch that uses this. This check adds about
> 0.5s overhead. That seems a little high to me, but given that
> mergetool is interactive, I guess that could be acceptable.

Hmm, do we have a policy about whether or not it is acceptable to
modify .gitconfig behind the user's back?  It would be nice if the
check would be done once and then the result gets cached.  So if not
in .gitconfig, maybe somewhere else.

      	       	    	     	      - Ted
