From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Tue, 18 Mar 2014 00:40:16 -0400
Message-ID: <20140318044016.GA8240@sigill.intra.peff.net>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
 <EA1EF5746EA7414CAE1320AA61100178@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 05:40:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPlph-0001tV-4a
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 05:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbaCREka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 00:40:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:41622 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750907AbaCREkS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 00:40:18 -0400
Received: (qmail 20232 invoked by uid 102); 18 Mar 2014 04:40:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Mar 2014 23:40:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2014 00:40:16 -0400
Content-Disposition: inline
In-Reply-To: <EA1EF5746EA7414CAE1320AA61100178@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244327>

On Sun, Mar 16, 2014 at 06:30:49PM -0000, Philip Oakley wrote:

> >* jk/branch-at-publish-rebased (2014-01-17) 5 commits
> >- t1507 (rev-parse-upstream): fix typo in test title
> >- implement @{publish} shorthand
> >- branch_get: provide per-branch pushremote pointers
> >- branch_get: return early on error
> >- sha1_name: refactor upstream_mark
> >
> >Give an easier access to the tracking branches from "other" side in
> >a triangular workflow by introducing B@{publish} that works in a
> >similar way to how B@{upstream} does.
> >
> >Meant to be used as a basis for whatever Ram wants to build on.
> 
> To me 'publish' didn't fel right, though the later 'push' suggestion felt
> honest.
> (http://git.661346.n2.nabble.com/RFC-PATCH-format-patch-introduce-branch-forkedFrom-tp7601682p7603725.html)

FWIW, I think I like "@{push}" at this point, and we should perhaps add
"@{pull}" as an alias for "@{upstream}" for consistency.

-Peff
