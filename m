From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Wed, 7 Oct 2015 10:13:48 +0200
Message-ID: <20151007081344.GC11304@distanz.ch>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
 <632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
 <20151006135101.GA11304@distanz.ch>
 <ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 07 10:14:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjjrL-0007CD-PK
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 10:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbbJGINy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 04:13:54 -0400
Received: from sym2.noone.org ([178.63.92.236]:58664 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbbJGINw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 04:13:52 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3nW7jB3YQkzQWh7; Wed,  7 Oct 2015 10:13:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279175>

Hi Johannes

On 2015-10-06 at 16:30:36 +0200, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> On 2015-10-06 15:51, Tobias Klauser wrote:
> 
> > On 2015-10-06 at 15:16:12 +0200, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> >>
> >> On 2015-10-06 14:15, Tobias Klauser wrote:
> >> > prented_sha1_file() always returns 0 and its only callsite in
> >> > builtin/blame.c doesn't use the return value, so change the return type
> >> > to void.
> >>
> >> While this commit message is technically correct, it would appear that there are some things left unsaid.
> >>
> >> Is there a problem with the current code that is solved by not returning 0? If so, could you add it to the commit message? And in particular, change the oneline appropriately?
> > 
> > There's no problem with the current code other than that the return
> > value is unused and thus unnecessary for correct funcionality. So it's
> > certainly not a functional problem but rather a cosmetic change.
> 
> Okay.
> 
> > Does such a change even make sense (it's one of my first patch to git,
> > so I'm not really sure what your criteria in this respect are)?
> 
> Welcome!
> 
> As to the patch, I cannot speak for Junio, of course, but my preference would be to keep the return type. Traditionally, functions that can fail either die() or return an int; non-zero indicates an error. In this case, it seems that we do not have any condition (yet...) under which an error could occur. It does not seem very unlikely that we may eventually have such conditions, though, hence my preference.

Ok, I see. Thank you for your explanation. I'll wait for Junio's decision
then :)

Cheers
Tobias
