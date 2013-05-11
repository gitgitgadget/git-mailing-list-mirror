From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Sat, 11 May 2013 19:41:19 +1000
Message-ID: <20130511094119.GA6196@iris.ozlabs.ibm.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
 <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
 <20130511055647.GA3262@iris.ozlabs.ibm.com>
 <20130511061322.GB3394@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 11:41:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub6Iy-0000C0-BX
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 11:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab3EKJlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 05:41:24 -0400
Received: from ozlabs.org ([203.10.76.45]:53606 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab3EKJlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 05:41:24 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 11C512C00DB; Sat, 11 May 2013 19:41:22 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <20130511061322.GB3394@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223949>

On Fri, May 10, 2013 at 11:13:22PM -0700, Jonathan Nieder wrote:
> Paul Mackerras wrote:
> 
> > I thought I had replied to this patch; maybe I only thought about it.
> >
> > Given that we already have a selector to choose between exact and
> > regexp matching, it seems more natural to use that rather than add a
> > new selector entry.  Arguably the "IgnCase" option should be disabled
> > when "adding/removing string" is selected.
> 
> Thanks.  I think I disagree: "log -G" and "log -S" are different
> operations, not variations on the same one.  

OK, fair enough, and I see there is in fact a --pickaxe-regex we
could use.

> The description "Find next commit adding/removing string:" very
> clearly conveys what "-S" means.  Maybe -G would be more clearly
> described as "Find next commit changing line that matches regex:" or
> "Find next commit changing line containing:"?

How about "changing lines matching:"?  If it gets too long it will
take up too much horizontal room.

Paul.
