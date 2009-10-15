From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 15 Oct 2009 07:33:40 -0700
Message-ID: <20091015143340.GI10505@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <7v63ah85ss.fsf@alter.siamese.dyndns.org> <20091015185253.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 16:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyRQk-0002y1-74
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 16:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbZJOOeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 10:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756172AbZJOOeR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 10:34:17 -0400
Received: from george.spearce.org ([209.20.77.23]:60202 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727AbZJOOeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 10:34:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 620D9381FE; Thu, 15 Oct 2009 14:33:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091015185253.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130393>

Nanako Shiraishi <nanako3@lavabit.com> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> >> This v3 series is a respin, and includes fixes to address reviewer
> >> comments from v2.
> 
> Junio, you merged this series to your "pu" branch, but it breaks
> "make test" (t9801). Shawn's "sp/smart-http" topic doesn't have
> t9801 and passes all the tests.

Actually, pu contains v2 right now, not v3.

And pu doesn't always pass the tests... because of issues like this.

It looks like there might be a semantic clash between John Herland's
jh/cvs-helper branch and my sp/smart-http branch... but digging
around at the code I haven't quite identified what that might be.

-- 
Shawn.
