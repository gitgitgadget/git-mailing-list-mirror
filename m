From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach Makefile to respect external variables: CFLAGS and others.
Date: Tue, 12 Jun 2007 23:07:56 -0700
Message-ID: <7v4plcgzer.fsf@assigned-by-dhcp.pobox.com>
References: <20070613054229.GM86872@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Jun 13 08:08:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyM1T-0004AR-TO
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 08:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbXFMGH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 02:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640AbXFMGH7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 02:07:59 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56140 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbXFMGH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 02:07:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613060757.YMPM2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Jun 2007 02:07:57 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Au7w1X00G1kojtg0000000; Wed, 13 Jun 2007 02:07:57 -0400
In-Reply-To: <20070613054229.GM86872@void.codelabs.ru> (Eygene Ryabinkin's
	message of "Wed, 13 Jun 2007 09:42:30 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50020>

I run "make CFLAGS=-O0 -g" all the time.  Also "make CC=echo"
seems to "work" as expected ;-).

Care to elaborate what problem you are trying to solve?
