From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible BUG in 'git log -z' last commit is not '\0' terminated
Date: Fri, 22 Jun 2007 14:29:35 -0700
Message-ID: <7vlkebada8.fsf@assigned-by-dhcp.pobox.com>
References: <e5bfff550706221227x4b785698taabfa7572bf8204b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 23:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1qhH-0002Do-GK
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 23:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115AbXFVV3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 17:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759116AbXFVV3h
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 17:29:37 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38335 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759071AbXFVV3g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 17:29:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070622212934.HKSG3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Jun 2007 17:29:34 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ElVa1X00Q1kojtg0000000; Fri, 22 Jun 2007 17:29:35 -0400
In-Reply-To: <e5bfff550706221227x4b785698taabfa7572bf8204b@mail.gmail.com>
	(Marco Costalba's message of "Fri, 22 Jun 2007 21:27:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50709>

I am a bit busy right now and do not have time to dig into this,
but I suspect the LF you are seeing at the end belongs to the
commit log of the last entry, as I think -z is not about
termination but separation.
