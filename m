From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 02 Jun 2007 02:15:13 -0700
Message-ID: <7vejkuyaxq.fsf@assigned-by-dhcp.cox.net>
References: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	<8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
	<20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
	<20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
	<alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	<7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
	<20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706020139k3beae8bbj3f51eee0ff5fd30c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 11:15:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuPhp-0003JY-Uw
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 11:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbXFBJPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 05:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbXFBJPQ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 05:15:16 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42464 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbXFBJPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 05:15:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602091514.ZBNK5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Jun 2007 05:15:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6ZFD1X0021kojtg0000000; Sat, 02 Jun 2007 05:15:13 -0400
In-Reply-To: <8c5c35580706020139k3beae8bbj3f51eee0ff5fd30c@mail.gmail.com>
	(Lars Hjemli's message of "Sat, 2 Jun 2007 10:39:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48917>

"Lars Hjemli" <hjemli@gmail.com> writes:

> But why would we want to design .gitmodules in a way that makes it
> hard to do the mapping from path to url?

Perhaps because "path" is not the "identity" of the subproject, but
the (logical) subproject name is?
