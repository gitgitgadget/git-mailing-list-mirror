From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: git clone does not work with GIT_OBJECT_DIRECTORY set
Date: Tue, 7 Mar 2006 11:13:28 -0500
Message-ID: <20060307161328.GA5410@kvack.org>
References: <20060306012115.GG20768@kvack.org> <7vmzg4cq6y.fsf@assigned-by-dhcp.cox.net> <20060306013854.GH20768@kvack.org> <7vu0aa4vj4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 17:19:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGete-0006Ad-LN
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 17:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWCGQSr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 11:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWCGQSr
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 11:18:47 -0500
Received: from kanga.kvack.org ([66.96.29.28]:4831 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751221AbWCGQSr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 11:18:47 -0500
Received: (from localhost user: 'bcrl' uid#63042 fake: STDIN
	(bcrl@kanga.kvack.org)) by kvack.org id <S26533AbWCGQN2>;
	Tue, 7 Mar 2006 11:13:28 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0aa4vj4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17341>

On Mon, Mar 06, 2006 at 10:29:51PM -0800, Junio C Hamano wrote:
> I think the recommended way these days to set up multiple
> repositories that work on related projects is to set up a single
> clone from external source (e.g. linux-2.6.git), and make a set
> of local "-l -s" clones out of it, and then fetch forked
> upstreams into them.  It would go something like this:

I had been doing that, but it's gotten too painful to keep everything in 
sync.  Sigh.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
