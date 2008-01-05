From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 5 Jan 2008 16:04:03 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801051351380.10101@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
 <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <7vzlwps8zf.fsf@gitster.siamese.dyndns.org> <7vejdy4yuw.fsf@gitster.siamese.dyndns.org> <7v7ijorwnc.fsf@gitster.siamese.dyndns.org> <7vabof5mze.fsf@gitster.siamese.dyndns.org> <7vwsrdaf3d.fsf@gitster.siamese.dyndns.org>
 <7vhci9u5qi.fsf@gitster.siamese.dyndns.org> <7vhchsa63t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 17:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBBVf-00073P-SI
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 17:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbYAEQEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 11:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbYAEQEF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 11:04:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:45637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755356AbYAEQEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 11:04:04 -0500
Received: (qmail invoked by alias); 05 Jan 2008 16:04:02 -0000
Received: from dslb-088-067-194-153.pools.arcor-ip.net (EHLO dslb-088-067-194-153.pools.arcor-ip.net) [88.67.194.153]
  by mail.gmx.net (mp018) with SMTP; 05 Jan 2008 17:04:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dl29XeWIdL97Z+oNKWi5xhTIcLMTmrPKj4l+f9s
	zlwE0HzM9pHOTL
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhchsa63t.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69676>

Hi,

On Sat, 5 Jan 2008, Junio C Hamano wrote:

> * bf/remote-head (Sun Dec 23 20:52:32 2007 -0500) 1 commit
>  . git-remote: make add -f guess HEAD, as clone does
> 
> New feature which could be used in rewriting git-clone as a thin wrapper 
> around other commands, but there are conflicting proposals from Kristian 
> and Dscho, which are post 1.5.4 item. We'll see how they pan out.

I do not have any objection against using bf/remote-head to introduce this 
feature, and will port it to C when it is deemed good enough.  After all, 
we _use_ shell scripting for prototyping things.

> * jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
>  - sha1-lookup: make selection of 'middle' less aggressive
>  - sha1-lookup: more memory efficient search in sorted list of SHA-1
> 
> Micro-optimization whose real world benefit is not proven.
> Definitely post 1.5.4.

I did not follow this closely... Would this help the "notes" feature as 
implemented with refs/notes?

> * jc/diff-pathspec (Sun Nov 25 10:03:48 2007 -0800) 1 commit
>  - Making ce_path_match() more useful by accepting globs
> 
> This was to allow "git diff-files -- '*.h'" (currently diff family
> knows only the leading directory match and not fileglobs), but was shot
> down by Alex.  I tend to agree with him.

I recently needed something like this, and had to script around the lack 
of support for this.

Ciao,
Dscho
