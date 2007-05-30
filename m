From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Test for recent rev-parse $abbrev_sha1 regression
Date: Tue, 29 May 2007 22:49:49 -0700
Message-ID: <7vlkf6508y.fsf@assigned-by-dhcp.cox.net>
References: <20070530045026.GA12380@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 30 07:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtH4G-0005sE-7G
	for gcvg-git@gmane.org; Wed, 30 May 2007 07:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbXE3Ftv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 01:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbXE3Ftv
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 01:49:51 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51905 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXE3Ftu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 01:49:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070530054949.FICF2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 30 May 2007 01:49:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5Hpp1X00E1kojtg0000000; Wed, 30 May 2007 01:49:49 -0400
In-Reply-To: <20070530045026.GA12380@spearce.org> (Shawn O. Pearce's message
	of "Wed, 30 May 2007 00:50:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48740>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> My recent patch "Lazily open pack index files on demand" caused a
> regression in the case of parsing abbreviated SHA-1 object names.
> Git was unable to translate the abbreviated name into the full name
> if the object was packed, as the pack .idx files were not opened
> before being accessed.

Thanks.  As long as we catch it before it goes to 'master', it
is not a regression ;-)
