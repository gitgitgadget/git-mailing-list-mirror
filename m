From: David Brown <git@davidb.org>
Subject: Re: [PATCH] git-send-email: Generalize auto-cc recipient mechanism.
Date: Tue, 25 Dec 2007 21:32:21 -0800
Message-ID: <20071226053221.GA4499@old.davidb.org>
References: <7vk5n2o58p.fsf@gitster.siamese.dyndns.org> <1198641389-959-1-git-send-email-git@davidb.org> <BAYC1-PASMTP131135B69209F6EB72F809AE5B0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org, Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Dec 26 06:32:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7Osu-0005by-40
	for gcvg-git-2@gmane.org; Wed, 26 Dec 2007 06:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbXLZFcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 00:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbXLZFcY
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 00:32:24 -0500
Received: from mail.davidb.org ([66.93.32.219]:56441 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbXLZFcX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 00:32:23 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J7OsP-0001vp-9g; Tue, 25 Dec 2007 21:32:21 -0800
Mail-Followup-To: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <BAYC1-PASMTP131135B69209F6EB72F809AE5B0@CEZ.ICE>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69242>

On Tue, Dec 25, 2007 at 11:54:38PM -0500, Sean wrote:

>But i wonder about the case where a user has "sendemail.suppresscc = all" in their
>~/.gitconfig.   For the occasion when they do want to cc the author of
>a patch, what do they do?  The above UI seems to lack a way to enable a cc option
>that has been disabled by default.

Well, in that instance, --no-suppress-from would override that, if I did it
right.  Perhaps we could add an unsuppress-cc option, but then the whole
thing is starting to get more complicated than I think it really needs to
be.

My suggestion would be to keep this patch as is, and if the people using it
decide they want the override option, we/I can figure out how to add it.

Dave
