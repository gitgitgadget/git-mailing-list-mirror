From: jaalto <jari.aalto@cante.net>
Subject: Re: 1.7.7.3 wishlist: add --verbose option to git-tag
Date: Tue, 3 Jan 2012 22:28:21 +0200
Message-ID: <20120103202821.GB19131@cante.cante.net>
References: <87d3b51vr0.fsf@cante.cante.net>
 <7vk458tuzq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:39:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiB8W-0006pU-0R
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab2ACUjC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:39:02 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:41945 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab2ACUjB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:39:01 -0500
X-Greylist: delayed 632 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jan 2012 15:39:00 EST
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 36FE6EF8D5;
	Tue,  3 Jan 2012 22:28:27 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A018D132FAB; Tue, 03 Jan 2012 22:28:27 +0200
Received: from cante.cante.net (a91-155-176-245.elisa-laajakaista.fi [91.155.176.245])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id C7CB5158A62;
	Tue,  3 Jan 2012 22:28:24 +0200 (EET)
Received: from jaalto by cante.cante.net with local (Exim 4.77)
	(envelope-from <jaalto@cante.cante.net>)
	id 1RiAy7-00035t-PN; Tue, 03 Jan 2012 22:28:24 +0200
Content-Disposition: inline
In-Reply-To: <7vk458tuzq.fsf@alter.siamese.dyndns.org>
X-Gpg-Key-Id: 0xD189E680
X-Gpg-Key-Info: http://key-server.de:11371/pks/lookup?search=0xD189E680&op=vindex
X-Gpg-Key-Get: ttp://key-server.de:11371/pks/lookup?search=0xD189E680&op=get
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jaalto@cante.cante.net
X-SA-Exim-Scanned: No (on cante.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187894>

On 2012-01-03 12:02, Junio C Hamano wrote:
| Jari Aalto <jari.aalto@cante.net> writes:
| 
| > In scripts it would be useful if "git tag" would provide option:
| >
| >     --verbose
| >
| > As in script:
| >
| >     git tag --verbose -m "Initial import" upstream/1.0
| 
| What does the proposed "--verbose" produce that makes scripts easier to
| write

Not "easier write", but to display progress to user; show what is
hapening. Similarly to other --verbose options. Messgae could be:

	  "tagged: upstream/1.0 asd1234"

Jari
