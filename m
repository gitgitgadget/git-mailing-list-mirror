From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 3/5] update_unicode.sh: shorten uniset invocation path
Date: Fri, 19 Dec 2014 23:34:22 +0100
Message-ID: <5494A7EE.4010308@web.de>
References: <1419006094-24572-1-git-send-email-dev+git@drbeat.li> <1419006094-24572-3-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: dev+git@drbeat.li, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 23:34:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2685-0004fB-35
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 23:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbaLSWed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 17:34:33 -0500
Received: from mout.web.de ([212.227.17.12]:57849 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbaLSWec (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 17:34:32 -0500
Received: from macce.local ([93.222.38.197]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MYNrh-1YOQBm3oJd-00V7k2; Fri, 19 Dec 2014 23:34:28
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1419006094-24572-3-git-send-email-dev+git@drbeat.li>
X-Provags-ID: V03:K0:hHCmsvgmDdnNl3cNpYANxGiJeK+7nu++NalKo1gS0Qs9AJLDHqg
 ho/mSGmoT3IraGK5qZK+2bK8gbNGtUsoPSgE6rpNRKZT9JQfHYTvpq6r5RSuFkP4l/nvBj/
 HNunLP6a1Fu0HSgSjMEOcYStfT06sLS09lhIWhBhwLmnRV3xXpoKP8q6Lfi3bwDSktTmxeg
 jCMej/94RNvry86Zj5b8g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261596>


> -		./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
> +		uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |

(Technically both do the same)
I personally think that using ./ it is extra obvious that a command is not
from the path somewhere.
But that may be because of my un-careful reading, what do others think ?

Thanks for improving Git
