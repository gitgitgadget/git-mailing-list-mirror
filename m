From: Theodore Tso <tytso@mit.edu>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 07:27:09 -0400
Message-ID: <20080616112709.GG12260@mit.edu>
References: <20080616110113.GA22945@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 16 13:28:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Csu-0003wG-Ur
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 13:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYFPL1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 07:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbYFPL1b
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 07:27:31 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:54209 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751958AbYFPL1b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 07:27:31 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1K8Cre-0000Qh-Hv; Mon, 16 Jun 2008 07:27:10 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1K8Crd-0008S0-PF; Mon, 16 Jun 2008 07:27:09 -0400
Content-Disposition: inline
In-Reply-To: <20080616110113.GA22945@elte.hu>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85180>

On Mon, Jun 16, 2008 at 01:01:13PM +0200, Ingo Molnar wrote:
>    ( Also, it's a GPL nitpicky issue: the conflict resolution database 
>      can be argued to be part of "source code" and as such it should be 
>      shared with everyone who asks. With trivial merges the data is
>      probably not copyrightable hence probably falls outside the scope 
>      of the GPL, but with a complex topic tree like -tip with dozens of 
>      conflict resolutions, the boundary is perhaps more blurred. )

For a more complex merge resolution, granted that it rises to the
level of being "copyrightable", but I think it would be a huge stretch
to call the rr-cache the "preferred form for modifications"!  :-)

   	    	     	 	    	     - Ted
