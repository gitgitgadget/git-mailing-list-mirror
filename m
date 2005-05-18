From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: Core and Not-So Core
Date: Wed, 18 May 2005 20:35:16 +0200
Message-ID: <7i8y2cz8kb.fsf@lanthane.pps.jussieu.fr>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 18 20:43:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYTU5-0002kh-Hw
	for gcvg-git@gmane.org; Wed, 18 May 2005 20:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVERShV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 14:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVERSgq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 14:36:46 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:48841 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S262349AbVERSfX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 14:35:23 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j4IIZKVJ000405
          for <git@vger.kernel.org>; Wed, 18 May 2005 20:35:21 +0200 (CEST)
X-Ids: 165
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j4IIZJ8R019227
          for <git@vger.kernel.org>; Wed, 18 May 2005 20:35:19 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DYTO2-0000Iy-Qt
	for git@vger.kernel.org; Wed, 18 May 2005 20:35:18 +0200
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc40320505100800426d38ca@mail.gmail.com> (Jon Seymour's
 message of "Wed, 11 May 2005 01:00:33 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.165]); Wed, 18 May 2005 20:35:21 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 428B8AE8.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> To give a concrete example: the cache currently contains most of the
> posix stat structure primarily to allow quick change detection. In the
> Java world, most of the posix stat structure is not directly
> accessible via the pure-Java file system abstractions. However, for
> most purposes detecting changes to files modification time and file
> size would be enough.

I've got exactly this problem in Darcs-git; and I ignore all of the
cached data except the file size, mtime and sha1.  I don't currently
ever write to the cache.

> I think it would be worthwhile if care was taken to draw a distinction
> between the repository and the cache aspects of the git core, perhaps
> even going to the extreme of moving all knowledge of the  cache into
> cogito itself.

There's nothing that prevents you from ignoring the Git cache and
using your own cache instead.

                                        Juliusz

