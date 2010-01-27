From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: git-format-patch should include a checksum
Date: Wed, 27 Jan 2010 02:25:40 +0100
Message-ID: <7ir5pccp9n.fsf@lanthane.pps.jussieu.fr>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr>
	<7vljfkxxj9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 02:32:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZwlq-000745-Ct
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 02:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab0A0Bc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 20:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789Ab0A0Bc2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 20:32:28 -0500
Received: from shiva.jussieu.fr ([134.157.0.129]:49416 "EHLO shiva.jussieu.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747Ab0A0Bc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 20:32:27 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2010 20:32:27 EST
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.14.3/jtpda-5.4) with ESMTP id o0R1Pfdm031316
          for <git@vger.kernel.org>; Wed, 27 Jan 2010 02:25:42 +0100 (CET)
X-Ids: 165
Received: from lanthane.pps.jussieu.fr (Debian-exim@lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.4/jtpda-5.4) with ESMTP id o0R1Pep5027221
          for <git@vger.kernel.org>; Wed, 27 Jan 2010 02:25:40 +0100
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.69)
	(envelope-from <jch@pps.jussieu.fr>)
	id 1NZwf6-0004DF-Pm
	for git@vger.kernel.org; Wed, 27 Jan 2010 02:25:40 +0100
In-Reply-To: <7vljfkxxj9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 26 Jan 2010 15:21:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.94.2/10334/Tue Jan 26 15:23:11 2010 on shiva.jussieu.fr
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138100>

> Do you have an example of such corrupted and incorrectly applied patches?
> What kind of corruption are you talking about?

The commit message getting rewrapped.  For some reason, the patch itself
was not corrupted.

Another case is that of the commit message having its non-ASCII
characters corrupted.

> adding a checksum over the entire output and forcing a check upon
> application is really a bad idea, even though, provided if the patch
> is done cleanly, it might be acceptable as an optional feature.

The part I really care about is that git-format-patch should include
a checksum by default.

I'd be quite happy if git-am only warned about a checksum mismatch.

Linus:

> That wouldn't work either. People can, should, and do add extra things to 
> the message before applying it.

Shouldn't they remove the checksum line at the same time as they edit
a patch?

                                        Juliusz
