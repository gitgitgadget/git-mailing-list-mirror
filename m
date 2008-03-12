From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 12:12:21 -0700
Message-ID: <7viqzr69ka.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
 <alpine.LSU.1.00.0803121833210.1656@racer.site>
 <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <alpine.LSU.1.00.0803122005330.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:13:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZWOB-00066X-Vr
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbYCLTMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbYCLTMn
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:12:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbYCLTMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:12:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B48A131F3;
	Wed, 12 Mar 2008 15:12:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ED61A31F2; Wed, 12 Mar 2008 15:12:31 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803122005330.1656@racer.site> (Johannes
 Schindelin's message of "Wed, 12 Mar 2008 20:07:23 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76975>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, so I just remove the !approxidate() check.  Then, "gc.pruneExpire = 
> never" should work as you expect it to.

Huh?  date.c::special[] has "never" defined for this exact reason.
