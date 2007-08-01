From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git clone error
Date: Tue, 31 Jul 2007 17:22:35 -0700
Message-ID: <7vlkcwdrxw.fsf@assigned-by-dhcp.cox.net>
References: <C2D525CB.2A81%denbuen@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Denis Bueno" <denbuen@sandia.gov>
X-From: git-owner@vger.kernel.org Wed Aug 01 02:22:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG1z7-0003dh-K9
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 02:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759326AbXHAAWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 20:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759492AbXHAAWh
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 20:22:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:54865 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759326AbXHAAWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 20:22:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801002236.DWMS1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 31 Jul 2007 20:22:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WQNb1X00e1kojtg0000000; Tue, 31 Jul 2007 20:22:36 -0400
In-Reply-To: <C2D525CB.2A81%denbuen@sandia.gov> (Denis Bueno's message of
	"Tue, 31 Jul 2007 17:45:47 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54383>

"Denis Bueno" <denbuen@sandia.gov> writes:

> ...  The error I see is:
>
>     git[14] > git clone /Volumes/work/scripts/
>     Initialized empty Git repository in /tmp/git/scripts/.git/
>     remote: Generating pack...
>     Done counting 80 objects.
>     remote: error: unable to unpack b28b949a1a3c8eb37ca6eefd024508fa8b253429
> header
>     fatal: unable to get type of object b28b949a1a3c8eb37ca6error:
> git-upload-pack: git-pack-objects died with error.
>     fatal: git-upload-pack: aborting due to possible repository corruption
> on the remote side.
>     remote: aborting due to possible repository corruption on the remote
> side.

First thing to check would be...

>     fatal: early EOF
>     fatal: index-pack died with error code 128
>     fetch-pack from '/Volumes/work/scripts/.git' failed.

        $ cd /Volumes/work/scripts
        $ git fsck --full
