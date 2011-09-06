From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Support sizes >=2G in various config options accepting
 'g' sizes.
Date: Tue, 06 Sep 2011 12:38:58 +0200
Message-ID: <4E65F842.7080601@viscovery.net>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>	<1315223155-4218-2-git-send-email-nix@esperi.org.uk>	<CAGdFq_gFNHq9Cgv4F4Q6VQ=G7odfUJ5pUFWn=OYE-BfXzP=Enw@mail.gmail.com>	<87ty8rm6th.fsf@spindle.srvr.nix> <20110906074421.GB28490@ecki>	<87ty8qjaof.fsf@spindle.srvr.nix> <4E65F451.4070900@viscovery.net> <87liu2j7c3.fsf@spindle.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:39:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0t3c-0003xi-Hp
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab1IFKjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:39:03 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24328 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab1IFKjB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:39:01 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R0t3T-0005HU-FA; Tue, 06 Sep 2011 12:38:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2BC101660F;
	Tue,  6 Sep 2011 12:38:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <87liu2j7c3.fsf@spindle.srvr.nix>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180793>

Am 9/6/2011 12:25, schrieb Nix:
> OK, I'll add range checking support then!

Don't forget to follow this advice noted on the POSIX page
(http://pubs.opengroup.org/onlinepubs/9699919799/functions/strtol.html):

Since 0, {LONG_MIN} or {LLONG_MIN}, and {LONG_MAX} or {LLONG_MAX} are
returned on error and are also valid returns on success, an application
wishing to check for error situations should set errno to 0, then call
strtol() or strtoll(), then check errno.

-- Hannes
