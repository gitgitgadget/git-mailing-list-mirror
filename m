From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Patch 001/GSoC] Move static files into subdir
Date: Sun, 9 May 2010 19:10:05 +0200
Message-ID: <201005091910.05193.chriscool@tuxfamily.org>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 19:10:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBA1K-00021b-RL
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 19:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab0EIRKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 13:10:15 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:45582 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754208Ab0EIRKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 13:10:14 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 44E018181D8;
	Sun,  9 May 2010 19:10:07 +0200 (CEST)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP;
	Sun,  9 May 2010 19:10:06 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146729>

On Sunday 09 May 2010 15:56:30 Pavan Kumar Sunkara wrote:
Hi,

> Hi,
> 
> It's been a while I mail to this list since I got GSoC. But I have
> been in contact with Christian and Petr (mentors) everyday. As I am
> having my vacation, I decided to statrt the project earlier itself.
> Here's is my first patch in the process of my GSoC.
> 
> One of my project goals is to split gitweb. This patch initiates the
>  splitting.

All of the above should go after the three dashes and before the diffstat 
bellow.

Please try to look at the submitting patch documentation and what other 
people's patches look like.

> From e25db0b62b481e029354ad33af8f0615a8353633 Mon Sep 17 00:00:00 2001
> From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> Date: Wed, 5 May 2010 21:44:57 -0700

The above line should not appear.

> Subject: [PATCH] Gitweb: Move all static files into a seperate directory

This line should be the subject of your email.
If you really want to say that it's a GSoC patch you can use [PATCH GSoC] 
instead of [PATCH] but please don't put "001/GSoC".

> This commit creates a new subdirectory called 'static' in gitweb
> which will contain all the static files required by gitweb.cgi
> while executing. By doing so, the gitweb source will be more
> readable and maintainable.
> 
> Also changed INSTALL, README, Makefile and test files
> according to this change.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

The comments that you put on top of the patch should go here.

>  gitweb/INSTALL                      |   20 ++++++++++----------
>  gitweb/Makefile                     |   20 ++++++++++----------
>  gitweb/README                       |    8 ++++----
>  gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
>  gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
>  gitweb/{ => static}/gitweb.css      |    0
>  gitweb/{ => static}/gitweb.js       |    0
>  t/gitweb-lib.sh                     |    6 +++---
>  8 files changed, 27 insertions(+), 27 deletions(-)
>  rename gitweb/{ => static}/git-favicon.png (100%)
>  rename gitweb/{ => static}/git-logo.png (100%)
>  rename gitweb/{ => static}/gitweb.css (100%)
>  rename gitweb/{ => static}/gitweb.js (100%)

[...]

Regards,
Christian.
