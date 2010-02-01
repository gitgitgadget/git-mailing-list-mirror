From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 14:52:08 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-6F8B85.14520801022010@news.gmane.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com> <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 23:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc58H-0006ny-I7
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 23:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab0BAWwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 17:52:32 -0500
Received: from lo.gmane.org ([80.91.229.12]:42025 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab0BAWwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 17:52:31 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nc589-0006kB-0a
	for git@vger.kernel.org; Mon, 01 Feb 2010 23:52:29 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 23:52:29 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 23:52:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138654>

In article <87aavsu9b3.fsf@osv.gnss.ru>, Sergei Organov <osv@javad.com> 
wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> > Steve Diver <squelch2@googlemail.com> writes:
> 
> [...]
> 
> > If read carefully (some may argue that it does not need a very careful
> > reading to get it, though), this hints that "detached HEAD" state is a
> > substitute for using a temporary branch, but it may not be strong
> > enough.
> 
> For my rather fresh eye it looks more like unnamed (anonymous?) branch
> than a temporary one. Doesn't detached HEAD behave exactly like a
> regular HEAD but pointing to the tip of an unnamed branch?

I strongly concur with this.

And as long as I'm weighing in, it would also help to prevent confusion 
if it were made clear that this unnamed branch doesn't actually come 
into existence unless and until you do a commit.

rg
