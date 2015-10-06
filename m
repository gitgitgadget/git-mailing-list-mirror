From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Tue, 6 Oct 2015 15:51:01 +0200
Message-ID: <20151006135101.GA11304@distanz.ch>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
 <632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 16:00:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjSn1-0004M7-AT
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 16:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbbJFOAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 10:00:12 -0400
Received: from sym2.noone.org ([178.63.92.236]:47821 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbbJFOAL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 10:00:11 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2015 10:00:11 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3nVgDk0rfCzQWbp; Tue,  6 Oct 2015 15:51:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279147>

Hi Johannes

Thanks for your feedback.

On 2015-10-06 at 15:16:12 +0200, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> Hi Tobias,
> 
> On 2015-10-06 14:15, Tobias Klauser wrote:
> > prented_sha1_file() always returns 0 and its only callsite in
> > builtin/blame.c doesn't use the return value, so change the return type
> > to void.
> 
> While this commit message is technically correct, it would appear that there are some things left unsaid.
> 
> Is there a problem with the current code that is solved by not returning 0? If so, could you add it to the commit message? And in particular, change the oneline appropriately?

There's no problem with the current code other than that the return
value is unused and thus unnecessary for correct funcionality. So it's
certainly not a functional problem but rather a cosmetic change.

Does such a change even make sense (it's one of my first patch to git,
so I'm not really sure what your criteria in this respect are)?

If yes, would something like the following bring across the intention
more clearly?

  pretend_sha1_file() always returns 0 and its only user in
  builtin/blame.c doesn't use the returned value. Thus, the return value
  is unnecessary and the return type of pretend_sha1_file() can be
  changed to void.

Cheers
Tobias
