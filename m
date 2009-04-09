From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: legend on top-right pane in 'git gui'
Date: Thu, 9 Apr 2009 03:31:47 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngtqr13.566.sitaramc@sitaramc.homelinux.net>
References: <slrngt4h04.q0l.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 05:34:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrl1j-0007rR-4X
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 05:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757731AbZDIDcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 23:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756891AbZDIDcA
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 23:32:00 -0400
Received: from main.gmane.org ([80.91.229.2]:48086 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756867AbZDIDb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 23:31:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lrkzd-000269-O5
	for git@vger.kernel.org; Thu, 09 Apr 2009 03:31:57 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 03:31:57 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 03:31:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116138>

Hi guys,

Can someone at least tell me "Sita, you're wrong/this is a
stupid question/this is perfectly correct behaviour/whatever"?  :-)

I won't even ask why, I promise :-)

Regards,

Sitaram

On 2009-03-31, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Hello,
>
> 'git gui' has a minor issue with the legend on the main code
> panel (yellow bar, top right pane).
>
> When you click on a file in the top left pane, the yellow
> bar becomes "untracked, not staged".  When you click on a
> file in the bottom left pane, it becomes "staged for
> commit".  So far so good.
>
> But when you take a file and (un)stage a part of it, then
> the text on the yellow bar changes to "Portions staged for
> commit", regardless of whether you clicked on the filename
> in the top left (unstaged) or bottom left (staged) pane.
>
> One of the two texts should be different, but what?  I was
> thinking, just add "(partial)" to the normal text, like:
>
>     "untracked, not staged (partial)"
>     "staged for commit (partial)"
>
> I also tried to see if I could patch it, but it's not just a
> matter of changing the text somewhere, and I don't know tcl.
> However, if someone can give me a pointer I could still
> try...
>
> Any thoughts?
>
