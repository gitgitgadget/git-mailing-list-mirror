From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Expand explanation of the use of + in git push refspecs.
Date: Tue, 24 Feb 2009 11:54:45 -0500
Message-ID: <49A42655.40708@xiplink.com>
References: <20090219180258.2C7983360A6@rincewind> <7viqn5k8c4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 17:56:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc0a6-0004lf-N9
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 17:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbZBXQyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 11:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757268AbZBXQys
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 11:54:48 -0500
Received: from smtp242.iad.emailsrvr.com ([207.97.245.242]:45381 "EHLO
	smtp242.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbZBXQyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 11:54:47 -0500
Received: from relay14.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay14.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 19ADF23699C;
	Tue, 24 Feb 2009 11:54:45 -0500 (EST)
Received: by relay14.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CF3182369D7;
	Tue, 24 Feb 2009 11:54:44 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7viqn5k8c4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111313>

Junio C Hamano wrote:
> 
> I am of two minds with this.  The understanding of the concept of
> fast-forwardness is necessary not just to understand push but also to
> understand merge, and if glossary is missing the definition, we should add
> one there.

It's precisely because fast-forwarding and merging are so closely 
related (at least in my mind) that I felt the need to clarify push's 
documentation.  My intuition about "non-fast-forward" is in the context 
of pulling and merging.  So the current man page sounds to me like 
push's non-fast-forward is a merge, which it clearly isn't.

> What exactly happens when the <dst> is updated is the same
> regardless of ff or non-ff in that the old 40 hexdecimal object name is
> gone and replaced with the new one, and it does not feel right to say "if
> ff, we update if non-ff you can force to overwrite."  Either way, you
> overwrite and there is no trace of the old one.  So we would want to say
> something like:
> 
>     The name of the object referenced by <src> is used to update the ref
>     <dst> on the remote side, but by default this is only allowed if the
>     update is fast-forward.  By having the optional leading plus, you can
>     tell git to update the ref <dst> even when the update is not a
>     fast-forward.

My second attempt used your wording (mostly), and also emphasized the 
not-merging aspect.

> Please don't wrap a full paragraph, only to change a few sentences.
> AsciiDoc wraps lines for output just fine; it took me a few extra minutes
> to make sure there is no other changes.

Whoops, sorry!  Will avoid reflowing in the future.

		M.
