From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] merge: do not contaminate option_commit with
 --squash
Date: Wed, 27 Apr 2016 08:46:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604270846200.2896@virtualbox>
References: <874mb0kkkk.fsf@gmail.com> <alpine.DEB.2.20.1604180825170.2967@virtualbox> <CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com> <87a8krpehl.fsf@gmail.com> <CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
 <xmqqy48a6fht.fsf@gitster.mtv.corp.google.com> <xmqqtwiy6end.fsf@gitster.mtv.corp.google.com> <xmqqk2jkdpjr.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:46:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avJFI-0008SO-Bz
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 08:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbcD0Gqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 02:46:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:60595 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbcD0Gqo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 02:46:44 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MNYxW-1b2UFT2z98-007Aev; Wed, 27 Apr 2016 08:46:37
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqk2jkdpjr.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Kx8dz7Q4TrZY8YBqsHLoksEct7mKMN9p8OAPkBtbUOi/TNagZN7
 kM9c++fDgHcxuIQCT30x2D+lIKAzMseHE9Z0miRFgkWvE+xBsHCNEdHmmMulTywpO+u6H37
 bIlT8H3mlS+K5g339AynhCDc2u8M7hEcY/n/a8Pcz9p7hEUBbb/PazTJ2ZWz6Vxan13PeeE
 HTd2YNfybPDrKBs+aW9jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nY+dQCLvKDw=:c+s4n4QzgIMW/68EiGLVnG
 mmmrxT2jeaSa0mpGll8RQvvRTgsvsQD5Fkv34n4C8mpMHun+RwyrS94pIISLI/qIKCjps8um5
 nfIFBlEXI4OXTshu7tJ7Vey1Q0loT3Dq+WcH5YaRigHHnTNVufRexRQl8lEnuWeFdgs7nYhbp
 wvcd5/7WpKU7sLiFZLvYm8bRgBSOEwFtsAHWpG8cmEfF3865rItAcJ1vXmubRHRBziLDjicpt
 dgO8VioBM5UwZQFNKNUQcxHuh6Xf/pxXvE98QpBVXQlCONVknAnurPG0UkbNnH5DOvqFHwHv/
 5YENAPfDrOa5iNeLNZQRb0RkLncfcixGl43a5V044CE+vnMbnjke3BQbVv+UAR+lMvdJRLJDO
 bEO+YeEodH/303PQLmH693wNoufSw8uJs94AY6eYtVeEQTg08VfgA10njhjkBj4fnaaDjTEby
 HVwPVL0Ug9gzbMJ+wCENVx/KqZXe332hPii2/WeDR8P8dFeqsnU3xH8+h6JhwjD7ZCORzUT31
 uLFRHHJLi0H87rkNIVOW80v9XFLjqk6RK5Ts1AyzhVybzUqsvpegX9CJWSdlc6NCqk05kxWpU
 F2b++zhIJTz1gFpeN05EXTXX4ZiweA4qBkUtdizYymiD0gx3Sxu5yaM1kHe+hPT+TjslzER/t
 wchHx7ZsKV9w5nAmdq/T1LndcYegnEx1y4af7InE0PTW2661x6FvErnnqWVOANFSriNbCuaI5
 jea6g5tO5dZQkInMBWlpxnjqmZCHS3mbh60IkG7WmcK5ppc8Td1vM/gXdzcbeoI5DqgksN8k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292710>

Hi Junio,

On Tue, 26 Apr 2016, Junio C Hamano wrote:

> It is true that we do not make a commit when we are asked to do
> "merge --squash", and the code does so by setting option_commit
> variable to zero when seeing the squash option.  But this made it
> impossible to see from the value of option_commit if --no-commit was
> given from the command line, or --squash turned it off.
> 
> We check for the value of option_commit at only two places.  Check
> for the value of squash at them, too.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Just a preliminary clean-up for the next one which is on topic.

I think it would make for a nice cleanup anyways.

Ciao,
Dscho
