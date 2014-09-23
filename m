From: Jeff King <peff@peff.net>
Subject: Re: How to compile Git with NDK?
Date: Tue, 23 Sep 2014 12:13:20 -0400
Message-ID: <20140923161320.GC20624@peff.net>
References: <CAHd499C3iwpcGf+Zt+jDJfqW41P=6Uu=b8VGZKJpFZCtw56beg@mail.gmail.com>
 <54209333.7090300@gmail.com>
 <CAHd499C0XJDwNa3n3bzK7hu6iRunV1d=nvbqi+2pyoB8uSzDFA@mail.gmail.com>
 <CAHd499CUrKqY26eA2QwK4EpWOjum-NBXi==E8GwtjOty3ZYYeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 18:25:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWSid-0007Kw-LD
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 18:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbaIWQNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 12:13:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:50991 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932236AbaIWQNX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 12:13:23 -0400
Received: (qmail 26968 invoked by uid 102); 23 Sep 2014 16:13:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 11:13:22 -0500
Received: (qmail 29396 invoked by uid 107); 23 Sep 2014 16:13:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 12:13:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 12:13:20 -0400
Content-Disposition: inline
In-Reply-To: <CAHd499CUrKqY26eA2QwK4EpWOjum-NBXi==E8GwtjOty3ZYYeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257425>

On Tue, Sep 23, 2014 at 07:52:32AM -0500, Robert Dailey wrote:

> On Tue, Sep 23, 2014 at 7:47 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> > But if I type just 'make', I don't see how it will know where my ARM
> > toolchain is. I'll read the INSTALL file in the meantime.
> 
> Sorry for top post earlier, my mistake.
> 
> I reviewed the INSTALL file. It doesn't mention anything regarding how
> to setup the toolchain for the Git build. Also looks like I'll have to
> build the library dependencies with ARM toolchain as well. Looks like
> zlib is the only absolute required one. Is that correct?

Yes, zlib is the only absolute dependency. However, libcurl is useful if
you want to clone http repositories.

-Peff
