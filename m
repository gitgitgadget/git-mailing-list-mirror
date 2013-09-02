From: Uli Heller <uli.heller@daemons-point.com>
Subject: Re: git svn fetch segfault on exit
Date: Mon, 02 Sep 2013 15:05:50 +0200
Message-ID: <52248D2E.4090206@daemons-point.com>
References: <51E7B382.8050302@gmail.com> <CAPWhs-6E_9T61uf20YKXzwE2j8Tq-sOU9BUw_dVVe=LAH69_iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 15:26:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGU9c-00049R-ED
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 15:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274Ab3IBN0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 09:26:47 -0400
Received: from daemons-point.com ([213.133.97.207]:59792 "EHLO
	daemons-point.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab3IBN0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 09:26:46 -0400
X-Greylist: delayed 1252 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Sep 2013 09:26:46 EDT
Received: from port-83-236-132-106.static.qsc.de ([83.236.132.106] helo=qscmail.daemons-point.com)
	by daemons-point.com with esmtp (Exim 4.76)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VGTpH-00067r-4i
	for git@vger.kernel.org; Mon, 02 Sep 2013 15:05:51 +0200
Received: from localhost ([127.0.0.1])
	by qscmail.daemons-point.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VGTpG-0006hG-If
	for git@vger.kernel.org; Mon, 02 Sep 2013 15:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAPWhs-6E_9T61uf20YKXzwE2j8Tq-sOU9BUw_dVVe=LAH69_iw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233635>

Am 02.09.2013 13:57, schrieb Evgeny Kotkov:
>> Every git svn call that involves a fetch produces a segmentation fault on
>> exit (but the operation succeeds).
>  From what I see, this looks quite similiar to the 'serf' issue I've recently
> reported to the serf-dev mailing list [1].  It should be fixed by now, so,
> the latest serf@trunk build should work fine.
>
> [1]: https://groups.google.com/d/msg/serf-dev/gOn9HTUN98U/pz0_AqdrmJYJ
>
>

I've tried the patch for 'serf' included in the thread mentioned above 
and I can confirm that it fixes the issue for me.
Thanks Evgeny!

Best regards, Uli.
