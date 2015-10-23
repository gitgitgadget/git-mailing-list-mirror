From: Kannan Goundan <kannan@cakoose.com>
Subject: Re: Make "git checkout" automatically update submodules?
Date: Fri, 23 Oct 2015 03:46:47 +0000 (UTC)
Message-ID: <loom.20151023T044009-172@post.gmane.org>
References: <loom.20151016T001449-848@post.gmane.org> <xmqq7fmnhg4x.fsf@gitster.mtv.corp.google.com> <loom.20151023T013752-72@post.gmane.org> <xmqq37x2qqzf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 23 05:47:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpTJm-0007fD-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 05:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbbJWDq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 23:46:58 -0400
Received: from plane.gmane.org ([80.91.229.3]:54769 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbbJWDq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 23:46:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZpTJd-0007US-2B
	for git@vger.kernel.org; Fri, 23 Oct 2015 05:46:53 +0200
Received: from 205.189.0.114 ([205.189.0.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 05:46:53 +0200
Received: from kannan by 205.189.0.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 05:46:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 205.189.0.114 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280082>

Junio C Hamano <gitster <at> pobox.com> writes:

> We are unfortunately not set up to handle money well.  For a
> background explanation, please go read [*1*], which I wrote my take
> on "money" some time ago.  Note that it is an explanation and not a
> justification.  It explains why we are not set up to handle money
> well and what the issues around money that are troublesome for the
> project are.  It does not mean to say that it is a good thing that
> it is hard to buy feature with money from our project [*2*].

I think the way I described it ("sponsoring a feature") doesn't really
reflect how I was imagining it.  In my head, it looked like this:

1. Figure out whether the Git community and maintainers seem ok with the
overall feature idea.  If not, give up.
2. Come up with a plan for the UI/UX; see if the Git community and
maintainers seem ok with it.  If not, iterate or give up.
3. Implement it, then go through the regular process of getting it merged
upstream.  If it doesn't go well, might have to iterate or give up.

I could try doing that myself, but someone familiar with the Git
codebase/community/history would be better at it (and probably be easier for
you guys to work with :-)

I guess I'm just wondering if there are people who meet those qualifications
and are interested in going through those steps for pay.  Or maybe there's a
company that does this, like the old Cygnus Solutions?

In particular, I don't expect anything to change about the project's
development process.

(This part is not relevant to the Git project, but I understand that it's
hard for anyone to guarantee a feature will make it into an open source
project.  I imagine these kinds of contracts are set up so that you're
primarily paying for the effort, not the outcome.  If it ends up not working
out, you don't get your money back.)
