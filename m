From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] Limit the number of requests outstanding in ssh-fetch.
Date: Tue, 4 Oct 2005 09:46:48 +0200
Message-ID: <200510040946.49509.sr@denx.de>
References: <Pine.LNX.4.63.0510040016110.23242@iabervon.org> <20051004071638.GA23725@localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:47:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMhWL-0004oK-Og
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 09:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVJDHrT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 03:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVJDHrT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 03:47:19 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:916 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S932492AbVJDHrS
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 03:47:18 -0400
Received: from workstation.lan (ip51cf43f8.direct-adsl.nl [81.207.67.248])
	by post.webmailer.de (8.13.1/8.13.1) with ESMTP id j947ko51006588;
	Tue, 4 Oct 2005 09:46:51 +0200 (MEST)
To: Dan Aloni <da-x@monatomic.org>
User-Agent: KMail/1.8.1
In-Reply-To: <20051004071638.GA23725@localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9669>

On Tuesday 04 October 2005 09:16, Dan Aloni wrote:
> > Lightly tested; I reduced the limit to 5, and pulled a small tree
> > successfully with some of the requests being completed early. I didn't
> > have the test case to verify that a limit of 100 is sufficiently low, but
> > handwaving suggests that it should be.
>
> Good, it seems that your patch works alright with the local Linux complete
> database fetch.

Works for me too (on a big ssh fetch, which stalled always without this 
patch).

Best regards,
Stefan
