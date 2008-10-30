From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: request for pre-generated git.info pages
Date: Fri, 31 Oct 2008 01:06:20 +0200
Message-ID: <8763n98yz7.fsf@Astalo.kon.iki.fi>
References: <ee2a733e0810291500o67b3f94fibef63e0a173e8cc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Keywords: docbook2x,db2x_texixml --to-stdout,XSLT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 09:38:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvpWt-0003qU-Mx
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 09:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbYJaIhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 04:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbYJaIhY
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 04:37:24 -0400
Received: from smtp1.dnainternet.fi ([87.94.96.108]:56220 "EHLO
	smtp1.dnainternet.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbYJaIhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 04:37:23 -0400
X-Greylist: delayed 640 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Oct 2008 04:37:23 EDT
Received: from Astalo.kon.iki.fi (85-23-32-64-Rajakyla-TR1.suomi.net [85.23.32.64])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp1.dnainternet.fi (Postfix) with ESMTP id 1B890C906
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 10:26:40 +0200 (EET)
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1Kvgaq-0008R1-IT; Fri, 31 Oct 2008 01:06:20 +0200
In-Reply-To: <ee2a733e0810291500o67b3f94fibef63e0a173e8cc1@mail.gmail.com>
	(Leo Razoumov's message of "Wed, 29 Oct 2008 18:00:45 -0400")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99565>

"Leo Razoumov" <slonik.az@gmail.com> writes:

> I am an emacs user but with my current setup I have difficulties
> generating git.info pages.

This bug in docbook2x 0.8.8 can result in empty *.texi files:
http://sourceforge.net/tracker/index.php?func=detail&aid=1912754&group_id=7856&atid=107856
`db2x_teximl' does not honor `--to-stdout'

With docbook2x 0.8.3, I successfully built git.info and gitman.info.
However, the Info browser does not recognize cross-references
between them.  I am playing with some patches to fix those.
