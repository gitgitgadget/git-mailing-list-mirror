From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATH] sed -e '/RE/r rfile/' needs space in 'r rfile'
Date: Sat, 08 Jul 2006 11:25:44 -0700
Message-ID: <7v7j2oq7h3.fsf@assigned-by-dhcp.cox.net>
References: <200607081727.10837.michal.rokos@nextsoft.cz>
	<Pine.LNX.4.63.0607081844580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 20:26:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzHVK-00024g-T1
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 20:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWGHSZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 14:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWGHSZq
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 14:25:46 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:33464 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964940AbWGHSZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 14:25:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060708182544.IEMG6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Jul 2006 14:25:44 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607081844580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 8 Jul 2006 18:47:24 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23492>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> in commit 07002287f3e219a16a948a8a6eca0a41162a491f
>> you cleaned up 'replace ugly and unportable sed invocation' as you said.
>> Please note, that some SEDs (like HP-UX one) mandate a space between 'r' 
>> and 'rfile'.
>
> Ack. Note that this is yet-another-reason to step away from scripts.

Are you talking about doing this part in the Makefile in C ;-)?
