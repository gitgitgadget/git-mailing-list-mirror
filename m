From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Teach cat-file a --quiet option
Date: Sun, 22 Apr 2007 00:56:42 -0700
Message-ID: <7virboq1tx.fsf@assigned-by-dhcp.cox.net>
References: <20070422011447.GC2910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 09:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfWwB-0002MR-KB
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 09:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965440AbXDVH4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 03:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965461AbXDVH4o
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 03:56:44 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49529 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965440AbXDVH4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 03:56:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422075644.GNRA1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 03:56:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q7wi1W00U1kojtg0000000; Sun, 22 Apr 2007 03:56:43 -0400
In-Reply-To: <20070422011447.GC2910@spearce.org> (Shawn O. Pearce's message of
	"Sat, 21 Apr 2007 21:14:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45225>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Sometimes when you get the content of a file in a script you don't
> want an error message for missing files; instead its OK to treat
> a missing file the same as one whose content was empty.
>
> This is especially true if the script is using something like
> `cat-file blob HEAD:path/to/file` to look at an optional file's
> content.

I am not sure if I agree with this logic.  How is this different
from discarding stderr to /dev/null?
