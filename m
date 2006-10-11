From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] RPM gurus? (Re: rpmbuild fails)
Date: Tue, 10 Oct 2006 17:38:12 -0700
Message-ID: <7v64erznyj.fsf_-_@assigned-by-dhcp.cox.net>
References: <pan.2006.10.10.20.31.48.692444@alarsen.net>
	<200610110018.19035.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anders Larsen <al@alarsen.net>
X-From: git-owner@vger.kernel.org Wed Oct 11 02:40:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXS79-0007KO-AV
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 02:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030733AbWJKAiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 20:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030735AbWJKAiO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 20:38:14 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:921 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030733AbWJKAiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 20:38:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011003813.KPEG22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 20:38:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YoeG1V0091kojtg0000000
	Tue, 10 Oct 2006 20:38:16 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200610110018.19035.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Wed, 11 Oct 2006 00:18:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28686>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Tuesday 10 October 2006 22:31, Anders Larsen wrote:
>> The current git fails when building rpms:
>> 
>> 	RPM build errors:
>> 	    Installed (but unpackaged) file(s) found:
>> 	   /usr/lib/perl5/vendor_perl/5.8.6/Git.pm
>
> I got the same.
> I'm no rpm guru, but changing %{perl_vendorarch} into
> %{perl_vendorlib} in git.spec.in helped for me.
>
> Obviously, the generated perl/Makefile installs Git.pm
> into the perl vendor *library* directory, and not the arch
> one.

Thanks.

Also I noticed that we now build-require perl(Error); I have to
ask kernel.org people to install it.
