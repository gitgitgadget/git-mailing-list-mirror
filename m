From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] blame: Add --time to produce raw timestamps
Date: Tue, 13 Jun 2006 00:41:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606130038370.25422@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060612214210.22342.46844.stgit@c165>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 13 00:41:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpv64-0005pW-H9
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 00:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWFLWlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWFLWlV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 18:41:21 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16848 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932636AbWFLWlV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 18:41:21 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 047262A9F;
	Tue, 13 Jun 2006 00:41:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id ECD272A5E;
	Tue, 13 Jun 2006 00:41:19 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id CF0691C5A;
	Tue, 13 Jun 2006 00:41:19 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060612214210.22342.46844.stgit@c165>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21746>

Hi,

On Mon, 12 Jun 2006, Fredrik Kuivinen wrote:

> diff --git a/blame.c b/blame.c
> index 88bfec2..afa22b5 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -20,9 +20,11 @@ #include "xdiff-interface.h"
>  
>  #define DEBUG 0
>  
> -static const char blame_usage[] = "[-c] [-l] [--] file [commit]\n"
> +static const char blame_usage[] = "[-c] [-l] [-t] [-S <revs-file>] [--] file [commit]\n"

That is a bit more than the commit message says.

> +        "  -t, --time        Show raw timestamp (Default: off)\n"
> +	"  -S, --revs-file   Use revisions from revs-file instead of calling git-rev-list\n"

I smell white space corruption here.

> +			       int raw_time)

Just a tiny nit: could you name it "show_raw_time" instead of "raw_time"? 
I got confused by that naming into believeing raw_time was actually a 
timestamp, not a boolean...

Ciao,
Dscho
