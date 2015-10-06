From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Oct 2015, #01; Mon, 5)
Date: Tue, 6 Oct 2015 05:02:25 +0200
Message-ID: <561339C1.704@web.de>
References: <xmqqwpv0x6op.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	rappazzo@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 06 05:03:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjIWu-0006ch-M8
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 05:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbbJFDCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 23:02:35 -0400
Received: from mout.web.de ([212.227.15.4]:61330 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbbJFDCf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 23:02:35 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lm4jx-1aIM9m0czZ-00ZhI3; Tue, 06 Oct 2015 05:02:31
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <xmqqwpv0x6op.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:pFOYVDjBQ8XWM2GFL/49Y09HoOjPMaoBvPFMm69lW3Dj1tKZtgp
 NwTWUB5jvukNQ8vsW28KUynns8+jwEspAe9KUIKtOB6TL2tz9fkRX3kFWMmOmhW5yfTfGYS
 0raEPBABNUDIuyWUYzPj3nyWiq9xUDizbsIYdhO78aZauzDzMu30ypQoBHf5Va8cFLctBQ/
 v5Wg90VdfczkW2PhCw+Pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PbAGowlle5c=:cyWJQU/3+E2VvnEcdyTp9p
 WfPOox85N5QV/mUeX7Nq88a5w1EToH3WP452YfHnB5vswa37vGXDSgCQMMabVmE6bBaDs02YW
 7aK+ydyvoxCxY2ZbjMS6K+bp84QYcJe7Ig0D9Mj+T/9IbI+ieF1dg8mmcFnbxGPJjhiMO0RR3
 l9eL7+15pQhdFN2uTfCu/V8Daokcsyn33E1Ixf4NLhbh6RzhxpasH/fnAMuBTjrujK1Tg0T7E
 hiCQM+cLdNtNfvV1rAm/vgQkGEci3mF01Db9OrIcpercqmKIYpysLFlFN4Rzuivkx9IGWi0EJ
 tm8din32TCAGrfLx3RsHM9a+XXc4NYjQFZdH3GLr694tqcIfPF0d0ig8A5rl0QxX10d+N6U1N
 p6TSziKEQ9CkQOd08gM0yrrnreh25lQmE08OhMTmdepI79QrKIcd4lKDibgEZoncZKyDTo0s3
 6VdHpjWoyMZFiyUJvt+bsSUuBLXA8hZzOGgfPDvQ9aTmLNvOsDIfMm5zLJ5Eoe//Uizu6POAe
 9HKs7FRNnafr2Bluapwtih+vI3VUxSNwE60yrVq0bGNs6sGKXz90RSVaitdCwAN1UcOg/VD3y
 uT1fkdAeZ39zwQkOMV5Isp1HU1hd2AI1sFmNzbSgRLlcXaC5m9QAJvGi6ykwpRlDNR6u1TRKn
 ftE27/x/ELBh2Ebls/ARqOMwagX6hUdDI2SKn5dKsGtt/SXRgnCEvgFcmQVfmdcEKdcdxSwt6
 MIcb4Uu8X37Lthl8bmsUSH+NSv+ZsS9Z217z6A0VNmC8wTkp0Ymx7PdeLNdJvDrA89pREYjC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279113>

On 2015-10-06 00.59, Junio C Hamano wrote:
> * mr/worktree-list (2015-10-02) 7 commits
>  - SQUASH???
>  - worktree: add 'list' command
>  - worktree: add details to the worktree struct
>  - worktree: add a function to get worktree details
>  - SQUASH???
>  - worktree: refactor find_linked_symref function
>  - worktree: add top-level worktree.c

Minor comment from my compiler:

worktree.c:181: warning: assuming signed overflow does not occur when assuming
that (X + c) > X is always true
