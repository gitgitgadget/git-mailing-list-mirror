From: jidanni@jidanni.org
Subject: Re: [PATCH] Documentation/git-bundle.txt: Dumping contents of any bundle
Date: Sat, 03 Jan 2009 06:03:43 +0800
Message-ID: <87mye9wekg.fsf@jidanni.org>
References: <20090102082709.GA3498@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, johannes.schindelin@gmx.de, nico@cam.org,
	gitster@pobox.com, mdl123@verizon.net, git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Fri Jan 02 23:05:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIs8k-00015s-2Y
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578AbZABWDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757972AbZABWDs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:03:48 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:53847 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757851AbZABWDs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jan 2009 17:03:48 -0500
Received: from jidanni.org (122-127-35-226.dynamic.hinet.net [122.127.35.226])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 32A2E414C1;
	Fri,  2 Jan 2009 14:03:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104428>

Some options are:

1) just add a line or two to my man page patch showing
what recovery can and can't presently be done. (No need for my
temporary file, use a pipe too.)

2) Also implement that step where everything is uncompressed and put
into lost+found, and document that they should expect to just see a
lot of connector markings, and if there are useful strings in there
then they are just lucky. We did the job asked: recovered to the best
extent of what they gave us.

JK> So I am inclined to leave it as-is: a patch in the list archive. If and
JK> when the day comes when somebody loses some super-important data and
JK> somehow matches all of these criteria, then they can consult whatever
JK> aged and senile git gurus still exist to pull the patch out and see if
JK> anything can be recovered.

I've read too many cases in RISKS Digest, news:comp.risks, about years
later organizations trying to recover some weird format or media.
Therefore I urge you to strike while the iron is hot and hook up the
function into the code.

Maybe some have never tried to recover data, but for those that one
day might, they will be thanking you over and over for taking this
opportunity to give them a chance. In many cases the few shreds they
can recover might be all they need.

Also one can see the innards of git -- no more black box.

If I were creating a new binary format, I would be sure to also
provide decoder tools. Otherwise it is just like it requires its own
proprietary environment to reveal any of its innards. Sure, you can
say well that data is mainly useless... but it is better than nothing
-- we did the best with what they gave us.
