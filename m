From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v3 1/2] trailer: use fprintf instead of printf
Date: Thu, 14 Jan 2016 10:33:45 +0100
Message-ID: <20160114093345.GG26950@distanz.ch>
References: <1452688989-13746-1-git-send-email-tklauser@distanz.ch>
 <1452688989-13746-2-git-send-email-tklauser@distanz.ch>
 <xmqqd1t5nv6j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 10:34:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJeIK-0003pv-H7
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 10:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbcANJdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 04:33:52 -0500
Received: from sym2.noone.org ([178.63.92.236]:55765 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbcANJds (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 04:33:48 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ph0nl1P97zQWhH; Thu, 14 Jan 2016 10:33:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqd1t5nv6j.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284025>

On 2016-01-13 at 20:20:04 +0100, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > Use fprintf instead of printf in trailer.c in order to allow printing
> > to a file other than stdout. This will be needed to support in-place
> > editing in git interpret-trailers.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> Thanks.  I won't bother to amend it myself or request you to reroll
> only for this, but that is a rather suboptimal title.

Agree.

> The distinction between fprintf/printf is an implementation detail;
> what you want to do in this change is to allow writing to a file
> other than the standard output, and that should be in the title.

Since I'll do a v4 anyhow to address Eric's review comments, I can
change the title in the reroll.

Thanks
