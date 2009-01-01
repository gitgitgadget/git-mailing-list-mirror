From: jidanni@jidanni.org
Subject: Re: [PATCH] Documentation/git-bundle.txt: Dumping contents of any bundle
Date: Fri, 02 Jan 2009 06:12:56 +0800
Message-ID: <87fxk2u13r.fsf@jidanni.org>
References: <20090101192153.GA6536@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nico@cam.org, gitster@pobox.com, mdl123@verizon.net,
	spearce@spearce.org, git@vger.kernel.org
To: peff@peff.net, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Thu Jan 01 23:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIVo7-0006Lq-TL
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 23:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbZAAWNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 17:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbZAAWNB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 17:13:01 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:60939 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752599AbZAAWNA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 17:13:00 -0500
Received: from jidanni.org (122-127-33-68.dynamic.hinet.net [122.127.33.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 1137BC517F;
	Thu,  1 Jan 2009 14:12:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104334>

JK> Maybe it would be worth adding an option to dump the uncompressed
JK> deltas to a file or directory so you could run "strings" on them
JK> to recover some of the data.

I got as far as these wheezy little bytes,
$ ls ??/*|tr -d /|sed q|xargs git cat-file tree|perl -pwe 's/[^\0]+[\0]//'|hd
00000000  ae 83 2f 22 45 89 2d dd  e5 22 13 57 46 64 48 b4  |../"E.-..".WFdH.|
00000010  09 77 51 42                                       |.wQB|
before I ran out of tools to crack it. It must be in some standard git
gzip format. There should be a command line tool to crack it with
provided in the git suite.

Anyways, one day some forensics department will need to crack one of
these things, and I want the instructions available.

JS> Just for the record: this is in so many ways not a commit message I want
JS> to have in git.git.  I hope it is not applied.
Is that where they end up? Oops, please reword it for me, anybody.
