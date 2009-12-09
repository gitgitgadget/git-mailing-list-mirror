From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 1/3] refactor ref status logic for pushing
Date: Wed, 9 Dec 2009 02:13:29 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0912090211020.14365@iabervon.org>
References: <20091208223413.98e99d3e.rctay89@gmail.com>  <20091208223543.c7f88afe.rctay89@gmail.com>  <alpine.LNX.2.00.0912081158040.14365@iabervon.org> <be6fef0d0912081940p63628d5eoab93a1a1f2676baa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 08:13:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIGjw-0007m8-5b
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 08:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898AbZLIHNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 02:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756873AbZLIHNX
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 02:13:23 -0500
Received: from iabervon.org ([66.92.72.58]:35744 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756856AbZLIHNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 02:13:23 -0500
Received: (qmail 12805 invoked by uid 1000); 9 Dec 2009 07:13:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Dec 2009 07:13:29 -0000
In-Reply-To: <be6fef0d0912081940p63628d5eoab93a1a1f2676baa@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134944>

On Wed, 9 Dec 2009, Tay Ray Chuan wrote:

> Hi,
> 
> On Wed, Dec 9, 2009 at 1:17 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Tue, 8 Dec 2009, Tay Ray Chuan wrote:
> >
> >> Move the logic that detects up-to-date and non-fast-forward refs to a
> >> new function in remote.[ch], set_ref_status_for_push().
> >
> > Is there some reason to not have set_ref_status_for_push() be static in
> > transport.c now? (Sorry for not suggesting this before.)
> 
> it can't be static, because builtin-send-pack.c::main() needs it too.

Oh, right, fair enough.

	-Daniel
*This .sig left intentionally blank*
