From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Automated/Daily build systems supporting git?
Date: Tue, 08 Apr 2008 08:17:19 -0700 (PDT)
Message-ID: <m3d4p0tlz7.fsf@localhost.localdomain>
References: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
	<20080408145953.GA8159@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 08 17:18:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjFaK-0005b0-3K
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 17:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYDHPRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 11:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbYDHPRX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 11:17:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:13371 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbYDHPRX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 11:17:23 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1945242fgb.17
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=wQ9TgAJPrgrif+0s0m08KiVnZCjtAUQPrkHJP3J8LQo=;
        b=dnVAuiDsVWbTDIauDfowqgBkYG58LLHlRTdbybgVnwo9XzkNczizTt1ZIZT3ACf1w0SRx6CU66IrDKtksbtdTUlhbMZyT3dMUoSzxZn+c70cc6wIm9veZRoQFoMPjqhr9kmlJ9Rzn/L8/0h+YdGqasZ5XQHOuLVrM4/6DRkNys0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=iGWV+S2H3PizaSiI4JUzeHAhQ2ULKYIQBuvUaapvCwkQG4HovCmPnFwoPZI+p4sf39M0unXlXbt4DmUDvhzQgvnAwPgQutVPlDROwj+0nV4fuadra2lzznuy6ukUSfdoZsyhvQmywkbHgjukst6hKvvQgAl72LH5inIjgiamsds=
Received: by 10.86.70.8 with SMTP id s8mr4820142fga.29.1207667841097;
        Tue, 08 Apr 2008 08:17:21 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.252.83])
        by mx.google.com with ESMTPS id e11sm8618804fga.5.2008.04.08.08.17.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Apr 2008 08:17:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m38FHJnU014974;
	Tue, 8 Apr 2008 17:17:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m38FHHHF014971;
	Tue, 8 Apr 2008 17:17:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080408145953.GA8159@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79002>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 08, 2008 at 03:57:52PM +0100, Alex Bennee wrote:
> 
> > I'm currently doing some investigation into automated/daily build
> > systems to track the health of a source tree. There seem to be a number
> > about but as I'm also looking to move the CVS tree over to git I was
> > wondering if the denziens of the list knew of any they could recommend?
> 
> Have you looked at contrib/continuous?

Perhaps Hudson[1] can be made to support Git, as it supports Mercurial
(via Mercurial plugin).

[1] https://hudson.dev.java.net/
-- 
Jakub Narebski
Poland
ShadeHawk on #git
