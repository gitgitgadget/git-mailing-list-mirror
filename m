From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv3 7/8] fast-import: Add support for importing commit notes
Date: Thu, 30 Jul 2009 03:29:48 +0200
Message-ID: <200907300329.48585.johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
 <1248834326-31488-8-git-send-email-johan@herland.net>
 <20090729142121.GB1033@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 03:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWKT1-0001WU-4A
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 03:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598AbZG3B3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 21:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755174AbZG3B3u
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 21:29:50 -0400
Received: from mx.getmail.no ([84.208.15.66]:46119 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755025AbZG3B3u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 21:29:50 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK00G8PMTP2100@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 03:29:49 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK00IOHMTOT290@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 03:29:49 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.30.11821
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <20090729142121.GB1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124435>

On Wednesday 29 July 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > +static void note_change_n(struct branch *b)
> > +{
>
> ...
>
> > +	tree_content_set(&b->branch_tree, sha1_to_hex(commit_sha1), sha1,
> > +		S_IFREG | 0644, NULL);
>
> I thought you wanted to use the note code to handle the name
> formatting here?

Yes, I do, as soon as the notes code knows how to format/write note names 
(which I plan to tackle after nailing the _reading_ part of the code).


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
