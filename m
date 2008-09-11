From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: What's in git.git (Sep 2008, #02; Wed, 10)
Date: Thu, 11 Sep 2008 11:09:53 +0200
Message-ID: <48C8E061.5030904@fastmail.fm>
References: <7viqt3tk8b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 11:11:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdiCt-0006J4-KE
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 11:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbYIKJKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 05:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYIKJKD
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 05:10:03 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52243 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751792AbYIKJKC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 05:10:02 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 63BF4160551;
	Thu, 11 Sep 2008 05:10:01 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 11 Sep 2008 05:10:01 -0400
X-Sasl-enc: 7lR3+Hmp07hMQ0R4AQxzqFcoAxlsDV4GDNLKMS+5FtVz 1221124201
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CB8D23A214;
	Thu, 11 Sep 2008 05:10:00 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <7viqt3tk8b.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95598>

Junio C Hamano venit, vidit, dixit 11.09.2008 05:49:
> There are still a few topics that are meant for 'maint' cooking in higher
> stages; we will have 1.6.0.2 after they are merged down.
> 
> On the 'master' front, it looks like 1.6.1 will not have anything
> particularly big like 1.6.0 did.  Other than many s/git-foo/git foo/
> updates in tests (finished -- the documentation needs to go through the
> same process), there are many small bells and whistles enhancements, but

Was there some final consensus on how to undashify the man pages? There
is still the issue of keeping man viewers working which detect links
from man page text like git-commit(1). Within a man page context forms
like that are natural and should not be confusing (assuming man users
know man), but for the html version it's unnatural. In fact, even the
section numbers look unnatural on the html version (pretending to be a
non-man-unaware html "customer"); also, the html doc is not split into
subdirs by section.

I think the cleanest approach would consist in introducing another
linkgit macro (for everything linkgit:git-) which ouputs dashed resp.
dashless forms for docbook (i.e. man) resp. html targets. I'll cook up a
POC if noone keeps me from doing so ;)

Michael

P.S.: There are also dashes to be removed in the text (non-link) of the
doc, of course. But this doesn't pose any technical hurdles.
