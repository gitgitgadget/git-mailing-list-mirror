From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Using pickaxe to track changed symbol CR4_FEATURES_ADDR
Date: Mon, 5 Jun 2006 22:16:31 +0200
Message-ID: <20060605201631.GD4552@cip.informatik.uni-erlangen.de>
References: <20060605102627.GB24346@cip.informatik.uni-erlangen.de> <7v8xob4bft.fsf@assigned-by-dhcp.cox.net> <20060605131151.b8878c7c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 22:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnLV7-00053z-EY
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 22:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWFEUQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 16:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWFEUQd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 16:16:33 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:52362 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751410AbWFEUQc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 16:16:32 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 86A983044E; Mon,  5 Jun 2006 22:16:31 +0200 (CEST)
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Content-Disposition: inline
In-Reply-To: <20060605131151.b8878c7c.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21338>

Hello Randy,
I confused it. CR4_FEATURES_ADDR was in the glue code of parallels
binary only modules, but it sounded like a a MMU definition. Thanks a
lot. That was why my pickaxe did not work out in the first place.
However I have a workaround for the damn build problem.

See http://wwwcip.informatik.uni-erlangen.de/~sithglan/parallels/

Thanks,
        Thomas
