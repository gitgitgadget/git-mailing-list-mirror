From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] log: make --abbrev-commit's ellipsis configurable
Date: Fri, 13 Feb 2009 16:32:26 +0100
Message-ID: <4995928A.5000908@viscovery.net>
References: <alpine.DEB.1.00.0902131445390.10279@pacific.mpi-cbg.de> <1234535092-20133-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 13 16:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY03D-00020l-9G
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 16:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbZBMPcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 10:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757569AbZBMPcd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 10:32:33 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:49169 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZBMPcc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 10:32:32 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LY01j-0006Tf-1q; Fri, 13 Feb 2009 16:32:27 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B85E769F; Fri, 13 Feb 2009 16:32:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1234535092-20133-1-git-send-email-trast@student.ethz.ch>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109754>

Thomas Rast schrieb:
> So we introduce a new variable format.abbrevEllipsis that defaults to
> true (previous behaviour).

How about format.hideAbbrevDots that defaults to false? Then you can write
in the config file:

    [format]
         hideAbbrevDots

(note: without '= true').

Even though I usually detest double negations (and I would count
hideAbbrevDots=false as one), the ability to set the non-default value of
a Boolean variable in this way trumps my taste.

-- Hannes
