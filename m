From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Fri, 15 Jan 2016 11:51:00 +0100
Message-ID: <20160115115100.Horde.QlNwKM_-9TZQXszPUgP2qz3@webmail.informatik.kit.edu>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
 <20151220074559.GF30662@sigill.intra.peff.net>
 <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
 <20160115021237.Horde.J6jJsRTdZiG5URajzd8kKsn@webmail.informatik.kit.edu>
 <xmqqegdjk4ud.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 11:51:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK1yO-0002NJ-5C
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 11:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbcAOKvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2016 05:51:13 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35372 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753912AbcAOKvL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 05:51:11 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aK1yE-0000U5-5j; Fri, 15 Jan 2016 11:51:06 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aK1y8-0005uI-Hl; Fri, 15 Jan 2016 11:51:00 +0100
Received: from x590d6cbc.dyn.telefonica.de (x590d6cbc.dyn.telefonica.de
 [89.13.108.188]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 15 Jan 2016 11:51:00 +0100
In-Reply-To: <xmqqegdjk4ud.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1452855066.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284159>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> Quoting Junio C Hamano <gitster@pobox.com>:
>>
>>> Actually, we do not even _need_ a sharedness for this ephemeral
>>> file.  The additional "adjust-shared-perm" is merely a workaround
>>> for the fact the next person cannot write into it when it is left
>>> behind, and because we do not want to remove it when we are done.
>>
>> Do we really want to keep such a file after we are done?
>
> There is no strong reason we should want to remove them, either.
>
> As long as the lazy garbage collection works, there is no incentive
> to change things.

I'm not sure what you mean by "lazy garbage collection"; I suppose not =
=20
that I sometimes delete a stale COMMIT_EDITMSG or two by hand...
