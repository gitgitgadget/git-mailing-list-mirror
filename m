From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Support sizes >=2G in various config options accepting
 'g' sizes.
Date: Tue, 06 Sep 2011 12:22:09 +0200
Message-ID: <4E65F451.4070900@viscovery.net>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>	<1315223155-4218-2-git-send-email-nix@esperi.org.uk>	<CAGdFq_gFNHq9Cgv4F4Q6VQ=G7odfUJ5pUFWn=OYE-BfXzP=Enw@mail.gmail.com>	<87ty8rm6th.fsf@spindle.srvr.nix> <20110906074421.GB28490@ecki> <87ty8qjaof.fsf@spindle.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0snL-0002wo-B8
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab1IFKWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:22:14 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8654 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab1IFKWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:22:12 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R0snB-0002Fu-Kp; Tue, 06 Sep 2011 12:22:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5287C1660F;
	Tue,  6 Sep 2011 12:22:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <87ty8qjaof.fsf@spindle.srvr.nix>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180785>

Am 9/6/2011 11:13, schrieb Nix:
> ... amounts to writing our own strtol()
> specifically for this one case, to see if the parsed number is
> too long.

Why so? strtol() can report overflow:

RETURN VALUE

    ...
    If the correct value is outside the range of representable values,
{LONG_MIN}, {LONG_MAX}, {LLONG_MIN}, or {LLONG_MAX} shall be returned
(according to the sign of the value), and errno set to [ERANGE].

-- Hannes
