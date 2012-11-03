From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Sat, 03 Nov 2012 20:07:02 +0100
Message-ID: <50956B56.1010603@web.de>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com> <501558AD.6010402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, hvoigt@hvoigt.net
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 20:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUj41-0008Rl-GQ
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 20:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab2KCTHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 15:07:10 -0400
Received: from mout.web.de ([212.227.15.4]:57106 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab2KCTHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 15:07:09 -0400
Received: from [192.168.178.41] ([91.3.179.97]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0M8iaa-1TeaQe3wUO-00CIJ4; Sat, 03 Nov 2012 20:07:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <501558AD.6010402@web.de>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:vEifEySv4A10Y9N0k0H6Fog2CUJQRP2fQPt7Pbxz4Mi
 3UGlaUpRaaQ+qbK6bDcEvs7R5N8KCsyXwqn6TZTiFLXP4STnE1
 sl/PySJWETl7R8plIb8keGfEJJkQCsAY4JZOw/7iWAEmvCHE5L
 Fgvmt4lwezd2Vz9iSIN/K1jowoEm/HUmdfjMnRgJOlJTeSMPQr
 r3J1hxOEnK1SR7DbpX5Pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208983>

Am 29.07.2012 17:37, schrieb Jens Lehmann:
> Am 27.07.2012 20:37, schrieb Stefan Zager:
>> The --jobs parameter may be used to set the degree of per-submodule
>> parallel execution.
> 
> I think this is a sound idea, but it would be good to see some
> actual measurements. What are the performance numbers with and
> without this change? Which cases do benefit and are there some
> which run slower when run in parallel?

ping?
