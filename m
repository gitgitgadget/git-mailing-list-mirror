From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH v2 0/7] Provide API to invalidate refs cache
Date: Tue, 11 Oct 2011 09:09:58 +0100
Message-ID: <42eba56f4da8f642e806a667bfa22884@quantumfyre.co.uk>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
 <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
 <7vty7ggzum.fsf@alter.siamese.dyndns.org> <4E93D932.6020001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 10:10:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDXPe-0005cU-EJ
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 10:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107Ab1JKIKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 04:10:04 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:36186 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753171Ab1JKIKD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 04:10:03 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id E4B5BC0602;
	Tue, 11 Oct 2011 09:10:01 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id B906936E7AC;
	Tue, 11 Oct 2011 09:10:01 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ij9zjDc2zLhm; Tue, 11 Oct 2011 09:10:01 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id A042636A867;
	Tue, 11 Oct 2011 09:09:58 +0100 (BST)
In-Reply-To: <4E93D932.6020001@alum.mit.edu>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183286>

On Tue, 11 Oct 2011 07:50:42 +0200, Michael Haggerty wrote:
> And this rebase will be work with no benefit, because my series 
> includes
> all of the improvements of jp/get-ref-dir-unsorted plus much more.  
> But
> my change to the data structure is implemented in a different order 
> and
> following other improvements.  For example, I add a lot of comments,
> change a lot of code to use the cached_refs data structure more
> consistently, and accommodate partly-sorted lists by the time my 
> patch
> series includes everything that is in jp/get-ref-dir-unsorted.
>
> Rebasing 78 patches is going to be a morass of clerical work.  Is 
> there
> any alternative?

If you create a new commit that reverts the problematic changes to 
refs.c with some suitable message about doing the same thing more 
piecemeal as the first change of a new series, and rebase your changes 
on top, you should be able to create a 79 patch series with little work. 
Dunno if that would acceptable for merging?

-- 
Julian
