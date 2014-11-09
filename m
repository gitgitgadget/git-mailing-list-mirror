From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sun, 09 Nov 2014 21:04:33 +0100
Message-ID: <545FC8D1.1040803@web.de>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com> <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net> <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Blume <blume.mike@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 21:04:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnYjD-0005t4-UW
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 21:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbaKIUEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 15:04:48 -0500
Received: from mout.web.de ([212.227.15.4]:56162 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbaKIUEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 15:04:47 -0500
Received: from birne.local ([78.72.74.102]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MQ8vL-1XiM3e1pgZ-005KNJ; Sun, 09 Nov 2014 21:04:41
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com>
X-Provags-ID: V03:K0:EG7rd2Uc8oCVYA1HZTqamU9now3/dlf+/SYqDC2n0CC94XvHm9P
 0kSqk0wwDmBr5TdrwdDeh1pamYWVYBRp9ErnfI45JNBzIv77M216guWqF0XqRUV3/+kSWAv
 vDXS/tEJqNp5lpxfbg0srLUbt1gJrM9FkjXuuIeoBQmS0DBBm36tzTwJJts4ON0DM3/rxre
 wCTCxt7hwkRimZOR6aOSA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.11.14 18:34, Michael Blume wrote:
> Works for me, thanks =)
> 
> I'm curious now, is there an automated build of git running on a mac
> anywhere? There's a mac mini running jenkins in my office and it's
> possible I could convince someone to let me set up a git build that'll
> e-mail me if there's a test failure.

The basic idea is to run 
make clean &&
git fetch git.git &&
git checkout git.git/pu &&
make -k test

(and pipe stdlog+stdout into a file)

I have a script here doing that, if you want, I can send it to you



 
