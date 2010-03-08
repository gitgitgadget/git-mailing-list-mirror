From: Tait <git.git@t41t.com>
Subject: Re: core.autocrlf considered half-assed
Date: Mon, 8 Mar 2010 10:57:19 -0800
Message-ID: <20100308185719.GQ2480@ece.pdx.edu>
References: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de> <20100307092701.GC31105@dpotapov.dyndns.org> <alpine.LFD.2.00.1003071538350.30214@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 08 19:58:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Noi9y-0006EL-IC
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 19:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab0CHS6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 13:58:30 -0500
Received: from ehlo.cat.pdx.edu ([131.252.208.106]:45221 "EHLO
	ehlo.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab0CHS63 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 13:58:29 -0500
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by ehlo.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o28IvKj5000765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Mar 2010 10:57:20 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o28IvKDw016730;
	Mon, 8 Mar 2010 10:57:20 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o28IvJvk016729;
	Mon, 8 Mar 2010 10:57:19 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003071538350.30214@localhost.localdomain>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ehlo.cat.pdx.edu [131.252.208.106]); Mon, 08 Mar 2010 10:57:20 -0800 (PST)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on ehlo.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at ehlo.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141778>

> I do agree. It would probably have been a good idea to mark the CRLF
> status in the index, but we didn't...

We already have .gitattributes for tracking information about files. Maybe
add an attribute to describe the in-repository line endings? The default
would be LF, as now, and a new attribute could change the checked-in
format to be CRLF.

Tait
