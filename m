From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2 V3] MSVC: Use shipped headers instead of fallback
 definitions
Date: Wed, 30 Mar 2016 13:42:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1603301341120.4690@virtualbox>
References: <56FAACD4.9080504@cs-ware.de> <56FAB9FD.7080409@cs-ware.de> <56FB93B9.7090306@gmail.com> <56FBBA80.8090908@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, blees@dcon.de
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Wed Mar 30 13:43:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alEXE-00040Y-12
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 13:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbcC3Lna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 07:43:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:63470 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbcC3Ln1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 07:43:27 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MYbFe-1aFttf36Ys-00VS7k; Wed, 30 Mar 2016 13:42:05
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56FBBA80.8090908@cs-ware.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:iymQQC7SVnmwNB2GqbdtPGKYswsxtRoNzAadimpbnKAaDRbyW6J
 gFQviSW3v+ExGCoi2TXKKUmbtbDleFd+hD8/RqgQ+jHp0xCmqK93Sg9GS6M5VEt786Y1YuH
 T5C3/RDzR/ba7RzmC3XlRbxo10ljwL6k9vvfJMR4wjIGnw4C72NCYWrRJCfUmQ9d2UHvUun
 JZfobAP1P6dbJpx4S6HbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dxSZn3BDvWo=:OWpHVJXgdChlHqMVPxhBmQ
 bIj48DJo28mFtE7EkQK+fdux8cx2jJztWFabSussN2qXBECjn6lFK4GTaGKPUX8qFI3mrQoda
 wJQr50SP246Rwu+nPp3mODgUbhQ2kCRt/QiArcg3uq+438ZWkqrztwtwX6pY+zz28WCuxCDrE
 Cn8y9CJeI/88dKv56Oskg90VT1KCx6SvFFCiLe+jINSUfdV6NVyBT14OpjZmEJJioD7Mb2C3H
 jkZkkqbjHFdpeEwfsRI4pk4pakXOOGjffaRvyi90Q8meCVpyzfxKRSgymZFkrqA725LnLVIqZ
 RV85ylp6+wrHbkVgEvKR8vke2UFiX/07H0dIn9OCOUY1YSiYK9fnUabZKKCaU4xWS4Bnedy4E
 BHOZVhsYxhEnD0KpVUXu84lCsS9Exdtw6Q7tUqJm0hy5KBf4NaigpS4uAC6SaxOQbjXUqkouw
 HWQZDB17WQBezkYHzXnnC+xn10JJtt07sPLEq8hKEmIgNbzd9QMVIsZElsAsGk2VX9I7R/XfV
 YsGNGCa7PHS4rKYsWdy7KGZLhtJIQfAUIZ2/blTp3Zbf3oQcyRl4vvsSuP9VAFu58rcYVINil
 DZknuzBYMrvk4SqtLkeBEk7Hs6cHOeIxu2RWPBzyF1BBuIJiX3HNVV8qeKD6oPrYpPxfEYkNE
 SStUtZDE3eSxynyIKlisX1rfCQzuMtcsSj+JdplwjZ77iCsYqphxRjdUPyS0UL4ioKqsqhdpO
 mj1u64c3tPm91Zb0X+yOrysA0XD5oJsRZchaRiFvmMQYDI+weNmfGQla5x1Dtti3kO7LPqN+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290302>

Hi Sven,

On Wed, 30 Mar 2016, Sven Strickroth wrote:

> VS2010 comes with stdint.h [1]
> VS2013 comes with inttypes.h [2]
> 
> [1] https://stackoverflow.com/a/2628014/3906760
> [2] https://blogs.msdn.microsoft.com/vcblog/2013/07/19/c99-library-support-in-visual-studio-2013/
> 
> Signed-off-by: Sven Strickroth <sven@cs-ware.de>

Much, much, much better commit message (even if there is still room for
a more pleasant read).

ACK
Dscho
