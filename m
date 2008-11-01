From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when
	--compose is used.
Date: Sat, 1 Nov 2008 09:00:33 -0400
Message-ID: <20081101130033.GD17961@sys-0.hiltweb.site>
References: <20081031213803.GB21799@artemis.corp> <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com> <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org> <1225456609-694-3-git-send-email-madcoder@debian.org> <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com> <20081031213803.GB21799@artemis.corp> <20081101022649.GB17961@sys-0.hiltweb.site> <20081101110439.GB3819@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 14:01:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwG6x-0002rv-Sn
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 14:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbYKANAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 09:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbYKANAi
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 09:00:38 -0400
Received: from mail.gmx.com ([74.208.5.67]:46512 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751436AbYKANAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 09:00:38 -0400
Received: (qmail invoked by alias); 01 Nov 2008 13:00:36 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com (EHLO sys-0.hiltweb.site) [75.185.223.130]
  by mail.gmx.com (mp-us003) with SMTP; 01 Nov 2008 09:00:36 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1/J4tgDY/7J2sXWieX7lDq10VbuBl7RvXpIfGSEky
	AB+ujMjlFrk0Ou
Content-Disposition: inline
In-Reply-To: <20081101110439.GB3819@artemis.corp>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99740>

On Sat, Nov 01, 2008 at 12:04:39PM +0100, Pierre Habouzit wrote:
> I didn't do it for a very good reason: the To field is tricker to parse
> because very fast it's multiline, and must be split along the ',' when
> parsed back and so on.

Right.  So my patch is broken in that it doesn't parse the addresses
correctly.  This _should_ be easy to fix.  I knew my patch sucked, but I
wanted to get the idea out there.  For me, I don't like specifying all
that information on the command-line.  It would be nice to be able to
edit the To and Cc fields in the editor.

> And even moreuseful than the To is the Cc list that git-send-email
> bloats to death and that I would like to reduce very often.

You mean git-send-email adds too many addresses to the Cc list, or the
code for those fields is already bloated to death?

> But sadly that needs an expertise of perl I absolutely don't have. We
> probably even want to depend on some MIME perl library that knows about
> those kind of issues and do it for us well.

I'm confused here.  Why would a MIME library help?

> But yeah, I knew I left out those, and this was the reason.

Anyway, do you, or does anyone else, think it's even worth coding the
possibility for the user to edit the To and Cc fields?


	Ian
