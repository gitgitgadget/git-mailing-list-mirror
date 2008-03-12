From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 13:35:19 -0700
Message-ID: <7vejaf65q0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
 <alpine.LSU.1.00.0803121833210.1656@racer.site>
 <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil>
 <alpine.LSU.1.00.0803122058430.1656@racer.site>
 <47D83C53.7000602@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:36:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZXgS-0006PJ-AY
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 21:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbYCLUff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 16:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753168AbYCLUff
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 16:35:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbYCLUfd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 16:35:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CB74C3F15;
	Wed, 12 Mar 2008 16:35:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 231453F0F; Wed, 12 Mar 2008 16:35:25 -0400 (EDT)
In-Reply-To: <47D83C53.7000602@nrlssc.navy.mil> (Brandon Casey's message of
 "Wed, 12 Mar 2008 15:25:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76984>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> I am not suggesting that git-gc stop parsing --prune and instead start
> erroring out on it. If it is ok to change the behavior of git-gc, it
> seems like it is ok to change the behavior of 'git-gc --prune' in the
> same way, especially if the change makes it less destructive.

Yeah, gc.pruneexpire does sound like it applies to both implicit ones and
explicit ones, doesn't it?  I think your suggestion makes sense.
