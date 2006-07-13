From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git-daemon problem
Date: Thu, 13 Jul 2006 13:51:29 +0200
Message-ID: <E1G0zj7-0001c1-8q@moooo.ath.cx>
References: <E1G0QeX-0003hG-0I@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 13 13:51:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0zjC-0006d3-OF
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 13:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWGMLvb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 07:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWGMLvb
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 07:51:31 -0400
Received: from moooo.ath.cx ([85.116.203.178]:46731 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932452AbWGMLvb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 07:51:31 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E1G0QeX-0003hG-0I@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23826>

Here are some patches that should solve this.
Note: The first patch is not really related to this problem but I
think the die error message should go to syslog when --syslog was
used. (And I did not have to add more if-clauses.)

Documentation will follow if the changes are ok.
