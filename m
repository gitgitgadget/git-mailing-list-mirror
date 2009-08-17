From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 06/11] Add miss git-compat-util.h at regex.c and
 fnmatch.c Add git-compat-util.h to enable build at MSVC environment
Date: Mon, 17 Aug 2009 21:23:26 +0200
Message-ID: <200908172123.26699.j6t@kdbg.org>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: msysgit@googlegroups.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Aug 17 21:25:05 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md7o4-0001W3-Ci
	for gcvm-msysgit@m.gmane.org; Mon, 17 Aug 2009 21:23:48 +0200
Received: by gxk10 with SMTP id 10so4860287gxk.10
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=ij3Uo1KRz0BzAy7BjKmoFgPTcqm6yMhy/Vy7iR0HYDA=;
        b=XOsia3ACpxnPyGv5fpkz/dmKm0WJPV44UDnAmflueXab5wqT/A/mzRdj199/FKL6wi
         DL5P7HqMEIaj/dp5fQl83qBmnCrLmT5i9ASeHMNAO/psgHqXVZida4dQdXlZMWAiPnE5
         8Q6ccWfB+MJr8WPquOZ3NhfI/EP8FZ+g/2JOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=3zqYEfV8V/kUB91dZMx4qBBilqmjfu4zU5YVaouQfoXO4de+ZWS3vsluGFSaJBUwrW
         UdgcJYMiJDMNHOdaO3NNzEc/pI9JRfKjS54ap5mm/A1rXC2YwKDDGaQTgY+DAReAKXuy
         0QjOEkT/N6WS5Ut0W9CLyylyYvDivx0ZeKIO8=
Received: by 10.150.75.13 with SMTP id x13mr1245443yba.26.1250537022088;
        Mon, 17 Aug 2009 12:23:42 -0700 (PDT)
Received: by 10.176.48.40 with SMTP id v40gr6376yqv.0;
	Mon, 17 Aug 2009 12:23:28 -0700 (PDT)
X-Sender: j6t@kdbg.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.165.1 with SMTP id s1mr407648ebo.2.1250537007602; Mon, 17 Aug 2009 12:23:27 -0700 (PDT)
Received: by 10.211.165.1 with SMTP id s1mr407647ebo.2.1250537007573; Mon, 17 Aug 2009 12:23:27 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14]) by gmr-mx.google.com with ESMTP id 16si1010315ewy.3.2009.08.17.12.23.27; Mon, 17 Aug 2009 12:23:27 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.14;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Received: from dx.sixt.local (unknown [93.83.142.38]) by bsmtp.bon.at (Postfix) with ESMTP id 05A4A10017; Mon, 17 Aug 2009 21:23:27 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1]) by dx.sixt.local (Postfix) with ESMTP id C3DA5453F7; Mon, 17 Aug 2009 21:23:26 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126256>


On Montag, 17. August 2009, Frank Li wrote:
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> ---
>  compat/fnmatch/fnmatch.c |    4 ++++
>  compat/regex/regex.c     |    4 ++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
> index 14feac7..5cbd49c 100644
> --- a/compat/fnmatch/fnmatch.c
> +++ b/compat/fnmatch/fnmatch.c
> @@ -16,6 +16,10 @@
>     write to the Free Software Foundation, Inc., 59 Temple Place - Suite
> 330, Boston, MA 02111-1307, USA.  */
>
> +#ifdef _MSC_VER
> +#include "git-compat-util.h"
> +#endif

There is a *lot* to explain: Why the *heck* is this needed?

> diff --git a/compat/regex/regex.c b/compat/regex/regex.c
> index 5728de1..2298a3a 100644
> --- a/compat/regex/regex.c
> +++ b/compat/regex/regex.c
> @@ -20,6 +20,10 @@
>     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
>
>  /* AIX requires this to be the first thing in the file. */
> +#ifdef _MSC_VER
> +#include "git-compat-util.h"
> +#endif

Same here.

-- Hannes
