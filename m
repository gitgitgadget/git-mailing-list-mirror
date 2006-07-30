From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFC] Add the --color-words option to the diff options family
Date: Sun, 30 Jul 2006 02:57:00 +0200
Message-ID: <E1G6zc4-0007PC-9j@moooo.ath.cx>
References: <Pine.LNX.4.63.0607282354450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 02:57:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6zcI-0005kV-DT
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 02:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWG3A5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 20:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWG3A5E
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 20:57:04 -0400
Received: from moooo.ath.cx ([85.116.203.178]:60895 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750908AbWG3A5C (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 20:57:02 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607282354450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24443>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> With this option, the changed words are shown inline. For example,
> if a file containing "This is foo" is changed to "This is bar", the diff
> will now show "This is " in plain text, "foo" in red, and "bar" in green.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> ---
> 
> 	I am probably the only person who finds it useful, but there
> 	is a high coolness factor attached to it.
> 
> 	And the libxdiff library actually made it very easy to do. (Yes, 
> 	there are two nested calls to xdiff...)
I'd probably find it more useful if it would still show two lines but
only the relevant part in red/green.
