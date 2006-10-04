From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Wed, 04 Oct 2006 05:07:12 +0200
Organization: At home
Message-ID: <efv8fv$dvn$1@sea.gmane.org>
References: <7virj0lsua.fsf@assigned-by-dhcp.cox.net> <20061004024837.4462.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Oct 04 05:06:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUx5x-0006Qb-A1
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 05:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWJDDGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 23:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWJDDGr
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 23:06:47 -0400
Received: from main.gmane.org ([80.91.229.2]:54461 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161065AbWJDDGq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 23:06:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUx5o-0006Pf-NS
	for git@vger.kernel.org; Wed, 04 Oct 2006 05:06:44 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Oct 2006 05:06:44 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Oct 2006 05:06:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28314>

Luben Tuikov wrote:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> > I like the fact that the "data part" of blame is text, and
>> > that the commit-8 is on the left, and color-chunked.  Sometimes
>> > people simply _remember_ a number of commit-8's and thus the
>> > layout of blame is intentional, since they can look to the left
>> > and recognize a commit-8...
>> 
>> It is not only the initial commit.  A substantial rewrite and
>> new development also has the same issue.
>> 
>> I think you are also contradicting yourself by saying that
>> people would recognize a commit-8, and at the same time you do
>> not like the chunk code that makes sure you do not get too few
>> of them.  If people _do_ recognize commit-8 (I seriously doubt
>> that), then wouldn't it help to make sure you have them on every
>> couple-dozen lines so that the user would see the familiar one
>> even when scrolled?
> 
> It is not that I don't like it.  For example if we didn't have
> the block-per-commit-coloring, then we'd make use of this, but it
> seems that the block-per-commit-coloring exists for the purpose to
> show conglomerations of same-commit lines, thus obviating the need
> to repeat it (commit-8) every so many lines.

Colors repeat. They are not enough.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
