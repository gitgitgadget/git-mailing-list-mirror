From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Teach diff to imply --find-copies-harder upon -C -C
Date: Mon, 11 Jun 2007 22:05:01 -0700
Message-ID: <7vodjln4oy.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706112109180.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 07:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxyZ7-0004Im-N3
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 07:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbXFLFFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 01:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbXFLFFE
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 01:05:04 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53730 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbXFLFFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 01:05:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612050503.YUAE4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 01:05:03 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AV511X00E1kojtg0000000; Tue, 12 Jun 2007 01:05:02 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49918>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> earlier, a second "-C" on the command line had no effect. But since I use 
> "--find-copies-harder" quite a bit, and it is so long to type, and I am
> an inherently lazy person, I'd like the second "-C" to be a shortcut for 
> "--find-copies-harder".

Sounds good and consistent with what we do in git-blame.
