From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lib-httpd/apache.conf: check version only after
 mod_version loads
Date: Fri, 21 Jun 2013 14:18:13 -0400
Message-ID: <20130621181813.GB5290@sigill.intra.peff.net>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com>
 <20130621043052.GA5318@sigill.intra.peff.net>
 <20130621044236.GA5798@sigill.intra.peff.net>
 <26902D6D-D105-4943-BC67-461CEF82D888@gernhardtsoftware.com>
 <20130621044953.GA5962@sigill.intra.peff.net>
 <D0852D0F-3282-41DF-8A5A-4BEF1B39ED66@gernhardtsoftware.com>
 <20130621180334.GA4499@sigill.intra.peff.net>
 <1B9251F9-C1AF-41F7-8BF8-D36DDB27EF09@gernhardtsoftware.com>
 <20130621181250.GA5290@sigill.intra.peff.net>
 <603055CE-E8DE-4C53-9A7B-AE49CE515CCA@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 20:18:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq5ud-0002Oc-L2
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423522Ab3FUSSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:18:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:40341 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423383Ab3FUSSP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:18:15 -0400
Received: (qmail 21381 invoked by uid 102); 21 Jun 2013 18:19:15 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Jun 2013 13:19:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 14:18:13 -0400
Content-Disposition: inline
In-Reply-To: <603055CE-E8DE-4C53-9A7B-AE49CE515CCA@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228642>

On Fri, Jun 21, 2013 at 02:15:39PM -0400, Brian Gernhardt wrote:

> > Cool. I think the patch should look like the one below, then.
> 
> Basically identical to what I've done, you're just faster to the actual patch.  :-D

I started writing the rationale immediately after making the suggestion,
before you responded.  Lucky for me my guess turned out to be right. :)

> > which explains why it works here. I'm assuming you will not have
> > mod_version.c compiled in.
> 
> Indeed I do not.
> 
>  $ httpd -l
>  Compiled in modules:
>    core.c
>    prefork.c
>    http_core.c
>    mod_so.c

Makes sense. Thanks for the bug report.

-Peff
