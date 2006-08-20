From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Mon, 21 Aug 2006 01:55:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608210145200.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1762834609-1156118156=:28360"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 01:56:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEx9C-00038l-BC
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 01:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWHTXz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 19:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWHTXz7
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 19:55:59 -0400
Received: from mail.gmx.de ([213.165.64.20]:30674 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932106AbWHTXz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 19:55:58 -0400
Received: (qmail invoked by alias); 20 Aug 2006 23:55:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 21 Aug 2006 01:55:56 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <hoegsberg@gmail.com>
In-Reply-To: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25774>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1762834609-1156118156=:28360
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 20 Aug 2006, Kristian Høgsberg wrote:

> Hi,
> 
> I sent a patch to rewrite branch in C and make it a builtin a couple
> of months ago.  Junio had a few comments about the patch that I now
> finally had the time to address.  One of the problems was that
> merge-base didn't clean up its state, which has now been fixed.
> Here's the updated version.
> 
> Signed-off-by: Kristian Høgsberg <krh@redhat.com>

Micro-nit: in delete_branches(), you can assign rev2 outside the loop.

Also, "git branch" no longer sorts the names alphabetically (you could fix 
this by putting the names into a path_list, which sorts them).

The "-l" option (create a log) seems to be forgotten, but then, I never 
use that anyway.

AFAICT the rest is fine.

Ciao,
Dscho

---1148973799-1762834609-1156118156=:28360--
