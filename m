From: Christoph Hellwig <hch@lst.de>
Subject: Re: git-cvsimport fuzzy commit log matching?
Date: Tue, 23 Dec 2008 16:16:43 +0100
Message-ID: <20081223151643.GA18657@lst.de>
References: <20081223110302.GA9376@lst.de> <46a038f90812230453m4122e018l2cc22be3f40ab630@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 16:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF91t-0005TQ-Lv
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 16:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbYLWPQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 10:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbYLWPQv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 10:16:51 -0500
Received: from verein.lst.de ([213.95.11.210]:59869 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbYLWPQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 10:16:51 -0500
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id mBNFGhIF018735
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Dec 2008 16:16:43 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id mBNFGhJt018733;
	Tue, 23 Dec 2008 16:16:43 +0100
Content-Disposition: inline
In-Reply-To: <46a038f90812230453m4122e018l2cc22be3f40ab630@mail.gmail.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103828>

On Tue, Dec 23, 2008 at 10:53:42AM -0200, Martin Langhoff wrote:
> What you could do is
> 
>  1 - run cvsps with export to a file (I've posted in this list how to
> run it exactly as cvsimport does)
>  2 - post-process cvsps ouput with perl (there's a parser already in
> cvsimport ;-) )
>  3 - run cvsimport with the post-processed file
> 
> Or postprocess the imported git tree as others have suggested.

Instead of post-processing I hacked cvsps.  It already has a different
way to detect changesets when running in --bkcvs mode, and re-using that
one for ptools works great.
