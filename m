From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH v3] add --abbrev to 'git cherry'
Date: Mon, 1 Jun 2009 06:54:34 -0500
Message-ID: <20090601115434.GA25837@unpythonic.net>
References: <20090530140349.GA25265@unpythonic.net> <200905301826.11924.markus.heidelberg@web.de> <20090530165306.GA1142@unpythonic.net> <780e0a6b0905301413o2686fe34qaa076209c26c0b55@mail.gmail.com> <7v63fiyyrz.fsf@alter.siamese.dyndns.org> <20090531133804.GB16770@unpythonic.net> <7v8wkdrqys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 13:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB66E-0005cn-Aw
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 13:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbZFALyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 07:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755736AbZFALye
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 07:54:34 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:60601 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755605AbZFALyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 07:54:33 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 86C5D1146F7; Mon,  1 Jun 2009 06:54:34 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7v8wkdrqys.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120462>

On Sun, May 31, 2009 at 12:51:23PM -0700, Junio C Hamano wrote:
> Stopping here would be a good idea if "log --left-right --cherry-pick A...B"
> (perhaps with a custom --pretty option) covers what you originally wanted
> to do.

Yes, I now see that 'git log' can pretty much do what I want.  Having
learned of 'git cherry', it didn't cross my mind that 'git log' was set
up to do all 'git cherry' did and more.

> But if the reason why you wanted --abbrev was because you wanted to use it
> in your scripted Porcelain, and if the reason why you have your scripted
> Porcelain is because you wanted to add some _other_ information that "log"
> does not give you easily, perhaps it would be a good idea to share _that_.

No, this is all about displaying directly to the user (me) in a pager,
specifically about getting as much of the change summary in the first 80
columns as possible.

Jeff
