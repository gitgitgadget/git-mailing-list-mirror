From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH] Add tests for git format-patch --to and format.to config
 option
Date: Wed, 10 Mar 2010 16:53:57 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1003101643390.21063@vqena.qenxr.bet.am>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org> <20100306003946.GD27414@genesis.frugalware.org> <7vr5nykx55.fsf@alter.siamese.dyndns.org> <4B92EDFA.1000602@gmail.com> <7vaaukdch2.fsf@alter.siamese.dyndns.org> <4B937559.6000302@gmail.com>
 <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Boyd <bebarino@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 05:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpD7l-0000hN-C6
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 05:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180Ab0CJECR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 23:02:17 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:47681 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756151Ab0CJECQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 23:02:16 -0500
Received: from idran.drake.org.nz (ip-118-90-113-200.xdsl.xnet.co.nz [118.90.113.200])
	by ananke.wxnz.net (Postfix) with ESMTP id A809F170BDA;
	Wed, 10 Mar 2010 17:02:12 +1300 (NZDT)
In-Reply-To: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 7 Mar 2010, Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
> 
> > ... We have the
> > option of making them consistent with the rest of git with a little bit
> > of work. If you say --no-cc or --no-add-headers or --no-to the
> > respective config should be overriden. If you say --to or --cc or
> > --add-headers it should be appended. I doubt anyone would find that
> > surprising since --no-* doesn't do anything right now.
> 
> That sounds like a sensible and practical way out, as it won't break
> existing setup that expects the additive behaviour these two command
> somehow ended up with, while allowing --no-* to override the config when
> necessary.

I agree with that.

-- 
Steven
