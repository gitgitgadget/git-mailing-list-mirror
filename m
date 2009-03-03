From: Jeff King <peff@peff.net>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 03:27:06 -0500
Message-ID: <20090303082706.GC3158@coredump.intra.peff.net>
References: <1235865822-14625-3-git-send-email-gitster@pobox.com> <20090301031609.GA30384@coredump.intra.peff.net> <7v63itbxe7.fsf@gitster.siamese.dyndns.org> <20090301100039.GD4146@coredump.intra.peff.net> <20090301170436.GA14365@spearce.org> <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org> <20090303070937.GB30609@coredump.intra.peff.net> <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org> <20090303080603.GA3158@coredump.intra.peff.net> <7v63irf21u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:28:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePzg-0007yz-6w
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbZCCI1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbZCCI1L
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:27:11 -0500
Received: from peff.net ([208.65.91.99]:47773 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbZCCI1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:27:10 -0500
Received: (qmail 13830 invoked by uid 107); 3 Mar 2009 08:27:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 03:27:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 03:27:06 -0500
Content-Disposition: inline
In-Reply-To: <7v63irf21u.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112029>

On Tue, Mar 03, 2009 at 12:22:53AM -0800, Junio C Hamano wrote:

> Yes and no.  I think "git shell" sites fall broadly into two categories.
> The ones arranged ala gitosis without per-user UNIX account, it certainly
> is an issue.  The ones with per-user UNIX account would not let anywhere
> other than $HOME written, so it is not.

Right. My problem is that for the former case, there is no switch.
People upgrading git would just get this new feature which has security
implications. So I think any patch needs to default to "off".

> My sole interest lies in building a track record of suggested patches to
> eliminate the excuse people would use to complain that we do not attempt
> to allow repositories to be created remotely.  I've shown two possible
> ways.  It now is turn for those who want to have the feature to fill in
> the details.  These are weatherbaloon patches, and it is not my itch to
> scratch anyway.

Well, that's sneaky of you. ;P

But I think that coincides with what I was trying to say in my original
response to the series, which is "this issue is complex, and we need to
hear from the people who would really want this exactly what it is they
want".

-Peff
