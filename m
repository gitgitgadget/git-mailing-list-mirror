From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] make =?UTF-8?Q?pull=2Eff=3Dtrue=20override=20merg?=
 =?UTF-8?Q?e=2Eff?=
Date: Thu, 14 May 2015 14:59:35 +0200
Organization: gmx
Message-ID: <f80d59c142b64c56fe7159452d4d10e3@www.dscho.org>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 14:59:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yssjq-00076H-65
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 14:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933403AbbENM7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 08:59:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:54237 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933066AbbENM7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 08:59:38 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lxt3Q-1ZDj1f3tbw-015GZc; Thu, 14 May 2015 14:59:35
 +0200
In-Reply-To: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ZAqS3Mqc3n7xXJsMS3xFUX9LzakzOfq3g+wjOoWrLAzYcrthfX9
 JMkmVYyPDsxqTr84PVfH6+stEPRtkWxuUY86l6D1PYLMSv4K1qWpQuPydtFGAWF50bm/uVO
 0IRhttku9Xfw/wIIksKbRxD/elxjNPq/0EKvo9x3ZSmbjfCO7Jmwm+OhFYpQHASEOdyHTv8
 /74AJhfDJ8XOQyW32jn1w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269030>

Hi Paul,

On 2015-05-13 11:52, Paul Tan wrote:
> Since b814da8 (pull: add pull.ff configuration, 2014-01-15), running
> git-pull with the configuration pull.ff=false or pull.ff=only is
> equivalent to passing --no-ff and --ff-only to git-merge. However, if
> pull.ff=true, no switch is passed to git-merge. This leads to the
> confusing behavior where pull.ff=false or pull.ff=only is able to
> override merge.ff, while pull.ff=true is unable to.
> 
> This patch series adds a failing test to demonstrates the above, and fixes it.
> 
> The documentation is also tweaked to clarify that pull.ff is meant to override
> merge.ff.
> 
> The last patch makes pull.ff consistent with merge.ff by supporting the config
> aliases of true and false (on, off, 0, 1).

Looks very good!

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho
