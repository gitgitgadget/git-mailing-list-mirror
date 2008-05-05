From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Binary files in format-patch
Date: Mon, 5 May 2008 19:01:53 -0400
Message-ID: <20080505230153.GL29038@spearce.org>
References: <d280d7f10805051555x67bd7e87o999a2c9e19663b92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Caio Marcelo <cmarcelo@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 01:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt9hq-000215-Ug
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 01:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761691AbYEEXCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 19:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761952AbYEEXB7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 19:01:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53626 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761495AbYEEXB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 19:01:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jt9gn-0005aS-Em; Mon, 05 May 2008 19:01:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A8A5620FBAE; Mon,  5 May 2008 19:01:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <d280d7f10805051555x67bd7e87o999a2c9e19663b92@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81313>

Caio Marcelo <cmarcelo@gmail.com> wrote:
> I'm using "git format-patch" to generate messages for a code review
> mailing list. It work fine except when we have binary files involved.
> Their contents are not relevant for us, and doesn't help much in a
> mailing list. Taking a peek at the code I've found out this:

Why then are they committed in Git and being modified?  If the
files aren't relevant, why are they tracked?
 
-- 
Shawn.
