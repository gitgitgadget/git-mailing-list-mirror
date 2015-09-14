From: Jeff King <peff@peff.net>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Mon, 14 Sep 2015 00:59:54 -0400
Message-ID: <20150914045953.GA11039@sigill.intra.peff.net>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
 <20150913101727.GB26562@sigill.intra.peff.net>
 <CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
 <20150914043016.GA10167@sigill.intra.peff.net>
 <CAPc5daUBBPRxaaptTS9xyr+pJ6Fgt4XXi+MU=DSZeoQ6uHCHvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeffrey Walton <noloader@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 07:00:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbLs1-0002sc-HQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 07:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbbINE75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 00:59:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:58584 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751276AbbINE74 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 00:59:56 -0400
Received: (qmail 22801 invoked by uid 102); 14 Sep 2015 04:59:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Sep 2015 23:59:56 -0500
Received: (qmail 23403 invoked by uid 107); 14 Sep 2015 05:00:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Sep 2015 01:00:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2015 00:59:54 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daUBBPRxaaptTS9xyr+pJ6Fgt4XXi+MU=DSZeoQ6uHCHvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277805>

On Sun, Sep 13, 2015 at 09:57:08PM -0700, Junio C Hamano wrote:

> On Sun, Sep 13, 2015 at 9:30 PM, Jeff King <peff@peff.net> wrote:
> >
> > Ah, OK. Today I learned something. :)
> >
> > Jeffrey, can you produce a tested patch which works for you?
> 
> If I am not mistaken, I think I already have one on 'pu' (I think I did that
> as an afternoon-tea time hack or something).

Oh, indeed. ac179b4d9. Looks good to me.

My follow-up question was going to be: is this something we should be
setting in config.mak.uname for appropriate versions of Darwin? It
wasn't clear to me from Eric's description if this is something that
particular versions need, or just something that people who want to
build Universal binaries would choose to use.

-Peff
