From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 09 Jul 2014 19:21:58 +0200
Message-ID: <53BD7A36.2030300@kdbg.org>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de> <xmqqsimddrq3.fsf@gitster.dls.corp.google.com> <53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?Torsten_B=F6gers?= =?ISO-8859-1?Q?hausen?= 
	<tboegi@web.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:22:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4vZJ-0002ln-IC
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 19:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433AbaGIRWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 13:22:04 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:12306 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755337AbaGIRWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 13:22:03 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 56DF01000B;
	Wed,  9 Jul 2014 19:22:00 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 71CD519F364;
	Wed,  9 Jul 2014 19:21:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53BC47BD.1000705@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253135>

Am 08.07.2014 21:34, schrieb Jens Lehmann:
>> And Msysgit complains 
>> error: fchmod on c:/xxxt/trash directory.t7613-merge-submodule/submodule_update_repo/.git/modules/sub1/config.lock failed: Function not implemented
> 
> I'm not sure what this is about, seems to happen during the "cp -R" of
> the repo under .git/modules into the submodule.

No. It happens because fchmod() is not implemented in our Windows port.

Please see my band-aid patch at
http://thread.gmane.org/gmane.comp.version-control.git/248154/focus=20266
The sub-thread ended inconclusive.

-- Hannes
