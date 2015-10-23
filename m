From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 1/5] gc: remove unused #include "sigchain.h"
Date: Fri, 23 Oct 2015 09:25:28 +0200
Message-ID: <20151023072527.GR2468@distanz.ch>
References: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
 <1445517810-13998-2-git-send-email-tklauser@distanz.ch>
 <xmqqk2qer78a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 09:25:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpWjI-0002ui-Ma
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 09:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbbJWHZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 03:25:32 -0400
Received: from sym2.noone.org ([178.63.92.236]:53419 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbbJWHZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 03:25:31 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3nhxt16kCczQWh2; Fri, 23 Oct 2015 09:25:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqk2qer78a.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280087>

On 2015-10-22 at 22:14:29 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > After switching to use the tempfile module in commit ebebeaea (gc: use
> > tempfile module to handle gc.pid file), no declarations from sigchain.h
> > are used in builtin/gc.c anymore. Thus, remove the #include.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> 
> I'll drop this one as we seem to have gained another user of the API
> in this file in the nd/gc-auto-background-fix topic.

Opps, sorry I didn't check against 'pu' carefully enough. Thanks for
catching it.
