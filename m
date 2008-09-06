From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Sat, 6 Sep 2008 14:40:33 -0400
Message-ID: <20080906184033.GA4598@coredump.intra.peff.net>
References: <20080906150723.GA31540@dervierte> <20080906173925.GA4044@coredump.intra.peff.net> <e06498070809061133p2e3a206fmfd47961645b15ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 20:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc2j9-000490-Qs
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 20:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbYIFSkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 14:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbYIFSkg
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 14:40:36 -0400
Received: from peff.net ([208.65.91.99]:3398 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084AbYIFSkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 14:40:36 -0400
Received: (qmail 25731 invoked by uid 111); 6 Sep 2008 18:40:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 06 Sep 2008 14:40:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Sep 2008 14:40:33 -0400
Content-Disposition: inline
In-Reply-To: <e06498070809061133p2e3a206fmfd47961645b15ff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95091>

On Sat, Sep 06, 2008 at 02:33:21PM -0400, Steven Walter wrote:

> http://repo.or.cz/w/yap.git

Hmm. Bug, or am I missing something fundamental?

  $ mkdir repo && cd repo
  $ yap init
  Initialized empty Git repository in /home/peff/repo/.git/
  $ echo content >file
  $ yap add file
  Current branch: master
  Files with staged changes:
          (none)
  Files with unstaged changes:
          file
  $ yap add file
  Current branch: master
  Files with staged changes:
          (none)
  Files with unstaged changes:
          file
          file
  $ yap add file
  Current branch: master
  Files with staged changes:
          (none)
  Files with unstaged changes:
          file
          file
          file

-Peff
