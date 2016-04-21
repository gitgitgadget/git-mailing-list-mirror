From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 04/12] worktree.c: mark current worktree
Date: Thu, 21 Apr 2016 11:13:56 -0400
Message-ID: <20160421151355.GA6200@sigill.intra.peff.net>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-5-git-send-email-pclouds@gmail.com>
 <CAPig+cR99Nx=dk+zT2Jgpr2ZgYM4v0q2vX7v6TXmWHU5k6ga3w@mail.gmail.com>
 <CACsJy8DwzfsPthWy6pG2t0cGVT0kcrJT7xWdyvs+0EPFDbNtSQ@mail.gmail.com>
 <CACsJy8ATaYx0Fk-7HK9Rz_o687hxCLuOJYJ6DkBd4Xk8sP+byw@mail.gmail.com>
 <CAPig+cQkT8vb-OVdS_ALVuDii9njY6BN2FhkXt=CavAfyeO2Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Reto =?utf-8?Q?Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 17:14:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atGIx-0005Tm-Up
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 17:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbcDUPOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 11:14:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:53556 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752059AbcDUPN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 11:13:59 -0400
Received: (qmail 9535 invoked by uid 102); 21 Apr 2016 15:13:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 11:13:58 -0400
Received: (qmail 9327 invoked by uid 107); 21 Apr 2016 15:13:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 11:13:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Apr 2016 11:13:56 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQkT8vb-OVdS_ALVuDii9njY6BN2FhkXt=CavAfyeO2Fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292113>

On Thu, Apr 21, 2016 at 10:23:09AM -0400, Eric Sunshine wrote:

> > While we're at it, how about renaming it to pathcmp (and its friend
> > strncmp_icase to pathncmp)?
> 
> Yes, that seems like a good idea. For anyone familiar with
> strcasecmp() or stricmp(), having "icase" in the name makes it seem as
> though it's unconditionally case-insensitive, so dropping it from the
> name would likely be beneficial.

Seconded (thirded?). I have been caught by this confusion in the past,
too.

-Peff
