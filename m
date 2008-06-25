From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 19:57:54 -0700
Message-ID: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
References: <20080621121429.GI29404@genesis.frugalware.org>
 <7vwskfclfs.fsf@gitster.siamese.dyndns.org>
 <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
 <20080624160224.GA29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806241709330.9925@racer>
 <20080624185403.GB29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806242007150.9925@racer>
 <7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
 <20080624221049.GE29404@genesis.frugalware.org>
 <7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
 <20080624233236.GI29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 04:59:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLEA-00069I-5J
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 04:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbYFYC6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 22:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbYFYC6L
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 22:58:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYFYC6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 22:58:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F84716956;
	Tue, 24 Jun 2008 22:58:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8AC6916952; Tue, 24 Jun 2008 22:58:01 -0400 (EDT)
In-Reply-To: <20080624233236.GI29404@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 25 Jun 2008 01:32:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A50A862-4262-11DD-95A2-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86199>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Jun 24, 2008 at 04:16:36PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> It most likely makes sense to do (3) anyway.  upload-pack, receive-pack,
>> anything else?
>
> I think that's all.

Then that would be this patch on top of nd/dashless topic.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 929136b..babf16b 100644
--- a/Makefile
+++ b/Makefile
@@ -1268,7 +1268,7 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_TCLTK
