From: Sven Verdoolaege <skimo@liacs.nl>
Subject: rev-parse, unknown arguments and extended sha1's
Date: Fri, 24 Jun 2005 14:24:36 +0200
Message-ID: <20050624122436.GA15182@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 14:19:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dln9D-0002qH-OB
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 14:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVFXMY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 08:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVFXMY7
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 08:24:59 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:45463 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S261826AbVFXMYy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 08:24:54 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5OCOadE026037;
	Fri, 24 Jun 2005 14:24:41 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id B60E46FEA; Fri, 24 Jun 2005 14:24:36 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Is git-rev-parse supposed to echo arguments it doesn't understand ?
It currently does, but git-checkout-script seems to think it doesn't:

                rev=$(git-rev-parse "$arg")   
                if [ -z "$rev" ]; then
                        echo "unknown flag $arg"
                        exit 1
                fi

Also, is there any reason why the extended sha1 notation
is restricted to the scripts and not used in the actual
plumbing ?

skimo
