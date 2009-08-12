From: Eric Wong <normalperson@yhbt.net>
Subject: Re: RFC for 1.7: Do not checkout -b master origin/master on clone
Date: Wed, 12 Aug 2009 02:56:56 -0700
Message-ID: <20090812095656.GA7706@dcvr.yhbt.net>
References: <4A818B90.9050206@drmicha.warpmail.net> <7v8whpda2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 11:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbAa0-0003te-Hw
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 11:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbZHLJ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 05:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbZHLJ45
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 05:56:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59193 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857AbZHLJ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 05:56:56 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id F1CD31F509;
	Wed, 12 Aug 2009 09:56:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v8whpda2l.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125690>

Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> > - Why does git svn set up a local branch with an svn upstream which is
> > determined by latest svn commit at the time of the first git svn fetch?
> 
> I do not have comments on design decisions in git-svn, other than trusting
> that Eric would exercise good design tastes to make things coherent with
> the git native workflow when the consistency makes sense.

Using 'trunk' (if available) as the master on new fetches does probably
make more sense based on the complaints I've gotten.  At the time,
several projects I cared about did almost all their work in branches and
trunk would go untouched for months....  These days most projects I care
about are already using git :)

-- 
Eric Wong
