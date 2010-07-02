From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Purpose of "struct object_entry *oe = oe;"?
Date: Fri, 02 Jul 2010 10:28:51 +0100
Message-ID: <80iq4y44h8.fsf@tiny.isode.net>
References: <8039w681lo.fsf@tiny.isode.net>
            <20100702084846.GA4682@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 11:29:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUcYq-0004ZS-8R
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 11:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758181Ab0GBJ3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 05:29:06 -0400
Received: from rufus.isode.com ([62.3.217.251]:54733 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758168Ab0GBJ3E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 05:29:04 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <TC2xXQB1Hx8p@rufus.isode.com>; Fri, 2 Jul 2010 10:29:01 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Fri, 02 Jul 2010 10:28:51 +0100
X-Hashcash: 1:20:100702:git@vger.kernel.org::UVeICbFXxcWgWd2z:0000000000000000000000000000000000000000001pq8
X-Hashcash: 1:20:100702:davvid@gmail.com::2DlhvZ1Rk/YpSkUg:05lp5
In-Reply-To: <20100702084846.GA4682@gmail.com> (David Aguilar's message of
	"Fri, 2 Jul 2010 01:48:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150120>

David Aguilar <davvid@gmail.com> writes:

[...]

> There are some good explanations in the list archives.
> http://thread.gmane.org/gmane.comp.version-control.git/133278/focus=133422
> http://thread.gmane.org/gmane.comp.version-control.git/124676/focus=124803

Thanks.  That matches my guess.

Wouldn't it be useful to mention it in CodingGuidelines?

A danger is that the declaration (that yes, this really is initialised
before use) becomes invalid during further changes, so it's best if
everybody concerned understands the convention.

Obviously if it's a commonly understood and used convention then it's
just as well not to have it in CodingGuidelines, but I'm not convinced
that this one is, though (having noticed it) the intention isn't hard to
grok.
