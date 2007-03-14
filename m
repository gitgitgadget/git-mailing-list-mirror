From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 10:07:21 +0100
Message-ID: <81b0412b0703140207kf887738od482022497d2a63d@mail.gmail.com>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	 <7vveh4hapk.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703140119s4691211bw8a5ef3ba25c5cbdf@mail.gmail.com>
	 <7vfy88dwvw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:08:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRPSv-00044X-QN
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 10:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030724AbXCNJHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 05:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030698AbXCNJHY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 05:07:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:53227 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030705AbXCNJHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 05:07:23 -0400
Received: by nf-out-0910.google.com with SMTP id o25so131811nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 02:07:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QDx2Pj/Lj0sXv54X76nSOPvlNpyg/wFxnyWPVfwvSaiSj0738512EB7DIkFuBrCO+ch85S7R4wEHjdBePmvuEcIRj8SBJzRo6uIKN5VYuJSPyDBgQZtWwwRp9WA9D2QgZ0moSB7sBWQACyOPilmOWwVrIxNancPO++U0BA7+scs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K18sJ5vd9pO29N1bois5HaaBTSKo7evD9sPxgWWtLz0ZYH3A43mRvHIx71t2Y5KRtmxxo++UBfD3Jaugcc31iONQJbMR7SNjP5hJKg8cnIF2QtEgIi1J79PgnBs3KyZcPyo8l+mrrO4ca6E0z0HeSQS6e1plH6PdcgeHWIj6cNQ=
Received: by 10.78.204.7 with SMTP id b7mr1022794hug.1173863241930;
        Wed, 14 Mar 2007 02:07:21 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 02:07:21 -0700 (PDT)
In-Reply-To: <7vfy88dwvw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42189>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> and people who have been learning from the scripts (we used to
> have lot more scripts) would have picked up that pattern.
> That's why I already told you that --exit-status is the right
> thing to do if we were doing it from scratch, but is a wrong
> thing to do at this point.  Maybe in a release as big as 1.5.0
> that we pre-announce a lot of interface changes.

This is something I don't understand: why is a new option
--exit-code wrong? Noone uses it yet and the default exit code
is at it was before (modulo the bug with diff-tree). I am *not*
proposing to change default exit codes (well, I suggest that).
So what's the problem?
