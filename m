From: Chris Wedgwood <cw@f00f.org>
Subject: Re: Lost uncommitted changes and cogito
Date: Fri, 10 Jun 2005 09:20:27 -0700
Message-ID: <059176.ed2e86bb7f91c5a63977e0fe2c7a5cac.ANY@taniwha.stupidest.org>
References: <9e473391050609122372080863@mail.gmail.com> <9e4733910506091728761275d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 18:18:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgmDQ-00034j-Bf
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 18:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVFJQW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 12:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVFJQW2
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 12:22:28 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:63192 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262598AbVFJQVc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 12:21:32 -0400
Received: from pimout1-ext.prodigy.net (pimout1-int.prodigy.net [207.115.5.65])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j5AGKcKf003508
	for <git@vger.kernel.org>; Fri, 10 Jun 2005 12:21:00 -0400
X-ORBL: [63.202.173.158]
Received: from taniwha.stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout1-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j5AGKRsk099608;
	Fri, 10 Jun 2005 12:20:28 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 65539528F22; Fri, 10 Jun 2005 09:20:27 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910506091728761275d7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2005 at 08:28:25PM -0400, Jon Smirl wrote:

> After experimenting for a while it looks like any cg update to a
> branch that the repository wasn't initially cloned from will lose
> the pending uncomitted changes.

I've had my current working tree trashed too a few times so I more or
less backup my tree before doing anything adventurous in case of
accidents or bugs.

I'd actually like to see checked out files being RO and needing some
kind of explicit "cg-edit <filename>" or similar to frob them to RW so
that we can use the R/W status in order to determine what files are
safe to mess with.
