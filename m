From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] allow alias expansion without a git directory
Date: Sun, 30 Jul 2006 11:34:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607301133380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1G708T-00073m-Hg@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 11:35:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G77hP-0002eq-Sx
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 11:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWG3Je7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 05:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWG3Je7
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 05:34:59 -0400
Received: from mail.gmx.net ([213.165.64.21]:64435 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932143AbWG3Je6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 05:34:58 -0400
Received: (qmail invoked by alias); 30 Jul 2006 09:34:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 30 Jul 2006 11:34:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G708T-00073m-Hg@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24449>

Hi,

On Sun, 30 Jul 2006, Matthias Lederhofer wrote:

> diff --git a/setup.c b/setup.c
> index 4612f11..358e139 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -184,6 +184,10 @@ const char *setup_git_directory_gently(i
>  		}
>  		return NULL;
>  	bad_dir_environ:
> +		if (!nongit_ok) {
> +			*nongit_ok = 1;
> +			return NULL;
> +		}

Funny. Yesterday, I looked through "git diff next", and decided to sync 
this part, i.e. undo the change you just proposed...

Ciao,
Dscho
