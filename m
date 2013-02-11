From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:36:29 -0500
Message-ID: <20130211043629.GB12735@sigill.intra.peff.net>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4l8S-0004BO-8q
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 05:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab3BKEgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 23:36:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43984 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab3BKEgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 23:36:31 -0500
Received: (qmail 18213 invoked by uid 107); 11 Feb 2013 04:37:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Feb 2013 23:37:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2013 23:36:29 -0500
Content-Disposition: inline
In-Reply-To: <20130211043247.GD15329@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215990>

On Sun, Feb 10, 2013 at 08:32:47PM -0800, Jonathan Nieder wrote:

> Junio C Hamano wrote:
> 
> >               Are you shooting for customizability?
> 
> Yes, and the ability to generate the message dynamically.

As far as the default goes, I think the current one is OK, provided
there is an option to customize it (e.g., like your patch). Right now it
is just nonsensical to random users ("What? What in the world is
~/git-shell-commands?"). But once it is customizable, the main consumer
of the message is admins who say "What? Why isn't the git-shell I just
set up working?". The current message helps them diagnose the problem,
and when they are ready to accept connections from random users, they'll
want something customizable anyway.

-Peff
