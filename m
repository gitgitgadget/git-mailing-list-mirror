From: David Kastrup <dak@gnu.org>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Mon, 27 Aug 2007 17:48:34 +0200
Message-ID: <86odgtou5p.fsf@lola.quinscape.zz>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com> <7v1wdqud0z.fsf@gitster.siamese.dyndns.org> <loom.20070827T172150-191@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 17:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgpl-0007SP-Ew
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbXH0Psr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756613AbXH0Psr
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:48:47 -0400
Received: from main.gmane.org ([80.91.229.2]:40066 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732AbXH0Psp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:48:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPgpX-0007gV-Th
	for git@vger.kernel.org; Mon, 27 Aug 2007 17:48:44 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:48:43 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:48:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:2kvrkbksbYXS8YIAQes8wCKsUAg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56854>

Sergio Callegari <scallegari@arces.unibo.it> writes:

> Couldn't all this directory/ownership/permission tracing be easily
> done by using hooks?  E.g. Having a pre-status and pre-commit hook
> one could fire up a program/script to collect all the extra info he
> wants to trace and store it somewhere (typically in some traced
> file).  The other way round one could have a post-checkout hook and
> he could arrange it to fire up some program to look into the
> extra-info file to set up all the meta-data he wants.
>
> This would be very flexible and would permit to manage absolutely
> /any/ kind of the metadata leaving absolute freedom about how to do
> so.
>
> Am I missing something here?

Merging.

-- 
David Kastrup
