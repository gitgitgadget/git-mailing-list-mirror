From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sat, 05 May 2007 23:38:27 -0700
Message-ID: <7vwszmfod8.fsf@assigned-by-dhcp.cox.net>
References: <463BD40C.6080909@gmail.com>
	<Pine.LNX.4.64.0705050324580.4015@racer.site>
	<7vwszolz26.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
	<Pine.LNX.4.64.0705051637450.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 06 08:38:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkaOA-0003qp-1C
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbXEFGia (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 02:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698AbXEFGia
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:38:30 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62818 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbXEFGi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 02:38:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506063829.TGET6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 02:38:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vieU1W0021kojtg0000000; Sun, 06 May 2007 02:38:28 -0400
In-Reply-To: <Pine.LNX.4.64.0705051637450.4015@racer.site> (Johannes
	Schindelin's message of "Sat, 5 May 2007 16:39:00 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46303>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> (a) In a bare repository, I believe setup.c:setup_git_directory_gently()
>> determines the prefix to be NULL.  This means my patch will see
>> ALL paths as absolute,  except :../path which will result in an error.
>
> My point was that it feels inconsistent to take the current path into 
> account in one case, but not in the other.

I do not understand your reasoning.  In a bare repository you
cannot even be in a subdirectory to begin with.
