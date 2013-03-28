From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] t: check that a pattern without trailing slash
 matches a directory
Date: Thu, 28 Mar 2013 18:22:51 -0400
Message-ID: <20130328222251.GA15173@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328215004.GF10936@sigill.intra.peff.net>
 <CAPig+cRyPMg_icgK1+5-WdXeaAZ9ytYQgFLgbVohRJaC9qzZQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	avila.jn@gmail.com
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 23:23:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULLED-0004lW-Q5
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 23:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab3C1WW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 18:22:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44103 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab3C1WW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 18:22:57 -0400
Received: (qmail 31118 invoked by uid 107); 28 Mar 2013 22:24:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 18:24:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 18:22:51 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRyPMg_icgK1+5-WdXeaAZ9ytYQgFLgbVohRJaC9qzZQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219470>

On Thu, Mar 28, 2013 at 06:21:08PM -0400, Eric Sunshine wrote:

> On Thu, Mar 28, 2013 at 5:50 PM, Jeff King <peff@peff.net> wrote:
> > A pattern "subdir" should match any path "subdir", whether it is a
> > directory or a non-diretory.  A pattern "subdir/" insists that a
> 
> s/diretory/directory/  [1]

I think I've taken proofreading to a new level by missing the error I
already corrected somebody else for. Thanks for noticing. :)

-Peff
