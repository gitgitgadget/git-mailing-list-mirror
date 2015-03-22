From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] clone: Warn if LICENSE or COPYING file lacking and !clone.skiplicensecheck
Date: Sun, 22 Mar 2015 09:23:33 +0100
Message-ID: <550E7C05.4060603@kdbg.org>
References: <E1YZTZI-0002QE-3r@rmm6prod02.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: dwheeler@dwheeler.com, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 09:23:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZbAd-0002bn-JD
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 09:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbbCVIXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 04:23:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:20711 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbbCVIXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 04:23:37 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3l8sLG43NZz5tlB;
	Sun, 22 Mar 2015 09:23:34 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3DFEF5203;
	Sun, 22 Mar 2015 09:23:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <E1YZTZI-0002QE-3r@rmm6prod02.runbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266056>

Am 22.03.2015 um 01:16 schrieb David A. Wheeler:
> Warn cloners if there is no LICENSE* or COPYING* file that makes
> the license clear.  This is a useful warning, because if there is
> no license somewhere, then local copyright laws (which forbid many uses)
> and terms of service apply - and the cloner may not be expecting that.
> Many projects accidentally omit a license, so this is common enough to note.
>
> You can disable this warning by setting "clone.skiplicensecheck" to "true".
>
> For more info on the issue, feel free to see:
> http://choosealicense.com/no-license/
> http://www.wired.com/2013/07/github-licenses/
> https://twitter.com/stephenrwalli/status/247597785069789184
>
> Signed-off-by: David A. Wheeler <dwheeler@dwheeler.com>

The opt-out works only when placed in the system-wide or user 
configuration. That places a maintenance burden on *ALL* existing 
installations that do not want the warning.

If you really want to hard-code such a policy decision into Git, then 
make it an opt-in so that members of the license squad can enable it.

I don't need it.

-- Hannes
