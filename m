From: Miles Bader <miles@gnu.org>
Subject: Re: Usability of git stash
Date: Mon, 20 Oct 2008 18:36:05 +0900
Message-ID: <buor66bd2wq.fsf@dhapc248.dev.necel.com>
References: <87wsg9acfv.fsf@cup.kalibalik.dk>
	<nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil>
	<86vdvsg4up.fsf@lola.quinscape.zz>
	<vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil>
	<87prly5k5r.fsf@cup.kalibalik.dk> <20081019184029.GF14786@spearce.org>
	<20081019231239.GA23692@leksak.fem-net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 17:29:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrrCu-0006i2-UN
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 11:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbYJTJge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 05:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbYJTJge
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 05:36:34 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:49896 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYJTJgd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 05:36:33 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m9K9a6q7011475;
	Mon, 20 Oct 2008 18:36:06 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay11.aps.necel.com with ESMTP; Mon, 20 Oct 2008 18:36:06 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay11.aps.necel.com with ESMTP; Mon, 20 Oct 2008 18:36:06 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id EEF6139; Mon, 20 Oct 2008 18:36:05 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20081019231239.GA23692@leksak.fem-net> (Stephan Beyer's message
	of "Mon, 20 Oct 2008 01:12:39 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98674>

Stephan Beyer <s-beyer@gmx.net> writes:
> I, for example, have a stash in which some "valgrind ..." string is
> prepended to some lines in some test scripts.  I apply the stash on
> different branches and after testing I reset the file (or checkout -f
> another branch).  I never really want to commit these changes.

I'd just use an appropriate patch file kept around in a parent dir or
something... :-)

-Miles

-- 
People who are more than casually interested in computers should have at
least some idea of what the underlying hardware is like.  Otherwise the
programs they write will be pretty weird.  -- Donald Knuth
