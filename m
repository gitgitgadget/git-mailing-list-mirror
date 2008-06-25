From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 23:32:21 -0400
Message-ID: <20080625033221.GU11793@spearce.org>
References: <7vwskfclfs.fsf@gitster.siamese.dyndns.org> <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl> <20080624160224.GA29404@genesis.frugalware.org> <alpine.DEB.1.00.0806241709330.9925@racer> <20080624185403.GB29404@genesis.frugalware.org> <alpine.DEB.1.00.0806242007150.9925@racer> <7vskv2d0lp.fsf@gitster.siamese.dyndns.org> <20080624221049.GE29404@genesis.frugalware.org> <7vk5gea0ff.fsf@gitster.siamese.dyndns.org> <m3fxr2jruy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:33:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLlF-0004oI-LH
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbYFYDch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYFYDcg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:32:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58715 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYFYDcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:32:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBLjv-00022W-5Y; Tue, 24 Jun 2008 23:32:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E43E620FBAE; Tue, 24 Jun 2008 23:32:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <m3fxr2jruy.fsf@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86210>

Jakub Narebski <jnareb@gmail.com> wrote:
> 
> What does "git ls-remote server:/home/vmiklos/git/test" invoke on server? 

FYI, it actually runs git-upload-pack, gets the list of advertised
refs, then closes the connection immediately.  The other side sees
the client hang up and just terminates silently, since the client
didn't "want" anything packed and sent.

-- 
Shawn.
