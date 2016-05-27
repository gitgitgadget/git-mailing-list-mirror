From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [Bug?] log -p -W showing the whole file for a patch that adds to
 the end?
Date: Fri, 27 May 2016 19:13:32 +0200
Message-ID: <5748803C.6030007@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <xmqq7fej5njv.fsf@gitster.mtv.corp.google.com> <5746B9AE.5050307@web.de>
 <xmqqr3cowy0x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 19:14:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6LLE-000070-SD
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932855AbcE0ROI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 13:14:08 -0400
Received: from mout.web.de ([212.227.17.12]:61411 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569AbcE0ROF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:14:05 -0400
Received: from [192.168.178.36] ([79.237.62.121]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MZlMw-1aoHHM0wpC-00LWIs; Fri, 27 May 2016 19:13:42
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqqr3cowy0x.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:vMAh99cm5WIDVwVR+/am4IKzS3UYrbZ1MjpwczQRQbfj06SIiPc
 /nJVZV/smYkR0FjnhOekRCs+9LZK36FVFwysi56T2mUhxGGcSiHO2J0Kbfv1vIOsxOixd4k
 Fh0aJGO5a1MnAphD78G41zUqCbhRlDjhg7OdWmhF08nZoUQSZkHqdidRILaio/YqxVxz4SJ
 NP0XII8kbTWzaclbuAa2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZF3WnzbRqkY=:4RpLsRYyONfdyepL433Eu9
 BKxEyz+HEuideoarv49V02vIUSQo2ZfwOlBmP1xuolvVVpuxgjmGz47cLuUWqTQSmqxJj6Fge
 a/E5hGBQweYulOIFZFEkqGXqfPuPTVt7BkvnGMiFIqTusp/gtW66ewCRW49hz+QbAUKPH5+xw
 gSb/QswTWVErzADm/jHOKvAW8m68UY3IGcA1EqW57D/e/xiBLxJ2logtgsR0WnMJjzd36uzLi
 CvbrCLpBQWhPwE9Zc27vokzCUk1g6M+9D9/W4mUxbRTbO6yRlqoUEB1onazfYoFAK8zlBej1c
 1SHt+ssSLx+z0K8E1jSJKAVqfh+ZIxGsMH9Q1hEWTvGMm+Dv9fE2IqWMEMxZ958O3FzpFmYj6
 oRoUT9IrLx93ojpDzCTgIGUdxpoZc5RaoVGAg1LuAk1oVzWDuIgmRIZBav2tIzcAKXg/Hgj1Y
 62drewPoEm5I7SEiePOZESTmcgDg9Ij9lJLADoF3uVYKN7wU2Jzjke8AXWuKQ0jZehjFQGUwl
 SZcXc12ehEgs7IBenrmx065619UcRVApvSMwVvjQfZ6IQMXwz1rEuz5BmC82KL+c5CCvH/gFk
 TLMrh+WPNfL0/YwZHgcK845FvKY4WPLUf12t8wKvVP6uhKCjb3jswNNBYArkPLraT3OmGSnRP
 ogakzA019e3+YPmt//c32q62WmhwkR1CvCYTbX+GmH49LE7xiCkt+bGjTksOmyUFyR7oHgEPV
 RkXJ/SnqBEtCYoqdG0QiUTK1QSu3Hcczy3LEi9H3/ARE8ics2I9CfKOEalkIdRPJbfPaGHmQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295775>

Am 26.05.2016 um 19:05 schrieb Junio C Hamano:
> I'd say that these patches are fine as they are, and follow-up patch
> for adding -W tests (instead of rerolling them) is sufficient,
> though.

Patch 3 needs two small updates to address the char signedness issue=20
found by Ramsay and to get rid of an unused function parameter, and=20
patch 4 needs a small change as a result of the latter as well.=20
Shouldn't be long before tests are done..

Ren=C3=A9
