From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 1/1] Make git archive respect core.autocrlf when
	creating ...
Date: Thu, 18 Sep 2008 21:29:29 +0100
Message-ID: <20080918202929.GA9948@hashpling.org>
References: <1a7cc4db062b7df0dae0f27b29dba66c9d917e59.1221767629.git.charles@hashpling.org> <20080918200120.GB8631@hashpling.org> <48D2B831.8080206@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Sep 18 22:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgQ9F-0006Ed-VS
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 22:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbYIRU3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 16:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbYIRU3i
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 16:29:38 -0400
Received: from fhw-relay07.plus.net ([212.159.14.148]:60537 "EHLO
	fhw-relay07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbYIRU3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 16:29:37 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1KgQ82-00035V-49; Thu, 18 Sep 2008 21:29:30 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m8IKTT7x010371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Sep 2008 21:29:29 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m8IKTTDO010370;
	Thu, 18 Sep 2008 21:29:29 +0100
Content-Disposition: inline
In-Reply-To: <48D2B831.8080206@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: f7430b58dc652d985d51b0773c074721
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96242>

On Thu, Sep 18, 2008 at 10:21:05PM +0200, Andreas Ericsson wrote:
> If it fixes the broken test while all the other tests still
> pass, I can only assume it's doing something right.

Only if you believe that I added a sensible test in the first place :-)

> The topic is a bit long though. Could you change it to
> "git archive: respect core.autocrlf when creating zip archives"
> so that it fits comfortably in one line when running "git log"
> on 80 char wide terminals?

Sorry, I made it <= 72 chars in my commit message and then forgot that
git format-patch adds the [PATCH] tag.

> As a side-note, you needn't put "1/1" in the [PATCH] section.
> That's usually done to make sure patches are applied in the
> right order when sending a series, but since a series of 1
> is kinda hard to jumble.. ;-)

I thought that the patch (a single commit) didn't really warrant a patch
series - being a one liner - but I made the test 0 of 1 so that people
could see the test failure first before deciding whether my proposed
patch was good or not. Sorry for the confusion.

Charles.
