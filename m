X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Wed, 30 Jan 2013 02:12:48 -0500
Message-ID: <20130130071248.GE11147@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <CACsJy8COCpr_CvQPhBFtVnsKztA3xgo01=zKG4WPcFfCbNTmgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
NNTP-Posting-Date: Wed, 30 Jan 2013 07:13:03 +0000 (UTC)
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Content-Disposition: inline
In-Reply-To: <CACsJy8COCpr_CvQPhBFtVnsKztA3xgo01=zKG4WPcFfCbNTmgw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1U0RrB-0004eu-A6 for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 08:13:17
 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753533Ab3A3HM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jan 2013
 02:12:56 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53828 "EHLO
 peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1753292Ab3A3HMz (ORCPT <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2013
 02:12:55 -0500
Received: (qmail 27482 invoked by uid 107); 30 Jan 2013 07:14:18 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO
 sigill.intra.peff.net) (71.206.173.132) (smtp-auth username relayok,
 mechanism cram-md5) by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jan 2013
 02:14:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jan
 2013 02:12:48 -0500
Sender: git-owner@vger.kernel.org

On Wed, Jan 30, 2013 at 10:36:10AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Jan 29, 2013 at 4:16 PM, Jeff King <peff@peff.net> wrote:
> > +int commit_metapack(unsigned char *sha1,
> > +                   uint32_t *timestamp,
> > +                   unsigned char **tree,
> > +                   unsigned char **parent1,
> > +                   unsigned char **parent2)
> > +{
> 
> Nit picking. tree, parent1 and parent2 can/should be "const unsigned char **".

Thanks, I'll fix it in the next version.

