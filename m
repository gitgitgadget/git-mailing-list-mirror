From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 02 Jun 2007 03:12:19 -0700
Message-ID: <7vbqfyvf5o.fsf@assigned-by-dhcp.cox.net>
References: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	<8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
	<20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
	<alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	<7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
	<20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706020139k3beae8bbj3f51eee0ff5fd30c@mail.gmail.com>
	<7vejkuyaxq.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580706020253j4e24785cyce712460d8d1a1b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, skimo@liacs.nl,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 12:12:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuQaw-00036q-7h
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 12:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbXFBKMV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 06:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755241AbXFBKMV
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 06:12:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62140 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbXFBKMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 06:12:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602101220.VEUD9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Jun 2007 06:12:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6aCK1X0041kojtg0000000; Sat, 02 Jun 2007 06:12:19 -0400
In-Reply-To: <8c5c35580706020253j4e24785cyce712460d8d1a1b8@mail.gmail.com>
	(Lars Hjemli's message of "Sat, 2 Jun 2007 11:53:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48921>

"Lars Hjemli" <hjemli@gmail.com> writes:

> So I'll make 'git-submodule' expect the .gitmodules layout to be like this:
>
> [submodule 'xyz']
>  url=git://example.com/xyz.git
>  path=xyz1
>  path=xyz2
>
> And submodule.$name.path should be optional: if no submodule.*.path
> entry exists for a given $path, submodule $name == $path.
>
> Ok?

I do not think having more than one path for a given submodule
makes much sense, but other than that yes.
