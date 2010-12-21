From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Commiting automatically (2)
Date: Tue, 21 Dec 2010 08:36:30 +0000 (UTC)
Message-ID: <loom.20101221T092948-59@post.gmane.org>
References: <loom.20101219T090500-396@post.gmane.org> <7vaak1ftin.fsf@alter.siamese.dyndns.org> <loom.20101220T062209-24@post.gmane.org> <20101220073312.GA23482@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 21 09:36:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUxiD-000399-Ad
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 09:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758060Ab0LUIgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 03:36:44 -0500
Received: from lo.gmane.org ([80.91.229.12]:55912 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099Ab0LUIgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 03:36:44 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PUxi6-00037S-Vs
	for git@vger.kernel.org; Tue, 21 Dec 2010 09:36:43 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 09:36:42 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 09:36:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164027>

Enrico Weigelt <weigelt <at> metux.de> writes:

> * Maaartin <grajcar1 <at> seznam.cz> wrote:
> 
> > Yes, I wonder why it wasn't already implemented. I do something like
> > make all; git snapshot; send_the_executable_to_the_customer
> > which is IMHO needed quite often.
> 
> Perhaps it's wise to just use a separate repository on the same 
> repository. Maybe make it more convenient using some little
> shell functions. I'm also using that for backup purposes, where
> the repo lies outside the to-be-backed-up tree.

I considered using a separate repository, too, but having "all in one" feels 
somehow better. It allows me to push everything to a single remote repo and 
compare the snapshots to ordinal commits, etc.

I let the snapshot point to the current head, which is where I get a problem now:
git show-ref HEAD
returns nothing,
git show-ref --head
returns HEAD and all branches and tags. Isn't it a bug? How can I get the HEAD 
reference? I'm using git version 1.7.2.3 on cygwin.
