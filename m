From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-cherry-pick no longer detecting moved files in 1.5.3.4
Date: Tue, 16 Oct 2007 20:58:56 -0400
Message-ID: <20071017005856.GK13801@spearce.org>
References: <cac9e4380710161517m64ba737dj8711a6ce59b1b69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Quirk <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 02:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhxFl-0003yG-2B
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761053AbXJQA7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762164AbXJQA7A
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:59:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49094 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759050AbXJQA7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 20:59:00 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhxFH-0007dd-6L; Tue, 16 Oct 2007 20:58:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C5CBA20FBAE; Tue, 16 Oct 2007 20:58:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <cac9e4380710161517m64ba737dj8711a6ce59b1b69@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61297>

Richard Quirk <richard.quirk@gmail.com> wrote:
> (Also, minor thing this, but the docs for git-config
> says it is diff.renameLimit but diff.c uses diff.renamelimit.)

Someone else already responded about how to set this limit, but
I wanted to clarify what the docs vs. the code were doing here.

The docs use camelCase as it is prettier to read multiple words
that useCamelCase than alllowercaselikethis.  Internally when we
parse your config file we lowercase the entire string so that the
code can worry only about the lowercase variant.  That's why you
see it all lowercase in diff.c, but the docs suggest you to use
the camelCase format.

-- 
Shawn.
