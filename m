From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Remove all files except a few files, using filter-branch
Date: Tue, 18 Sep 2012 17:10:15 +0200
Message-ID: <50588ED7.4090501@viscovery.net>
References: <CAFT+Tg_ipyPgNQxx8XsXySzmA3YM3mKe1gB5GyTNqN++gdphnQ@mail.gmail.com> <m24nmxkibw.fsf@igel.home> <CAFT+Tg-4q0mzD6rdY74WBP-0OM_SaZ_wkCAn+Gz2_eDte2a4Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 18 17:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDzRW-0002vS-4Z
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 17:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab2IRPKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 11:10:21 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:12619 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754489Ab2IRPKU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 11:10:20 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TDzRH-0003os-MI; Tue, 18 Sep 2012 17:10:15 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 677E31660F;
	Tue, 18 Sep 2012 17:10:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAFT+Tg-4q0mzD6rdY74WBP-0OM_SaZ_wkCAn+Gz2_eDte2a4Nw@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205834>

Am 9/18/2012 17:01, schrieb Yi, EungJun:
>> --index-filter "git rm --cached -qr -- . && git reset -q -- filename"
> 
> Hmm... I tried as you said, but it seems to lose history.

I think it should be '... && git reset -q $GIT_COMMIT -- filename'

-- Hannes
