From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] hg-to-git: add --verbose option
Date: Mon, 26 May 2008 15:09:49 +0200
Message-ID: <200805261509.49841.johan@herland.net>
References: <alpine.DEB.1.00.0805261344420.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stelian Pop <stelian@popies.net>,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 26 15:12:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0cUY-000736-5y
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 15:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYEZNKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 09:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755591AbYEZNKw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 09:10:52 -0400
Received: from sam.opera.com ([213.236.208.81]:35697 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755912AbYEZNKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 09:10:51 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m4QD9oRQ005020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 May 2008 13:09:55 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0805261344420.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82929>

On Monday 26 May 2008, Johannes Schindelin wrote:
> This patch adds an option to make hg-to-git quiet by default.  Note:
> it only suppresses those messages that would be printed when
> everything was up-to-date.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Yeah, I know, a Python hater codes in Python.  Well, somebody told
> 	me I had to code in it until I do not hate it anymore.

Looks ok to me. :)

>  contrib/hg-to-git/hg-to-git.py |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/hg-to-git/hg-to-git.py
> b/contrib/hg-to-git/hg-to-git.py index d72ffbb..daad399 100755
> --- a/contrib/hg-to-git/hg-to-git.py
> +++ b/contrib/hg-to-git/hg-to-git.py
> @@ -46,6 +46,7 @@ options:
>                           for incrementals
>      -n, --nrepack=INT:   number of changesets that will trigger
>                           a repack (default=0, -1 to deactivate)
> +    -v, --verbose:       be verbose
>
>  required:
>      hgprj:  name of the HG project to import (directory)
> @@ -75,15 +76,18 @@ def getgitenv(user, date):
>
>  state = ''
>  opt_nrepack = 0
> +verbose = ''

Maybe this should be
	verbose = false
since it indicates your intent to exclusively use this variable as a
boolean.

The rest is ok, AFAICS.


Have fun! :)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
