From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/19] pack-objects: implement bitmap writing
Date: Thu, 24 Oct 2013 23:22:10 -0400
Message-ID: <20131025032210.GC26283@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
 <20131024180642.GM24180@sigill.intra.peff.net>
 <CACsJy8By5bdJLMnf2FDJKU5+wD=NFh8QmS80crmk_u+K78Qa_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 05:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZXyb-00041H-9A
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 05:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab3JYDWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 23:22:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:55199 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754392Ab3JYDWN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 23:22:13 -0400
Received: (qmail 28098 invoked by uid 102); 25 Oct 2013 03:22:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 22:22:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 23:22:10 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8By5bdJLMnf2FDJKU5+wD=NFh8QmS80crmk_u+K78Qa_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236648>

On Fri, Oct 25, 2013 at 08:21:12AM +0700, Nguyen Thai Ngoc Duy wrote:

> > If bitmap writing is enabled for a given repository (either by calling
> > `pack-objects` with the `--write-bitmap-index` flag or by having
> > `pack.writebitmaps` set to `true` in the config) and pack-objects is
> > writing a packfile that would normally be indexed (i.e. not piping to
> > stdout), we will attempt to write the corresponding bitmap index for the
> > packfile.
> 
> I haven't read the actual patch yet, but the diffstat says user
> documentation is missing..

I'll work on that for the re-roll.

-Peff
