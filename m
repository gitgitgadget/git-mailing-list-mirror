From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Error on git clone
Date: Wed, 06 Oct 2010 10:22:28 +0200
Message-ID: <4CAC31C4.5060809@viscovery.net>
References: <193301.7835.qm@web114608.mail.gq1.yahoo.com> <4CAC18C7.8020302@viscovery.net> <960844.34400.qm@web114603.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 10:23:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3PHA-0006AU-Tz
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 10:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758659Ab0JFIWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 04:22:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30242 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab0JFIWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 04:22:32 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P3PGf-0006In-GW; Wed, 06 Oct 2010 10:22:29 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 442B11660F;
	Wed,  6 Oct 2010 10:22:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <960844.34400.qm@web114603.mail.gq1.yahoo.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158272>

Am 10/6/2010 10:13, schrieb Hocapito Cheteamo:
> I could consistently reproduce the problem.  The command that I used is:
>     git clone -v git@github.com:XXX/YYY.git sss
> where XXX & YYY are replaced with the actual data.

Just to make sure: This is with "Git for Windows", not Cygwin's git?

Do the clone in separate the steps:

mkdir sss
cd sss
git remote add origin git@github.com:XXX/YYY.git
git fetch
git checkout -b master origin/master

Do you see any errors?

-- Hannes
