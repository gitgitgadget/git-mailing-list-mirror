From: Miles Bader <miles.bader@necel.com>
Subject: Re: stash clear, was Re: git: avoiding merges, rebasing
Date: Tue, 23 Oct 2007 17:55:02 +0900
Message-ID: <buohcki6wih.fsf@dhapc248.dev.necel.com>
References: <200709301421.52192.bruno@clisp.org>
	<200710020347.43733.bruno@clisp.org>
	<4AD64749-F4A3-4A61-B1EE-D12523293661@lrde.epita.fr>
	<200710021350.54625.bruno@clisp.org> <47023699.3080606@byu.net>
	<Pine.LNX.4.64.0710191533490.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <ebb9@byu.net>, bug-gnulib@gnu.org,
	Bruno Haible <bruno@clisp.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 10:56:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkFYA-00083l-EA
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 10:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbXJWIz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 04:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbXJWIz2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 04:55:28 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:42792 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXJWIz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 04:55:26 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9N8su9G004204;
	Tue, 23 Oct 2007 17:55:02 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Tue, 23 Oct 2007 17:55:02 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay11.aps.necel.com with ESMTP; Tue, 23 Oct 2007 17:55:02 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 70E4AB67; Tue, 23 Oct 2007 17:55:02 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <Pine.LNX.4.64.0710191533490.16728@wbgn129.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Fri\, 19 Oct 2007 15\:37\:37 +0200 \(CEST\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62123>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Instead, how about writing a stash pop?  "git stash pop [<stash>]".  It 
> would literally just call git stash apply && git reflog delete.  Should 
> not be too difficult, now that I provided "git reflog delete" ;-)
>
> Maybe even deprecating "git stash clear", or doing away with it 
> altogether.

That would match my usual usage well.

Actually, I really like the way the tla (arch) "undo" and "redo"
commands work:  "tla undo" is roughly equivalent to "git stash", but by
default chooses a name with an appended integer which is one greater
than the greatest existing "stash" (to use git terminology).  "tla redo"
by default applies the last saved value and deletes it.  So basically
push and pop.  Usually, of course, you only use one level, but on the
occasions when you want more, it feels very natural.

I dunno how this would work with stash, but push/pop functionality would
be good...

-Miles

-- 
Saa, shall we dance?  (from a dance-class advertisement)
