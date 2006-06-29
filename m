From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Cache negative delta pairs
Date: Fri, 30 Jun 2006 00:31:59 +0200
Organization: At home
Message-ID: <e81kcm$p3c$1@sea.gmane.org>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 30 00:32:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw53R-0001Nd-5V
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 00:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWF2WcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 18:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933065AbWF2WcC
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 18:32:02 -0400
Received: from main.gmane.org ([80.91.229.2]:34012 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932420AbWF2WcA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 18:32:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fw53G-0001Ly-T9
	for git@vger.kernel.org; Fri, 30 Jun 2006 00:31:58 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 00:31:58 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 00:31:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22922>

Junio C Hamano wrote:

> [...] For example, we currently do
> not delta OpenOffice documents (*.odt, *.odp, etc) very well.
> If one has a repository that tracks the history of "file.odp",
> we know each revision of "file.odp" would not delta against any
> other version anyway, and could skip attempting to deltify them.

Perhaps we should steal Mercurial idea of EncodeDecodeFilter, and store
OpenOffice documents, Mozilla extensions, Java packages in object store as
uncompressed archive, and checkout them to working area in original format.
All diff should be of course done on in-repository (after-filter) format.

The original example at 
  http://www.selenic.com/mercurial/wiki/index.cgi/EncodeDecodeFilter
talks about archives (zip files) and unix2dos endline convention conversion.

Perhaps for OpenOffice and Mozilla we would need to use [external] XML-aware
diff, too...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
