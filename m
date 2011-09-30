From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's
 keychain
Date: Fri, 30 Sep 2011 18:13:32 -0400
Message-ID: <20110930221332.GC9384@sigill.intra.peff.net>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
 <20110929075627.GB14022@sigill.intra.peff.net>
 <CAEBDL5WhpVg17aPuRqrE5=2Q293kVD4fYtxGqRzx_K=87t-jgw@mail.gmail.com>
 <CAG+J_DyhcA7RmHwgGJBw4r9JRij0_ONp3ZMD6oMTJ_f4dvYW8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 00:13:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9lKt-0003MP-Ni
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 00:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758085Ab1I3WNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 18:13:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50450
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482Ab1I3WNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 18:13:34 -0400
Received: (qmail 5000 invoked by uid 107); 30 Sep 2011 22:18:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Sep 2011 18:18:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2011 18:13:32 -0400
Content-Disposition: inline
In-Reply-To: <CAG+J_DyhcA7RmHwgGJBw4r9JRij0_ONp3ZMD6oMTJ_f4dvYW8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182517>

On Fri, Sep 30, 2011 at 03:33:37PM -0400, Jay Soffian wrote:

> Sorry, missed this part in my previous reply. I don't understand - how
> do you ever send a username to the credential helper if you don't get
> it from the config? But in any case, if you have a username (via
> config or some other way), yes, I think it should be given to the
> credential helper.

For example:

  git fetch https://user@host/repo.git
  git fetch https://user2@host/repo.git

-Peff
