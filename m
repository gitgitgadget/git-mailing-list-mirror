From: Stephen Bash <bash@genarts.com>
Subject: Re: [RFC/PATCH 0/3] git log --pretty=lua
Date: Tue, 25 Sep 2012 09:49:15 -0400 (EDT)
Message-ID: <1236918118.55838.1348580955644.JavaMail.root@genarts.com>
References: <CACsJy8Bs4P7R7m7uAqHYdmrXJA1RQmuoC7ybJFHWhW=efffQyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 15:49:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGVW4-000359-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 15:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab2IYNt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 09:49:27 -0400
Received: from hq.genarts.com ([173.9.65.1]:54980 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756502Ab2IYNt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 09:49:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 16EBBBE15A1;
	Tue, 25 Sep 2012 09:49:23 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rBljEje+Z+3; Tue, 25 Sep 2012 09:49:15 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id ACE25BE1578;
	Tue, 25 Sep 2012 09:49:15 -0400 (EDT)
In-Reply-To: <CACsJy8Bs4P7R7m7uAqHYdmrXJA1RQmuoC7ybJFHWhW=efffQyw@mail.gmail.com>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC21 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206357>

----- Original Message -----
> From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
> Sent: Tuesday, September 25, 2012 7:22:49 AM
> Subject: Re: [RFC/PATCH 0/3] git log --pretty=lua
> 
> On Tue, Sep 25, 2012 at 7:23 AM, Jeff King <peff@peff.net> wrote:
> > We've talked off and on about extending the --pretty=format
> > specifiers to something more flexible. There's also been talk
> > recently of more flexible commit-filtering (e.g., grepping
> > individual notes).  Rather than invent a new Turing-complete
> > language, I thought I'd try building on somebody else's work by
> > embedding an existing language.
> >
> > Why Lua? I don't especially like it as a language. But it's designed
> > for this purpose, which makes it very lightweight and relatively
> > simple to embed.
> 
> Personally I'd prefer a Scheme variant.

Scheme only brings up bad memories for me ;)  And while we use Lua at
$dayjob, I, like Peff, am not a huge fan of the syntax.  So turning to
the internet to solve my problem, a quick Google search for embeddable
scripting languages (assuming the heavyweights like Perl and Python are
already out) produces Lua, JavaScript or specifically SpiderMonkey [1]
(yay buzzword compliance!), Ch [2] (unfortunately closed source), and
AngelScript [3].

>From a brief read of the webpage, AngelScript looks pretty interesting.
I'm much better with (and thus preferential to) Python and Perl myself,
but I can understand anyone's reservation in bundling/depending on
libraries of that size.

[1] https://developer.mozilla.org/en-US/docs/SpiderMonkey
[2] http://www.softintegration.com/
[3] http://angelcode.com/angelscript/

Thanks,
Stephen
