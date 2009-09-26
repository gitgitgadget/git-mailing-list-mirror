From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found by the clang static analyzer
Date: Sat, 26 Sep 2009 20:21:28 +0200
Message-ID: <871vltefdj.fsf@master.homenet>
References: <87ab0hepcn.fsf@master.homenet>
	<alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 26 20:21:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrbu0-0007NF-BO
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 20:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbZIZSVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 14:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbZIZSVi
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 14:21:38 -0400
Received: from joe.mail.tiscali.it ([213.205.33.54]:58237 "EHLO
	joe.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZIZSVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 14:21:37 -0400
Received: from master.homenet (84.223.203.227) by joe.mail.tiscali.it (8.0.022)
        id 49EC55CD047B070D; Sat, 26 Sep 2009 20:21:40 +0200
Received: from gscrivano by master.homenet with local (Exim 4.69)
	(envelope-from <gscrivano@gnu.org>)
	id 1Mrbth-00015M-3r; Sat, 26 Sep 2009 20:21:29 +0200
In-Reply-To: <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de> (Johannes
	Schindelin's message of "Sat, 26 Sep 2009 17:58:43 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129164>

Hello,


Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I understand that clang complains when argc is not really used afterwards, 
> but do we really want to do this?  I mean, if somebody decides it'd be a 
> good idea to check the number of arguments after parsing the arguments, 
> they might be bitten by the fact that it is now actively wrong.

probably this is not the only case to leave as it is.  I just cleaned
anything clang reported.

Cheers,
Giuseppe
