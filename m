From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 00/16] git bisect improvements
Date: Mon, 21 Mar 2016 23:22:44 +0100
Message-ID: <56F07434.8090005@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
 <CAFZEwPPon1q_iW_xNfmVxiQhyaQh_pZpk2jzoyzi3RjJd998pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:22:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai8Dw-00087g-7C
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 23:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbcCUWWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 18:22:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:54635 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbcCUWWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 18:22:51 -0400
Received: from [192.168.1.44] ([46.239.94.225]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0Lck9X-1a2A5Z1ew3-00k77S; Mon, 21 Mar 2016 23:22:46
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
In-Reply-To: <CAFZEwPPon1q_iW_xNfmVxiQhyaQh_pZpk2jzoyzi3RjJd998pg@mail.gmail.com>
X-Provags-ID: V03:K0:cNrTqJuBwjH8R1ehFLqpVWe58s3GJf8i4yVFQLFdLIYuvawTuro
 H1GNjV5VG1CyNAdIDe5BlBjAf6q+IeFYexmBLviMZFT/3xpzCSdoaUtlK3KxlQrDSpQDFfa
 EbChg3HbIparOLEJg07IBuSE/D92JnhVBGZZXsQqiDxges2bBUEXVd3dyUKyjzH0zkNb8wj
 6g2mwhvWlPEhyHQKmopgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GLTquqp1bhA=:MQgmkBICul3DYUgxgFMrBQ
 6S+/8dZYtFPXpjok0vgcSnQZzwNThAErM93lyT/DMelVwIliXJtZuS8UgzIEVK+8nuEW1LdBD
 4CMxLOxwri7awVkznT/ducmQY6eJ03RavLCHFrjAZBkeIq5vt+bSjVROMig5qVtJMAfnejbIi
 Fk3QkNLNy1DZAtUKy3htvzO9SgQV6O5p5iFiSZW4eIloBOQ7s6fGFrxJBVscfeULTbUskmGvn
 EIWAOOwYLwsTd48UtEvV3doChtYTawB76bXZiJg2m/iElMWgZ5baqIDfzORAVO9lO3sKyPaRv
 L3UoYpjhwRdB5lghvop9VlLTFnZ0QlbPVDiegxGssywI4WbxIOnr7eW3FCV8Wg1QUBTR2gbBl
 l8EJ0sboz5yHYy7/wSGqLsYvqYDc8t1OX0aaarc4/d8PsF/Y0l8VsiMZ/u+e35NOJAnAI4CTa
 YgFxDKj8TCg2MIyvg1OuYSSyadmimAhPmIsimxKJPwBUB4rb0GkUWZEbtN1A7JzaCrDk7/F9g
 QgE7IZJC9BUCkIGUqUvsy03PFSRtAH0qc6TsZ/rRKtMrCMNzNdcP5h0hQRoNRyQXzOvook5pl
 dwvEnkcCai91ZAClPX+T1UBpQb0fr2SDpiaBubj6wedPch6wC5y+7rIanRR1x+F5tkTcvWfJx
 VvnRGowFNNfY0gpleOKE0bG+OyYiG/lnao+tHUqJmwPlByAIA7aG6whH6yQnbs/Jmi9yqcdI5
 cQQPTBXb6k9NopTURc2qvDmXq4MGboArOCmQPZcdtynmbUbf/KRsVEY3iFKUuuLTO9vK6Qul 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289471>

Hi Pranit,

On 03/20/2016 07:50 PM, Pranit Bauva wrote:
> I have been recently following this series of patches and it seems a
> bit stale. These patches haven't been followed up with improvement
> patches.

I'm on vacation at the moment.

Patchset v1 contains some bugs. So I just updated the branch on
github[1] for you which is the state-of-the-art for patchset v2. Note
that it also contains an odd bug (which seems to exist before my patches
but turns to light after my patches) but I haven't found time to
investigate it further before my vacation started. (That's also why I
didn't post any updates on that topic to the list.)

1. https://github.com/sbeyer/git/commits/bisect

Also sorry, I am not following the list so I didn't know there was a
GSoC project for bisect.

> If it is okay with you then can I work more upon these
> patches in my GSoC project.

I'm totally fine with that, of course. :)

Thanks,
Stephan
