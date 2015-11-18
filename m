From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: race condition when pushing
Date: Wed, 18 Nov 2015 11:00:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511181057310.1686@s15462909.onlinehome-server.info>
References: <SNT153-DS223275FC4D60A266EE7E28F6290@phx.gbl> <CAPig+cSGSe=7PY7HVuAdy=4chbkkACiEBZzvDA4AktMKFiRfPw@mail.gmail.com> <alpine.DEB.1.00.1511171419130.1686@s15462909.onlinehome-server.info> <SNT153-DS16C364D3AE7608DB14B4E3F61D0@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git bug report <git@vger.kernel.org>
To: Lyle Ziegelmiller <lyle_z@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 11:01:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyzXu-0007KM-JU
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 11:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbbKRKAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 05:00:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:60897 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbbKRKAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 05:00:51 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LhOO8-1alZut1aPQ-00mYfP;
 Wed, 18 Nov 2015 11:00:43 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <SNT153-DS16C364D3AE7608DB14B4E3F61D0@phx.gbl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:jgJ/2qu53Y1ODxbxRcwkHiFBNqBT2eH6qRkaCgdKmMManC6dI1L
 zx43yc0MVWjs4+gHxcPqmuH575ZyHa9LYkT7c2T53SMRlqbkXlfCetYGWp7L8Kko4WOwSn9
 AL6vARw63zppKzbRJ9X7yNxdKff0eM7u9Xz3bJWrUFMsq9fcbsHgrtpsbuGpAV2XBqhMgSb
 jHpkOhdnjQUkCr5sTVb9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kHwti5k0cBY=:27bcf1g6qIpPAo400eGbC0
 FmcUd1ljiwQIpW9LHbDqgRYA4w+MmUvv+Bz3HohwNHKRcbhULR8qXDIPbUyUrOcQnAfew395L
 qKaDeEhe8GI2avnxUFGxOXARTz6uTaWD51K606sM55YRdiq355aEWIpPmkDAVCi78DZtvPYwG
 hnDkfLJ8+Rak4EEKUHKvlHPA3yloK/GWgAm3Gcq8E24V7ztAhMPA7bKfO8xZBBjTE5+D3543I
 GwDrT8ZlB6MIydnieebUnA8lC6eQlX2oTIhg35fRYluaB1N09XWi2EClp0qUzA1GflqQmfIkJ
 /rrowHq1yv1R7kNNZ9Ddflg69fcUVIdW9u9HGuc9A1WtavdrsHHFUAMzR0W+KNU1opvYBpovG
 SIPIRvUOp7lXzf6z8dN1F8BvmRDYMCwm2zifPNiMMHvsW0tuEqpRTH/ZkSlP/pRzzEF1vSokv
 TBEWG7uEEmwgPouCjbSkfCP6d8YFHotdYqvUlmNC5qr5X23QxsT3tgQ+vLpIVN+MUqevjNa5h
 mfVZkQXCNZQakwaCt0L25v5lcy+Gaubuj/WGwD5SISDsecj0Nig06t8ghrVxHaZUojZvYIJoJ
 ts4eM5ItY/2STx2vacudo4sRePXigz8rPoQYG04koB3bBLyiJn9RHwcKaK/94B027cVvzdsWJ
 WNosW0RIV0mD2DtKc+4FT19kxXPOf7HKInIvvN20k9E78GUvKYWyWFBHFND9i2kyaYMQZAPy7
 gZ7UdjMZRbrRvFAfyioaMlpou19iAfbSPs0EOpKl1ETHzSSiTK1Yk3d03JoojHF/7bpONhYC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281444>

Hi Lyle,

your quoting seems a bit funny; I fixed it by indenting *my* words one
more level.

On Tue, 17 Nov 2015, Lyle Ziegelmiller wrote:

> [I, Johannes, wrote:]
>
> > Please note that this code is active in Git for Windows (i.e. the
> > *MinGW* version of Git) but not in Cygwin Git (nor the MSys2 version
> > of Git).
> 
> May I suggest including this feature in Cygwin's Git, since it is
> exclusively used on Windows.

Please note that it is very easy for you to take up this task: refactor
the retry family of functions into their own file inside compat/win32/,
and a second commit to use them also in Cygwin.

> Thanks for working on Git!! :)

The best way of thanking is by contributing your own changes ;-)

Ciao,
Johannes
