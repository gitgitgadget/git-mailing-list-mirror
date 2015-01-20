From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Git messes up =?windows-1252?Q?=27=F8=27_character?=
Date: Tue, 20 Jan 2015 21:07:33 +0100
Message-ID: <54BEB585.2030902@web.de>
References: <54BEB08D.9090905@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?windows-1252?Q?Noralf_Tr=F8nnes?= <notro@tronnes.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 21:07:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDf5R-0003Bg-FK
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 21:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbbATUHh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 15:07:37 -0500
Received: from mout.web.de ([212.227.15.14]:59836 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbbATUHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 15:07:36 -0500
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0M6Dve-1Xoq0i2bgg-00yBGC; Tue, 20 Jan 2015 21:07:34
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54BEB08D.9090905@tronnes.org>
X-Provags-ID: V03:K0:DGiQZWEfNXjWuJkJIQt2ksvndfXE5puffEKWbZguOmg7m3Ip7Ba
 /Dzv66/EuE9GFEdlMZs4XZhui/076oK9tMqOrpwkJ7vOx6du7ovjAiiosGCCO786JVU3elf
 GGHi9sqKGhtlXNVTxAE4Hazk2lyiCl57F4uM7Z0u/nX7PXkoRmdhs0Jn5ESuJyEHfpG1bi7
 p0IevxqDxZEEl9tPd+MWQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262686>

On 2015-01-20 20.46, Noralf Tr=F8nnes wrote:
could it be that your "=F8" is not encoded as UTF-8,
but in ISO-8859-15 (or so)

> $ git log -1
> commit b2a4f6abdb097c4dc092b56995a2af8e42fbea79
> Author: Noralf Tr<F8>nnes <notro@tronnes.org>
What does=20
git config -l | grep Noralf | xxd
say ?
