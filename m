From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Interactive difftool
Date: Sat, 28 Mar 2009 03:32:53 -0400
Message-ID: <20090328073253.GA9013@coredump.intra.peff.net>
References: <46dff0320903260829j34d8c613wf9b4fcc954c8519a@mail.gmail.com> <20090327145122.GA944@gmail.com> <46dff0320903270823v5e8e9c80w506d8a85440588f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 08:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnT3o-0000ZU-NJ
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 08:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbZC1HdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 03:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbZC1HdA
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 03:33:00 -0400
Received: from peff.net ([208.65.91.99]:39394 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbZC1Hc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 03:32:59 -0400
Received: (qmail 25183 invoked by uid 107); 28 Mar 2009 07:33:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Mar 2009 03:33:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Mar 2009 03:32:53 -0400
Content-Disposition: inline
In-Reply-To: <46dff0320903270823v5e8e9c80w506d8a85440588f5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114939>

On Fri, Mar 27, 2009 at 11:23:15PM +0800, Ping Yin wrote:

> We can just change git-difftool.perl
> 
> The easiest way is first parsing the output of git diff --stat,
> adding the number at the beginning, for example
> [1] diff.c                   |   10 +++++++++-
> [2] t/t4020-diff-external.sh |    8 ++++++++

I am not paying enough attention to this thread to comment on your
overall goal, but instead of parsing "--stat", try "--numstat".

-Peff
