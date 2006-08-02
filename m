From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: RE: [PATCH 9/10] Remove cmd_usage() routine and re-organize the help/usage code.
Date: Wed, 2 Aug 2006 19:47:53 +0100
Message-ID: <001e01c6b664$294af180$c47eedc1@ramsay1.demon.co.uk>
References: <20060802132149.GG16364@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 02 20:48:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Lky-0001PJ-1o
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 20:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWHBSro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 14:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWHBSro
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 14:47:44 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:23044 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S932144AbWHBSrl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 14:47:41 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-36.mail.demon.net with smtp (Exim 4.42)
	id 1G8Lkq-000MLO-Jf; Wed, 02 Aug 2006 18:47:40 +0000
To: "Martin Waitz" <tali@admingilde.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
In-Reply-To: <20060802132149.GG16364@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24667>


On Wed, 2006-08-02 at 14:22 Martin Waitz wrote:
> hoi :)
> 
> On Wed, Aug 02, 2006 at 02:03:44AM +0100, Ramsay Jones wrote:
> >  builtin-help.c |   54
> > +++++++++++++++++++++++-------------------------------
> >  builtin.h      |    7 ++-----
> >  git.c          |    7 +++++--
> >  3 files changed, 30 insertions(+), 38 deletions(-)
> 
> this patch is at the tip of "master" now, but with one more change:
> builtin-help.c           |   54 
> ++++++++++++++++++++--------------------------
> builtin.h                |    7 ++----
> git.c                    |    7 ++++--
> t/t9100-git-svn-basic.sh |    7 +++---
> 4 files changed, 33 insertions(+), 42 deletions(-)
> 
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index bf1d638..34a3ccd 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -170,7 +170,7 @@ then
>              test -L $SVN_TREE/exec-2.sh"
> 
>         name='modify a symlink to become a file'
> -       git help > help || true
> +       echo git help > help || true
>         rm exec-2.sh
>         cp help exec-2.sh
>         git update-index exec-2.sh
> 
> this looks strange.
> 

Erm, well maybe. I dunno. Junio?

Ramsay
 
