From: Jon Loeliger <jdl@freescale.com>
Subject: Some Documentation/Usage Notes
Date: Mon, 05 Dec 2005 23:21:38 -0600
Message-ID: <E1EjVGk-00015M-Np@jdl.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 06:23:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjVGp-0007Zn-QG
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 06:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVLFFVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 00:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVLFFVk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 00:21:40 -0500
Received: from www.jdl.com ([66.118.10.122]:17637 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964810AbVLFFVk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 00:21:40 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EjVGk-00015M-Np
	for git@vger.kernel.org; Mon, 05 Dec 2005 23:21:39 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13253>


Note to $self -- here are some tidbits ToDo:

o   --help  doesn't work on:
        git-hash-object
	git-init-db
	git-write-tree

o   There is an odd <any-file-on-the-filesystem> argment named
    in the git-hash-object documentation.  Would <file> be better
    and more consistent?  Or is there some subtlety that I am missing?

o   Someone might want to check my --template=<dir> description
    on git-init-db, or make it clearer.

o   Work towards moving uniform description of all environment
    variables in one includable/referenceable Documentation/ file?
