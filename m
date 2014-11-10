From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 22/22] untracked cache: guard and disable on system
 changes
Date: Mon, 10 Nov 2014 21:48:06 +0100
Message-ID: <54612486.7070709@web.de>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com> <1415439595-469-1-git-send-email-pclouds@gmail.com> <1415439595-469-23-git-send-email-pclouds@gmail.com> <545FDF22.2020404@web.de> <CACsJy8AM2pADQy8+eAsAdikW3gGKwtTjvqBzojPRCzuD1jQ+Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:48:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnvsh-00046W-Hq
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 21:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaKJUsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 15:48:07 -0500
Received: from mout.web.de ([212.227.15.14]:49370 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbaKJUsG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 15:48:06 -0500
Received: from [192.168.2.139] ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MNt4V-1XupuD3ptL-007SHy; Mon, 10 Nov 2014 21:48:03
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CACsJy8AM2pADQy8+eAsAdikW3gGKwtTjvqBzojPRCzuD1jQ+Jw@mail.gmail.com>
X-Provags-ID: V03:K0:Mx4Q1tyYtkPLcuIV7EjOUurd3mPHiXI321FyGiXZ5lh/+T40dnB
 VtN0N2kIqzxQV9eVHX3NXAF47nO4CQ8aagikEmaKb5gcJgMI463fpeGEP52qEysWrNwhpm9
 zcDpS4GXWpRZDFgfWVoleI3rSzNJBy+8TnIlzrGyiPT8uOboV+NugHZlQc9VpXKL/3jGB4i
 K94EQHuFCW2MvP1ip/PZA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2014 12:47 AM, Duy Nguyen wrote:

Some updates from the test lab, Windows 7
"Working" means git update-index --untracked-cache reports Testing...OK
"Rejected" means "..does not change.."
cygwin + NTFS: Working
cygwin + VFAT: Rejected

The same good news for Msysgit, running your github branch
(I needed to create an empty compat/win32/sys/utsname.h to get it compiled)

And I'm still not sure if we need to store the OS in the index, or if it 
is enough
to store the $pwd.
