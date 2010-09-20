From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git performance after directory copy
Date: Mon, 20 Sep 2010 13:48:16 +0200
Message-ID: <4C974A00.8030905@viscovery.net>
References: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp> <vpq62y0hh63.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gaer\, A." <Andreas.Gaer@baslerweb.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 20 13:48:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxerC-0001o9-N2
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 13:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756272Ab0ITLsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 07:48:19 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43575 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755350Ab0ITLsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 07:48:18 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Oxer2-00062Q-VP; Mon, 20 Sep 2010 13:48:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B21D21660F;
	Mon, 20 Sep 2010 13:48:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
In-Reply-To: <vpq62y0hh63.fsf@bauges.imag.fr>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156618>

Am 9/20/2010 11:56, schrieb Matthieu Moy:
> But I'm surprised that the next "git status" are still slow. Other
> people may get a better explanation, but this very much looks like a
> bug.

Most likely, Andreas works with 1.7.1. From the release notes of 1.7.1.1:

 * "git status" stopped refreshing the index by mistake in 1.7.1.

-- Hannes
