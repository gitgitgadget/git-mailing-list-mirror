From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH] include signal.h for prototype of signal()
Date: Mon, 26 Jun 2006 10:51:19 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060626085119.GE3646@informatik.uni-freiburg.de>
References: <20060626080912.GA3646@informatik.uni-freiburg.de> <20060626082323.GB3646@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Stosberg <dennis@stosberg.net>
X-From: git-owner@vger.kernel.org Mon Jun 26 10:51:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FumoW-0007r2-GR
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWFZIvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWFZIvV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:51:21 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:48857 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S964943AbWFZIvU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 04:51:20 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FumoR-0006ul-B3; Mon, 26 Jun 2006 10:51:19 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k5Q8pJk13771;
	Mon, 26 Jun 2006 10:51:19 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org, Dennis Stosberg <dennis@stosberg.net>
Content-Disposition: inline
In-Reply-To: <20060626082323.GB3646@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22666>

Hello, 

Oops, this patch was already posted by Dennis Stosberg in
<20060626082613.G7dd5c243@leonov.stosberg.net>.  (But it lacks a
sign-off, as do his other patches.)

Uwe Zeisberger wrote:
> Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
> 
> ---
> 
>  connect.c     |    1 +
>  merge-index.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> 46cd6d04f4531dfaf56f7f1beb4ea6c73f08015e
> diff --git a/connect.c b/connect.c
> index db7342e..6c5389b 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -3,6 +3,7 @@
>  #include "pkt-line.h"
>  #include "quote.h"
>  #include "refs.h"
> +#include <signal.h>
>  #include <sys/wait.h>
>  #include <sys/socket.h>
>  #include <netinet/in.h>
> diff --git a/merge-index.c b/merge-index.c
> index 190e12f..91908d8 100644
> --- a/merge-index.c
> +++ b/merge-index.c
> @@ -1,3 +1,4 @@
> +#include <signal.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  

-- 
Uwe Zeisberger

cat /*dev/null; echo 'Hello World!';
cat > /dev/null <<*/ 
() { } int main() { printf("Hello World!\n");}
/* */
