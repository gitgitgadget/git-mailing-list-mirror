From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Mon, 27 Jun 2005 15:05:47 -0400
Message-ID: <4DB694DE-E3E8-4F72-8888-9529D2CC16B9@mac.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050627183118.GB1415@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Mon Jun 27 21:00:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmypu-0000q4-FB
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 21:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVF0TGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVF0TGf
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 15:06:35 -0400
Received: from smtpout.mac.com ([17.250.248.71]:19146 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261619AbVF0TGN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 15:06:13 -0400
Received: from mac.com (smtpin02-en2 [10.13.10.147])
	by smtpout.mac.com (Xserve/8.12.11/smtpout14/MantshX 4.0) with ESMTP id j5RJ5pqB025326;
	Mon, 27 Jun 2005 12:05:52 -0700 (PDT)
Received: from [10.0.0.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin02/MantshX 4.0) with ESMTP id j5RJ5mwk015273
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 27 Jun 2005 12:05:50 -0700 (PDT)
In-Reply-To: <20050627183118.GB1415@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.730)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Jun 27, 2005, at 14:31:18, Pavel Machek wrote:
> pavel@Elf:/data/tmp/linux-hg$ hg init http://www.kernel.org/hg/
> Traceback (most recent call last):
>   File "/usr/local/bin/hg", line 11, in ?
>     from mercurial import commands
> ImportError: No module named mercurial

Apparently your Python does not automatically look in /usr/local/lib/ 
python
and you don't have PYTHONPATH=/usr/local/lib/python.  Try adding the  
following
to your .bash_profile, then logging out and back in again:

if [ -z "$PYTHONPATH" ]; then
     PYTHONPATH=/usr/local/lib/python
else
     PYTHONPATH="$PYTHONPATH:/usr/local/lib/python"
fi
export PYTHONPATH

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't.  
That's why
I draw cartoons. It's my life."
-- Charles Shultz
