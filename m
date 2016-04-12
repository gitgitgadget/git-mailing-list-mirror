From: Jeff King <peff@peff.net>
Subject: Re: Git config not working correctly with included configurations
Date: Tue, 12 Apr 2016 11:50:01 -0400
Message-ID: <20160412155000.GA21249@sigill.intra.peff.net>
References: <assp.0910338c53.570CDB33.9020300@itflex.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rudinei Goi Roecker <rudineigr@itflex.com.br>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:51:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq0b2-0004qn-BB
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 17:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965796AbcDLPvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 11:51:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:48040 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965457AbcDLPuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 11:50:05 -0400
Received: (qmail 19058 invoked by uid 102); 12 Apr 2016 15:50:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 11:50:04 -0400
Received: (qmail 7997 invoked by uid 107); 12 Apr 2016 15:50:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 11:50:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Apr 2016 11:50:01 -0400
Content-Disposition: inline
In-Reply-To: <assp.0910338c53.570CDB33.9020300@itflex.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291270>

On Tue, Apr 12, 2016 at 08:25:39AM -0300, Rudinei Goi Roecker wrote:

> I'm having a problem with included configurations in ~/.gitconfig, when
> using this command:
> 
> git config --global user.email

You need to turn on "--includes" explicitly. From "git help config" in
v2.8.0:

  --[no-]includes
    Respect include.* directives in config files when looking up
    values. Defaults to off when a specific file is given (e.g., using
    --file, --global, etc) and on when searching all config files.

> I'm using Fedora 23, git version 2.5.5

The rule above has always been the case, but the documentation made it
more clear in v2.8.0.

-Peff
