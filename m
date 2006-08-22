From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: bugfix: a.list formatting regression
Date: Wed, 23 Aug 2006 00:46:09 +0200
Organization: At home
Message-ID: <ecg1fd$3uj$2@sea.gmane.org>
References: <20060822085540.1104.qmail@web31812.mail.mud.yahoo.com> <11562409683011-git-send-email-jnareb@git.vger.kernel.org> <7vr6z8mmb7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 23 00:46:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFf0o-0004M7-V9
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 00:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWHVWqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 18:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWHVWqT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 18:46:19 -0400
Received: from main.gmane.org ([80.91.229.2]:36809 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750776AbWHVWqT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 18:46:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFf0d-0004Jt-H0
	for git@vger.kernel.org; Wed, 23 Aug 2006 00:46:11 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 00:46:11 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 00:46:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25881>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@git.vger.kernel.org> writes:
(the above is result of paste in wrong place in git-send-email invocation)
[...]
>> The fix is to add "subject" class and use this class
>> to replace pre-format_subject_html formatting of subject
>> (comment) via using (or not) <b>...</b> element. This
>> should go back to the pre-17d0744318... style.
[...]
> 
> I haven't seen an Ack from Luben for the proposed renaming of
> the class, although I very much like naming things for what they
> mean (i.e. "subject"), not what they do (i.e. "bold") myself.
> 
> It might be worthwhile to do a full sweep of the pages we
> generate and identify what classes we would want.  I have a
> feeling that we overuse a.list for example -- they are all in
> some form of list alright but they might benefit from a bit
> finer logical separatoin.  One list is enumaration of refs and
> another is a chronological sequence of commits.
> 
> Then people who would want to tweak the presentation would have
> an easier time changing only gitweb.css.

Next patch in this series of patches 
   [PATCH] gitweb: Replace some presentational HTML by CSS
   Message-Id: <11562431392439-git-send-email-jnareb@git.vger.kernel.org>
adds "name" subclass (a.list.name) for ref names. (I think
subclasses/multiple classes is the way to do it, as all a.list
elements have something in common: use next class to divide).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
