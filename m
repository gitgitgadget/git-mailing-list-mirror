From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Hanging "git mv" on Windows bug report
Date: Tue, 19 May 2015 15:41:26 +0200
Organization: gmx
Message-ID: <b4a67dd0e303e009a02055e2cb8785d5@www.dscho.org>
References: <CANSw7Kw7A_kn6yue9TnvGSO9dFzvX8AUZkn0W98Euf384CbnFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yuval Greenfield <ubershmekel@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 15:41:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuhm1-0000qA-PM
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 15:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbbESNl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 09:41:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:59045 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754476AbbESNl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 09:41:28 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MUZKF-1Yl7HZ3XGN-00RJ3k; Tue, 19 May 2015 15:41:26
 +0200
In-Reply-To: <CANSw7Kw7A_kn6yue9TnvGSO9dFzvX8AUZkn0W98Euf384CbnFA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:SFrDqAY8PHiinrvPR4s/CuJRcvY3dIbzO5YYwAwNtVHFeGSc8N/
 DGzU+y6P7bR6edwwtTMvDlvCc9NDlUi2baTEf+vMqO62ExdKy1/9JaA+UDHXBZ3fBCsmLTf
 6nWiKy0boXY1wvQWSkQES6wqbPwIZONTflPBn8jHCus/a5O9Hyo/+wtrJ41rpLnKH/q+KSM
 mfjaNygfrJb/c6N08KNSw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269356>

Hi Yuval,

On 2015-05-18 08:50, Yuval Greenfield wrote:

> Here is the command sequence that causes git to stop responding:
> 
> mkdir mynewthing
> cd mynewthing
> git init
> mkdir abc
> touch abc/myfile
> git add abc/myfile
> git commit -a -m "whatever"
> git mv abc tmp
> git mv tmp Abc
> 
> I wanted to change the case of a committed folder. Since windows is
> case insensitive that's a bit harder. Perhaps with this version it's
> impossible?
> 
> Here's my git bash banner - "Welcome to Git (version
> 1.9.5-preview20141217)". I'm on Windows 8.1 Pro.

I just tried this with Git for Windows 2.4.1.1 (developers' preview) from https://git-for-windows.github.io/ and it did not hang here (currently on a Windows 7 box). Could you try that and see whether it works for you?

Ciao,
Johannes
