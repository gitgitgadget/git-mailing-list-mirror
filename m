From: James McCoy <vega.james@gmail.com>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Mon, 26 Oct 2015 21:23:36 -0400
Message-ID: <20151027012336.GK31271@freya.jamessan.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
 <xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 02:23:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqszJ-00012F-7F
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 02:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbbJ0BXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 21:23:40 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36120 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbbJ0BXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 21:23:39 -0400
Received: by ykba4 with SMTP id a4so197194111ykb.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0SBTnqIy+EeRafIdaFT24gorJBbtX1LjUH4wivM5oiM=;
        b=HUCW/yxVRw0dgvpF/5HJ3FRO8H4JOveC+MyFzZKtt5/J/uoa+hioS/b6CrJ2Y0gnC7
         VEUBcs1gKSpGXXKDb7aUAxoBqD/5wMIsFbkhYfrSmxqKjxsXJYQe184Pg3e9pPk6krs4
         yOhq64IPKrV5zSFSROwWkojB/fpxnJDxOZtsNnkVXARiNzAeu/kUxWdjvZM2/0UpBStJ
         hCJ9tvdECz9udzdW1zoMSzYrVnIBdyOlXvTJnuokgKUbgxlpCYuqq7+7ARhiGuj7A3+U
         E8UE5IIsTbDVsDbx96ITiPZhcEoceTXr1QdxqOFb3CHmNa3jrBvdvLEu7tbMUxD3Kw7j
         qrmg==
X-Received: by 10.129.41.15 with SMTP id p15mr27122332ywp.91.1445909019019;
        Mon, 26 Oct 2015 18:23:39 -0700 (PDT)
Received: from freya.jamessan.com (pool-71-162-119-45.bstnma.fios.verizon.net. [71.162.119.45])
        by smtp.gmail.com with ESMTPSA id i66sm26315123ywc.2.2015.10.26.18.23.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2015 18:23:37 -0700 (PDT)
Received: from jamessan by freya.jamessan.com with local (Exim 4.86)
	(envelope-from <vega.james@gmail.com>)
	id 1ZqszA-00036S-Rj; Mon, 26 Oct 2015 21:23:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280238>

On Mon, Oct 26, 2015 at 01:15:17PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This patch was required to work behind a faulty AP and scraped from
> > http://stackoverflow.com/questions/15227130/#15228479 and guarded with
> > an appropriate cURL version check by Johannes Schindelin.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Thanks.
> 
> The code looks OK but the last paragraph makes _us_ worried.  What
> is the licensing status of the original at SO?

According to Stackoverflow[0],

  As noted in the Stack Exchange Terms of Service[1] and in the footer of
  every page, all user contributions are licensed under Creative Commons
  Attribution-Share Alike[2]. Proper attribution[3] is required if you
  republish any Stack Exchange content.

[0]: https://stackoverflow.com/help/licensing
[1]: http://stackexchange.com/legal
[2]: http://creativecommons.org/licenses/by-sa/3.0/
[3]: http://blog.stackoverflow.com/2009/06/attribution-required/

Cheers,
-- 
James
GPG Key: 4096R/331BA3DB 2011-12-05 James McCoy <vega.james@gmail.com>
