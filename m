From: Andi Kleen <andi@firstfloor.org>
Subject: Re: groff .ft command use in asciidoc
Date: Wed, 17 Nov 2010 12:52:46 +0100
Message-ID: <20101117115245.GB23656@basil.fritz.box>
References: <20101117095233.GA23817@basil.fritz.box>
 <20101117101516.GA12416@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 12:53:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIgZU-0000CR-Rl
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 12:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934574Ab0KQLws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 06:52:48 -0500
Received: from one.firstfloor.org ([213.235.205.2]:53426 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962Ab0KQLwr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 06:52:47 -0500
Received: from basil.firstfloor.org (p5B3C9449.dip0.t-ipconnect.de [91.60.148.73])
	by one.firstfloor.org (Postfix) with ESMTP id AB3361A9805F;
	Wed, 17 Nov 2010 12:52:46 +0100 (CET)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 2A343B16AA; Wed, 17 Nov 2010 12:52:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101117101516.GA12416@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161612>

> This is in my opinion a bug: unless you use ASCIIDOC_NO_ROFF, git's
> asciidoc.conf will include raw roff directives in the docbook markup
> it generates.  And then docbook will escape the periods, producing
> the output you see.

I see. Thanks for the explanation.

> 
> The workaround is very simple: set ASCIIDOC_NO_ROFF to nonempty
> when you build documentation.

I will suggest to the opensuse git maintainers to set that variable.
 
> I think the only reason this is not the default is that no one has
> tested it with old DocBook XSL versions, but I'm not sure.
> Documentation/Makefile has some notes about this.

It would be nice if that worked out of the box.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
