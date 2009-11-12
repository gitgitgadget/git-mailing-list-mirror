From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release workflow
Date: Thu, 12 Nov 2009 09:10:55 +0100
Message-ID: <200911120910.57091.trast@student.ethz.ch>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm> <7vzl6soniu.fsf@alter.siamese.dyndns.org> <4AFB57A3.2020002@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Nov 12 09:12:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Umm-0002l9-LD
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 09:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbZKLIL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 03:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZKLIL6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 03:11:58 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:18551 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbZKLIL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 03:11:57 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 12 Nov
 2009 09:12:01 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 12 Nov
 2009 09:11:40 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.29-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <4AFB57A3.2020002@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132746>

Raman Gupta wrote:
> Junio C Hamano wrote:
> > Please set the tone straight.  If this is to suggest various possible
> > workflows in general vague terms, "may use" would be good.  If this is to
> > precisely describe what I do, then there won't be "you could do this, or
> > you could do that."  Your "may use" suggests the former, but the commit
> > log message claims the latter.  Which document are you writing?
> 
> Ok. The current document is inconsistent. In places it uses "the
> maintainer" and in other places it uses "you". In any case, it seems
> that the "maintainer" here is not "Junio Hamano" -- rather, it is the
> reader.
> 
> Let me create a separate (and first) cleanup patch to fix the existing
> inconsistencies in this man page. I would prefer to use the pronoun
> "you" consistently as also suggested by Thomas Rast.

Well, I'm not sure if this is also in reply to my comment

} The current gitworkflows is mostly formulated in the imperative, [...]
} or by directly describing the tools in the third person, [...]

but note that I do not consider the current form to be inconsistent
(though you may of course convince me otherwise).  It addresses the
presumed user with "you", which is not always the maintainer.  For
example, when talking about patch submission we have

  If the maintainer tells you that your patch no longer applies to the
  current upstream, you will have to rebase your topic (you cannot use a
  merge because you cannot format-patch merges):

since the presumed user of a patch-submission workflow is a
contributor, not the maintainer.  Indeed much of the text talks
*about* the workflow used by our esteemed maintainer, but is addressed
to a contributor who wants to understand how it works so he can
participate.

IOW, I'm neither a native speaker nor a professional writer, so you
may of course convince me that there is something to fix.  I am,
however, fairly sure that s/maintainer/you/ and then fixing the
grammar is *not* a good thing.

[BTW, it would have been nice to get a Cc to begin with, since the
entire manpage blames to me.  I noticed the thread anyway, but other
times I do not have the time to scan the entire list.]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
