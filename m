From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Add sendmail -f support to git-send-email.
Date: Wed, 11 Apr 2007 00:38:27 +0200
Message-ID: <20070410223826.GH2813@planck.djpig.de>
References: <11762425341841-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 07:50:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOzY-0000uQ-Qo
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030656AbXDJWi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030653AbXDJWi7
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:38:59 -0400
Received: from planck.djpig.de ([85.10.192.180]:2946 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030656AbXDJWi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:38:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 9E98788003;
	Wed, 11 Apr 2007 00:38:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u-J4XmWDeqit; Wed, 11 Apr 2007 00:38:51 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 0920F274017; Wed, 11 Apr 2007 00:38:27 +0200 (CEST)
Mail-Followup-To: "Robin H. Johnson" <robbat2@gentoo.org>,
	git@vger.kernel.org, junkio@cox.net
Content-Disposition: inline
In-Reply-To: <11762425341841-git-send-email-robbat2@gentoo.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44188>

On Tue, Apr 10, 2007 at 03:02:13PM -0700, Robin H. Johnson wrote:
> Some mailing lists use the envelope sender instead of the actual from address,
> and this can be broken in git-send-email. This patch sets the -f argument to
> the sendmail binary, using the address of the patch author.

At least some MTAs (exim is the one I know for sure) can restrict -f
usage to some users and deny it for others. Don't know how much this
would really be a problem, but using -f unconditionally might be a bad
idea none-the-less.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
