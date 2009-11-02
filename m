From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: Headless tags don't have a follows or precedes?
Date: Mon, 2 Nov 2009 05:16:28 -0800 (PST)
Message-ID: <1257167788750-3931717.post@n2.nabble.com>
References: <1257067898626-3926483.post@n2.nabble.com> <20091102130919.GB27126@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 14:16:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4wlv-0002Gy-KL
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 14:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbZKBNQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 08:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbZKBNQX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 08:16:23 -0500
Received: from kuber.nabble.com ([216.139.236.158]:50304 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbZKBNQX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 08:16:23 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N4wlo-0001Ow-ON
	for git@vger.kernel.org; Mon, 02 Nov 2009 05:16:28 -0800
In-Reply-To: <20091102130919.GB27126@dpotapov.dyndns.org>
X-Nabble-From: Tim Mazid <timmazid@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131907>



Dmitry Potapov wrote:
> 
> I have never heard tag being described as headless... A tag is just a
> pointer on some commit (annotated tag contains additional information
> such as creater, data, message), in any case, it has no direct relation
> to any branch.
> 
> Tags do not store any precedes or follows information, no matter how you
> created them, but visualization tools can look at the tree and display
> what was before some commit and what was after it. Without seeing your
> tree, it is impossible to tell whether gitk (or what you use?) displayed
> that correctly or not.
> 
Well, not the tag itself, but the commit the tags points to. Same thing.
Like you're always bothered to say "the commit that the tag v1 points to"
rather than "the v1 tag".
Also, see my post above.
-- 
View this message in context: http://n2.nabble.com/Headless-tags-don-t-have-a-follows-or-precedes-tp3926483p3931717.html
Sent from the git mailing list archive at Nabble.com.
