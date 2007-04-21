From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible bug in --short option of git-rev-list
Date: Sat, 21 Apr 2007 02:34:14 -0700
Message-ID: <7vps5yul49.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550704210232v7a214aa7jc5f55fe26edbf8e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamamo" <junkio@cox.net>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 11:34:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfBz0-0006iQ-Kt
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 11:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbXDUJeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 05:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbXDUJeQ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 05:34:16 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:46934 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbXDUJeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 05:34:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421093415.RLIA1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Apr 2007 05:34:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id plaE1W0051kojtg0000000; Sat, 21 Apr 2007 05:34:14 -0400
In-Reply-To: <e5bfff550704210232v7a214aa7jc5f55fe26edbf8e3@mail.gmail.com>
	(Marco Costalba's message of "Sat, 21 Apr 2007 11:32:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45157>

"Marco Costalba" <mcostalba@gmail.com> writes:

> From git tree
>
> $ git rev-parse v1.5.1.1 HEAD
> c5ec6d00eb063f547e314fdf8a1d8cf09472da6b
> 744747ef1d75c85fb3a1785cb08d36497128d3d3
> $ git rev-parse --short v1.5.1.1 HEAD
> c5ec6d0
> 744747e
> fatal: Needed a single revision
> $
>
> Output is correct, but at the end an (bogus?) error is reported an
> git-rev-parse command exits with error code.

Short is abbrev + verify.  This is not new.
