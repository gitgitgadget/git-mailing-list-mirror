From: Peter Weseloh <Peter.Weseloh@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #03; Sun, 15)
Date: Sun, 15 Nov 2009 23:40:44 +0000 (UTC)
Message-ID: <loom.20091116T003914-635@post.gmane.org>
References: <7vtywwm6i4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 00:45:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9omM-0002Hz-MH
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 00:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbZKOXo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 18:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbZKOXo7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 18:44:59 -0500
Received: from lo.gmane.org ([80.91.229.12]:36570 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbZKOXo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 18:44:58 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N9omF-0002Gc-UW
	for git@vger.kernel.org; Mon, 16 Nov 2009 00:45:04 +0100
Received: from 12.239.141.189 ([12.239.141.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 00:45:03 +0100
Received: from Peter.Weseloh by 12.239.141.189 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 00:45:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.239.141.189 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132972>

Junio C Hamano <gitster <at> pobox.com> writes:

> * nd/sparse (2009-08-20) 19 commits.
> 
> The latest update I didn't look at very closely but I had an impression
> that it was touching very generic codepath that would affect non sparse
> cases, iow the patch looked very scary (the entire series already is).
Hi,
I'm new here so first of all thanks a lot for such a great tool!

Does that mean this feature will not make it into 'master' any time soon? 
I'm currently trying to convince my managment to switch from CVS to git. 
What causes some trouble is that we have quite some files (> 40k) in various
(>300) CVS modules and splitting them into sub-repos seams somewhat difficult.
git has no problem even with that many files but commands that stat the
working copy (e.g. 'git status') take quite long on our filers
(it's either a problem with the filers or with nfs or both, I don't know yet).
Having the ability to do sparse checkouts only of the repo sounds like a
way out.

Annother question: What's the timeline for 1.7.0? I couldn't find anything
about it neither here nor in the wiki.

Thanks,
Peter
