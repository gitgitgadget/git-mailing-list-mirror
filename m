From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] new test from the submodule chapter of the user manual
Date: Thu, 20 Sep 2007 10:59:52 -0700
Message-ID: <20070920175952.GC30391@tasint.org>
References: <20070920003413.GJ16235@genesis.frugalware.org> <7v1wcum0ox.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709201133590.28395@racer.site> <20070920170831.GQ16235@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 20:01:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYQLD-0006wQ-Iv
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 20:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbXITSB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 14:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbXITSB0
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 14:01:26 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:37186 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbXITSB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 14:01:26 -0400
Received: from rgmgw2.us.oracle.com (rgmgw2.us.oracle.com [138.1.186.111])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id l8KI0SMx019020;
	Thu, 20 Sep 2007 12:00:28 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmgw2.us.oracle.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id l8KI0R25003087;
	Thu, 20 Sep 2007 12:00:27 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.63)
	(envelope-from <joel.becker@oracle.com>)
	id 1IYQKA-0007a9-Ss; Thu, 20 Sep 2007 11:00:26 -0700
Content-Disposition: inline
In-Reply-To: <20070920170831.GQ16235@genesis.frugalware.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58793>

On Thu, Sep 20, 2007 at 07:08:31PM +0200, Miklos Vajna wrote:
> +test_expect_success "create the submodules" '
> +	for i in a b c d
> +	do
> +		mkdir $i &&
> +		cd $i &&
> +		git init &&
> +		echo "module $i" > $i.txt &&
> +		git add $i.txt &&
> +		git commit -m "Initial commit, submodule $i" &&
> +		cd ..
> +	done

	Silly question: why use the '&&' when you can 'set -e'?  As it
currently stands, a failure will still go back around the loop...

Joel

-- 

"Sometimes when reading Goethe I have the paralyzing suspicion
 that he is trying to be funny."
         - Guy Davenport

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
