From: Junio C Hamano <junkio@cox.net>
Subject: Re: [GIT PULL] Please pull mergetool.git
Date: Wed, 14 Mar 2007 00:03:46 -0700
Message-ID: <7v4poogvcd.fsf@assigned-by-dhcp.cox.net>
References: <E1HRI5K-0008T9-9e@candygram.thunk.org>
	<20070314055923.GA20978@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 08:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRNWZ-0005v7-Bn
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 08:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbXCNHDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 03:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030683AbXCNHDt
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 03:03:49 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54992 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030682AbXCNHDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 03:03:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314070348.NLU2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 03:03:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aX3n1W0041kojtg0000000; Wed, 14 Mar 2007 03:03:48 -0400
In-Reply-To: <20070314055923.GA20978@spearce.org> (Shawn O. Pearce's message
	of "Wed, 14 Mar 2007 01:59:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42178>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Why not use `git checkout-index --stage=all "$path"` ?
> E.g.:
>
> 	git checkout-index --stage=all "$path" |
> 	read base_temp local_temp remote_temp path

$ echo a b c d | read a b c d; echo "<$a> <$b> <$c> <$d>"
<> <> <> <>
