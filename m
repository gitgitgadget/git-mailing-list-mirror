From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Remote git-cat-file?
Date: Sun, 28 May 2006 20:34:43 +0200
Organization: At home
Message-ID: <e5cqg5$om2$1@sea.gmane.org>
References: <loom.20060528T002420-957@post.gmane.org> <Pine.LNX.4.64.0605271727110.5623@g5.osdl.org> <loom.20060528T124835-757@post.gmane.org> <e5c3c5$i47$1@sea.gmane.org> <7vu07acanv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun May 28 20:35:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkQ6S-00054T-Lz
	for gcvg-git@gmane.org; Sun, 28 May 2006 20:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWE1SfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 14:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWE1SfA
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 14:35:00 -0400
Received: from main.gmane.org ([80.91.229.2]:31186 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750858AbWE1Se7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 14:34:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FkQ6F-00052u-BK
	for git@vger.kernel.org; Sun, 28 May 2006 20:34:51 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 May 2006 20:34:51 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 May 2006 20:34:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20887>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> It would be nice I think to be able to have remote alternatives,...
> 
> Yup, I think I've mentioned that one as one of "the mostly
> unimplementable but would be very nice to have crazy wishlist
> items" some time ago.  What people would want is not a "shallow"
> clone, but a "lazy" clone, and in the ideal world that would
> obviously be a nice thing to have.

I think that it should be only "commit-lazy", i.e. downloading whole trees,
subtrees, and objects pointed by tags, only not following the parent links
of commits; perhaps also other links to commits (branches, tags, tag
objects).

-- 
Jakub Narebski
Warsaw, Poland
