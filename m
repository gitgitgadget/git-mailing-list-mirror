From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Documentation/git-merge: at least one <remote> not two
Date: Fri, 2 Jan 2009 00:25:34 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnglqnnu.tht.sitaramc@sitaramc.homelinux.net>
References: <87d4f6vph7.fsf@jidanni.org>
 <7vk59ehg7l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 01:28:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIXtq-00052v-GO
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 01:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbZABAZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 19:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbZABAZ4
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 19:25:56 -0500
Received: from main.gmane.org ([80.91.229.2]:41027 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbZABAZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 19:25:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LIXrK-0006nl-4H
	for git@vger.kernel.org; Fri, 02 Jan 2009 00:25:50 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 00:25:50 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 00:25:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104349>

On 2009-01-01, Junio C Hamano <gitster@pobox.com> wrote:
>  * Is it a good idea to standardize on "one or more" semantics?  I suspect
>    we would rather want to standardize on "zero or more", because it would
>    be more natural to say:
>
>     $ git diff [--] <paths>...
>
>    to mean "You can give paths if you want to but you do not have to".  If
>    ellipses meant "one or more", you have to say this instead:
>
>     $ git diff [--] [<paths>...]

For what it is worth, I have always understood "..." to mean
"more of the preceding", meaning "one or more".  That is
your first example above.

Zero or more is your second syntax above, because the whole
thing is in brackets, and hence completely optional.

In regex terms (to me anyway):

a?      ==  [a]
a+      ==  a...
a*      ==  [a...]
