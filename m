From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: git clone does not work with GIT_OBJECT_DIRECTORY set
Date: Sun, 5 Mar 2006 20:38:54 -0500
Message-ID: <20060306013854.GH20768@kvack.org>
References: <20060306012115.GG20768@kvack.org> <7vmzg4cq6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 02:44:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG4lj-0000iu-TW
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 02:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWCFBoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 20:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWCFBoN
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 20:44:13 -0500
Received: from kanga.kvack.org ([66.96.29.28]:8358 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751101AbWCFBoM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 20:44:12 -0500
Received: (from localhost user: 'bcrl' uid#63042 fake: STDIN
	(bcrl@kanga.kvack.org)) by kvack.org id <S26570AbWCFBiy>;
	Sun, 5 Mar 2006 20:38:54 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzg4cq6y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17262>

On Sun, Mar 05, 2006 at 05:33:25PM -0800, Junio C Hamano wrote:
> Please try it without GIT_OBJECT_DIRECTORY and see it works
> correctly (I think it should).  If that is the case, maybe
> git-clone should explicitly unset GIT_OBJECT_DIRECTORY.

Nope.  There is no .git/objects directory, so how would it be able to 
find the objects?

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
