From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Docs: Add -X option to git-merge's synopsis.
Date: Mon, 12 Apr 2010 13:11:37 -0400
Message-ID: <4BC35449.4020706@xiplink.com>
References: <1271089693-21365-1-git-send-email-marcnarc@xiplink.com> <7v39z0livd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 19:13:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1NCf-0001U0-Be
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 19:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab0DLRMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 13:12:10 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:54216 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0DLRMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 13:12:07 -0400
Received: from relay24.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay24.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 371FB34E825C;
	Mon, 12 Apr 2010 13:12:04 -0400 (EDT)
Received: by relay24.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EAA0134E8257;
	Mon, 12 Apr 2010 13:12:03 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
In-Reply-To: <7v39z0livd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144757>

Junio C Hamano wrote:
> 
> This is somewhat imcomplete; the current merge-options.txt seems to be
> organized more-or-less alphabetically (begins with "commit", ascends to
> "ff", "log", "s-something", and ends with "X"), but it has acquired
> additions at random places (e.g. "ff-only").
> 
> I do not think reorganizing the option descriptions in functional groups
> is a bad idea, and if we make that an overall goal of our documentation
> set, the patch is certainly going in the right direction.
> 
> I used to prefer alphabetical order slightly over functional grouping
> because it would make things easier to find in printed pages, but these
> days people read on paper a lot less often, so I am personally fine with
> "do not list options in alphabetical order; group them with related
> features, and do so consistently across all manual pages".
> 
> So I'll take the patch as is, but before going further I would like to
> first see list concensus to such a reorganization.

I noticed the alphabetical sorting when I made the patch, so I guess my
opinion on functional grouping is pretty obvious.  FWIW, I find functional
groupings make it easier to find unknown options.  An alphabetical sorting is
really only helpful if you already know what you're looking for.  And in that
case, like you say, these docs are usually read in an electronic form, where
it's easy enough to just do a search for whatever's desired.

In any case, regardless of the consensus on this issue, alphabetical sorting
doesn't seem to make much sense for merge-options.txt given the way it's
included in git-merge.txt and git-pull.txt.

		M.
