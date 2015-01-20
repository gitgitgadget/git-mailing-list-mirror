From: =?windows-1252?Q?Noralf_Tr=F8nnes?= <notro@tronnes.org>
Subject: Re: Git messes up =?windows-1252?Q?=27=F8=27_character?=
Date: Tue, 20 Jan 2015 21:17:49 +0100
Message-ID: <54BEB7ED.2050103@tronnes.org>
References: <54BEB08D.9090905@tronnes.org> <54BEB585.2030902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 21:18:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDfFM-00072B-Nf
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 21:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbbATURw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 15:17:52 -0500
Received: from asav22.altibox.net ([109.247.116.9]:44177 "EHLO
	asav22.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbATURv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 15:17:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by asav22.altibox.net (Postfix) with ESMTP id 9DE372014D;
	Tue, 20 Jan 2015 21:17:49 +0100 (CET)
Received: from asav22.altibox.net ([127.0.0.1])
	by localhost (asav22.lysetele.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pGvSBuqXpXrx; Tue, 20 Jan 2015 21:17:49 +0100 (CET)
Received: from [127.0.0.1] (48.81-166-104.customer.lyse.net [81.166.104.48])
	by asav22.altibox.net (Postfix) with ESMTP id 7703020142;
	Tue, 20 Jan 2015 21:17:48 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <54BEB585.2030902@web.de>
X-Antivirus: avast! (VPS 150120-1, 20.01.2015), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262687>

Den 20.01.2015 21:07, skrev Torsten B=F6gershausen:
> On 2015-01-20 20.46, Noralf Tr=F8nnes wrote:
> could it be that your "=F8" is not encoded as UTF-8,
> but in ISO-8859-15 (or so)
>
>> $ git log -1
>> commit b2a4f6abdb097c4dc092b56995a2af8e42fbea79
>> Author: Noralf Tr<F8>nnes <notro@tronnes.org>
> What does
> git config -l | grep Noralf | xxd
> say ?
>
$ git config -l | grep Noralf | xxd
0000000: 7573 6572 2e6e 616d 653d 4e6f 7261 6c66  user.name=3DNoralf
0000010: 2054 72f8 6e6e 6573 0a                    Tr.nnes.

$ file ~/.gitconfig
/home/pi/.gitconfig: ISO-8859 text
