From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] apply, ls-files: simplify "-z" parsing
Date: Sun, 31 Jan 2016 12:59:46 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601311259090.2964@virtualbox>
References: <20160131112215.GA4589@sigill.intra.peff.net> <20160131113546.GF5116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 13:00:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPqgH-0002QG-DT
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 13:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355AbcAaMAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 07:00:31 -0500
Received: from mout.gmx.net ([212.227.15.15]:54016 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757303AbcAaMAC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 07:00:02 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MEWkb-1aIvhk1Ner-00Fk1W; Sun, 31 Jan 2016 12:59:49
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160131113546.GF5116@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:kdo4YTa0cxSbWnq3BATblwUiF9RGD9ZCl+jatiNpI9skRlDyTG/
 6PyCe7Fbva1ZW/CtbsC4MhFJiZEzyChvJ64u+zwHcZ9PIGQZEfKexJNYIAmgXsak7eYecc9
 0GAxlqXE20QBZ9fClbTzXTeowHLsDOu9Satd3LwKDravFChWKBh7VjBlwZWuuTvjTRe6sTi
 fwJoDIC4YLzRqzsu1Xx7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8MUOm9lV5DY=:iS8Rm+/RvQ7+dIaMjGYT6t
 f+1JP5UQWYYQ/csjkgceO4SfuGZqxs+M+SghXCTYsiQE8OUWYK48I1Vd9qwEynZfL3RWJ5X4C
 +S4+eWKgL8YxqMrxmWOGPSnZiGXzNY15txbqJrPrmdwDNgQIUcSBgNfmUJ5j5lkgVO20IjrpG
 R8tdceFEjQqyJKhTW2wckkb7KdRbRbOuN3j8yU7dA/4PeROOHBQB7I4tEUfZpWSndj9glHuR4
 MlEXVxurGqfIXJW2TYtk/2FxBR2emsIUtclH7nLpkBDMYFQliby+GsG2qDTfhpj0jvOTtAIhY
 Buk+9niO/fWAVWgw8VhL7ZprM8NsQwwPdCyVMgFWCDu7VWbloT5OW7f/Gqzh6Qj2qIHEiW9Bk
 QmqCwu/Cc/PBbleDJVOdcqPLTR+l0mZOMEwWe7c2K9m7OwHdoy3zUIPOaEIHAfMls6d14Qvx7
 pu2JMdIQyV4BGO1Ho42iVU4+8hs6tDaRYU7Z1CCXiOSrVm1VV+WttzZOxak8oq1tY/4pWTJNp
 OcZ8wH2zt+pHWqQ4ha0DkGKStpDdl6mVGj1Uqpj3txCxE4iKMGkKHwZwIyl4X9cDsLmUIECwY
 3DnpURJjiXS5fO8rrRm/zZC6NacJAchiiSCn0b/3Yfz5dRS1fR9Xn5huGhXVy/Lse/wFUtYL5
 JFjGWJWRb0wWBh9d78wPFG9UqzdcwnVNn0kUxIpAL8rtQC0MPsp6hQHc5rMEzAciTaYdqA+88
 zMazi1nhUSmUx9oWq7sYSaQ79J+0PB4bjacFY8ZKkyY6qBe3tKWOIbAQ2wHMutxGWtSSsnhx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285144>

Hi Peff,

On Sun, 31 Jan 2016, Jeff King wrote:

> I left this one for last, because it's the most questionable.

I like the simplification... ;-)

The other patches in this series look fine to me.

Ciao,
Dscho
