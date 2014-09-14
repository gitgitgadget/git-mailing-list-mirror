From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [boinc_dev] (local ?) BOINC repo broken again -or- how to act
 on the CR/LF changes made upstream
Date: Sun, 14 Sep 2014 10:51:20 +0200
Message-ID: <54155708.7090508@web.de>
References: <541336D6.3050803@gmx.de> <1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: boinc_dev@ssl.berkeley.edu
To: Rom Walton <romw@romwnet.org>,
	=?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 10:51:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT5Wy-0007ed-QN
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbaINIvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:51:33 -0400
Received: from mout.web.de ([212.227.17.11]:55585 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493AbaINIvc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:51:32 -0400
Received: from birne.local ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MCZtW-1XcTCH01o2-009Swc; Sun, 14 Sep 2014 10:51:27
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org>
X-Provags-ID: V03:K0:8BYHM68HEbz6CZK80XXpksWVJEf3A83/SHmbGPXr6YkSsqpusN0
 3jP6k0NFuPTg1EmI36wEbhsqxgK2HzQcTcheAzi2oSU589mKyFNipqzmLhJVr3A9wClaePK
 mVJnMcEL7C+bCLiz1tPEF15N5p8+9B13s827KSL175nmcObl/bTufBaveuLPsvmjIUT78vr
 cqKAQnO3/ZBLrSfrk7nFg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257010>

On 12.09.14 20:19, Rom Walton wrote:
> Try:
> git checkout -f master
> git pull origin
> 
> I committed fixes for that stuff this morning.
> 
> ----- Rom
It seems as if we added CRLF's to the repo:

od -c     html/languages/translations/hu.po | grep "\\\r"
0577300    #   #  \r  \n   #       P   r   i   v   a   t   e       m   e

I checked the latest Git, and it handles the CRLF ok.

It may be that there is a bug in the tools you are using.
Would you mind to tell us which tools and versions you used
to create commit ce97e855d0aa188757722c2 ?
