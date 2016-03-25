From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3/GSoC 1/5] path.c: implement strbuf_mkpath()
Date: Fri, 25 Mar 2016 05:51:10 -0400
Message-ID: <20160325095110.GA8880@sigill.intra.peff.net>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pickfire@riseup.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:51:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajOOk-0002Qu-TZ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 10:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbcCYJvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 05:51:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:38102 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751646AbcCYJvN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 05:51:13 -0400
Received: (qmail 5359 invoked by uid 102); 25 Mar 2016 09:51:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 05:51:13 -0400
Received: (qmail 22230 invoked by uid 107); 25 Mar 2016 09:51:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 05:51:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2016 05:51:10 -0400
Content-Disposition: inline
In-Reply-To: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289868>

On Wed, Mar 23, 2016 at 06:13:21PM +0800, Hui Yiqun wrote:

> There were already `mkpath`, `mkpathdup` and `mksnpath` for build
> filename, but lacked a version of `strbuf_` just like `strbuf_git_path`.
> 
> It is convenient to build a path and manipulate the result later with
> strbuf.

Makes sense, and the patch looks fine to me.

-Peff
