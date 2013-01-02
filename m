From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] build: do not automatically reconfigure unless
 configure.ac changed
Date: Wed, 2 Jan 2013 03:38:37 -0500
Message-ID: <20130102083837.GA9328@sigill.intra.peff.net>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
 <20130102072141.GB18974@elie.Belkin>
 <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com>
 <20130102082544.GD18974@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 09:42:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqJud-000796-3i
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 09:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab3ABIim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 03:38:42 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41219 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587Ab3ABIil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 03:38:41 -0500
Received: (qmail 28324 invoked by uid 107); 2 Jan 2013 08:39:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jan 2013 03:39:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2013 03:38:37 -0500
Content-Disposition: inline
In-Reply-To: <20130102082544.GD18974@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212504>

On Wed, Jan 02, 2013 at 12:25:44AM -0800, Jonathan Nieder wrote:

> Starting with v1.7.12-rc0~4^2 (build: reconfigure automatically if
> configure.ac changes, 2012-07-19), configure is automatically run
> every time the "configure" script changes.  In particular, that
> means configure is automatically rerun whenever the version number
> changes (which changes the configure script to support "./configure
> --helpe"), which makes bisecting painfully slow.
> 
> The intent was to make the reconfiguration process only trigger for
> changes to configure.ac's logic.  Tweak the Makefile rule to match
> that intent by depending on configure.ac instead of configure.

It seems I am late to the party. But FWIW, this looks the most sane to
me of the patches posted in this thread.

-Peff
