From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] diff_setup_done(): return void
Date: Fri, 3 Aug 2012 14:17:58 +0200
Message-ID: <87y5lw41ah.fsf@thomas.inf.ethz.ch>
References: <CAN0XMOLp_m4jUKv_=qfXdYx4jDJMBYQtY2-19sfC_7LzfY6uXA@mail.gmail.com>
	<6668871a0573c4d82d914137e3c7ff31fa8ce1ef.1343995614.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Ralf Thielow <ralf.thielow@gmail.com>, <jk@jk.gs>,
	<stimming@tuhh.de>, <git@vger.kernel.org>,
	<worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:18:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxGpR-0000h0-NF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 14:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711Ab2HCMSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 08:18:00 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:7771 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753625Ab2HCMR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 08:17:59 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 14:17:53 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 14:17:58 +0200
In-Reply-To: <6668871a0573c4d82d914137e3c7ff31fa8ce1ef.1343995614.git.trast@student.ethz.ch>
	(Thomas Rast's message of "Fri, 3 Aug 2012 14:16:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202831>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/line.c b/line.c
> index a008c2c..fe7ace7 100644
> --- a/line.c
> +++ b/line.c
> @@ -1177,6 +1177,9 @@ static int process_diff_filepair(struct rev_info *rev,
>  		return 0;
>  	if (rg->ranges.nr == 0)
>  		return 0;
> +	if (rg->ranges.nr == 1 &&
> +	    rg->ranges.ranges[0].start == rg->ranges.ranges[0].end)
> +		return 0;

This hunk is totally unrelated, sorry for accidentally including it.
You can remove it before application, or I can resend.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
