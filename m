From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] config.c: fix writing config files on Windows network
 shares
Date: Tue, 30 Jun 2015 16:52:31 +0200
Organization: gmx
Message-ID: <085261f3bbd5d5a14fb038d9909927f8@www.dscho.org>
References: <20150528075142.GB3688@peff.net>
 <20150528075443.GB23395@peff.net> <5592A8E5.2090601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 16:52:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9wtx-0000tc-F1
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 16:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbbF3Owl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 10:52:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:60778 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbbF3Owk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 10:52:40 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MLj5z-1Z9fuq097j-000q7e; Tue, 30 Jun 2015 16:52:35
 +0200
In-Reply-To: <5592A8E5.2090601@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:S6MWZhx3Bi3B20Uvc/ueGdtlIMp3y1mlqg9NU0a+/dOmdXYpu7S
 UOqpNeYCeJuXS8FZygRmXn0qwH4KfYbn/jiRQAgaiIKVyRCpuZtfQ0T8IVZOSCYQPKYWd2T
 TaLK3zbObEQJJwAToX9FqYNungi+wKZnPjO++2S7kfZYz68ek20zRmvY4z4HQFMJaLb0GxS
 JOigi1MieZjheuoLGxVsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+pTW+kaShCw=:MXkuY6lHj2WUNFRFBW9LPO
 FdPF243by2GuuKlWS6Tf112N6ofSmDMYbliuwbKC1xUhfb+yWhueLl84Hzo4BZVArsneps2Oy
 4r3RWQFt89eCgWmebggMwf49UJZ+WfN1tTMWSt/iQr2nybjbANvSEgjoGxObgmS6oXDUgo8aA
 TqlVocQYX88MK4oIfL9vZhIMzRtM2mCZWSFBZuo2S5RhOsDEeHiogecJ6CCtDgfT8yxlP067v
 L0SCd1XJDFMnSPDvZ6w+ETXmE+41NqSfKBOX3Mx1EKAzmYOtZ4Re/4muFXlk9vQRCjFmG6cOk
 Kjk+2I8jKw88W3a8QNIjtipMWVkMWyXJOgrDfPsyLTjaxnWSRAjJTsAzfx2CPWG0q05dzMdhv
 modVX3X36bbuTD45Q5buCTC2z9lEWCKc5lSZmSATMsp0dM3RcohEQA1OP38nZTi/RePBbmjip
 NOWsECQ/Kg2TR4a69971uKIw4h7MlkBmcWpQeeXEdtaW4Z1xO7PfPy1RNkDLKDfYkOfSA+Frt
 EN+pMf+8TlDg2Fff3nhuxZDE1MPQGF6HRXVLhbSAY1OrSZDae0WlPvtJBfSzUQStAA0ZyAyOM
 bxR2Z37UxTr6YjJ5Nqs9jdZlR8EyMdqsG9I34fQhfzVZrPz+Zi3M4vsmcFs2jjxJgZmOxfufK
 c9NsW7Z0qfxC/2e+Cr4lmfuA9Tinmk9GB0WnOXxi2uIvbswdqkQiXjZx3ykkiLAGm6+o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273068>

Hi,

On 2015-06-30 16:34, Karsten Blees wrote:
> Renaming to an existing file doesn't work on Windows network shares if the
> target file is open.
> 
> munmap() the old config file before commit_lock_file.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>

ACK.

Thanks,
Dscho
