From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] fast-import.c: always honor the filename case
Date: Sun, 09 Feb 2014 21:34:26 +0100
Message-ID: <52F7E652.4030102@web.de>
References: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>	<52EEA5D3.9000502@web.de>	<CAD_8n+RZACW0380co75gWSwVmCJdcH4COsySTF3BFCyKEumXNA@mail.gmail.com>	<52EFFA36.8090305@web.de>	<CAD_8n+RuwQEXJRCOr+B_PqA7z6LkFdbcRZkiiVJsEhJ=+YjRDg@mail.gmail.com>	<52F2AAFA.1090507@web.de> <CAD_8n+Thn3tNTYxLK49mDOGdLpWRCFUCJo9b76UbAjnCdqXsRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaA==?= =?UTF-8?B?YXVzZW4=?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 09 21:34:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCb5K-0006qF-2J
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 21:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbaBIUed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 15:34:33 -0500
Received: from mout.web.de ([212.227.17.12]:53520 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbaBIUed (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 15:34:33 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MS2D8-1VnkgG2PCk-00T9y5 for <git@vger.kernel.org>;
 Sun, 09 Feb 2014 21:34:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAD_8n+Thn3tNTYxLK49mDOGdLpWRCFUCJo9b76UbAjnCdqXsRQ@mail.gmail.com>
X-Provags-ID: V03:K0:0XiHN/YFnHEPF8wNSyRZqCmiVRks6lj1B17R2OZ3CS95+vgbjU3
 dj7H5UaF5NF7/rbAsetDz1gwHGJCz59AtZid0P4O5WCiG2yNBb6TDhDFHHlQ8zDUGrPXfs8
 EI2adc6Rj24PfmvRrah6D0nTz3pzxp5VcSj/m/FjocloYeUs5OkoPGefN3iWI29RCx63RRT
 KkCTK2EbP1ezHLkcCCMOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241885>

On 2014-02-06 12.24, Reuben Hawkins wrote:
[snipped away minor interesting stuff]

    Reading the answers from Peff and Junio, I am convinced that the fast-import should
    not look at core.ignorecase at all.


Agreed, but my patch 0001-fast-import.c-ignorecase-iff-... is working very well (for me anyway), and the ignore-case option may be useful to the git-p4 importer (which I guess is something that should be determined for sure).

If you want, you can turn this into a real patch and send it to the list.
I think  Pete Wyckoff <pw@padd.com> is one of the experts about p4.

And the same is for fast-export fixes you have made: If you have the time,
convert it into a patch and send it to the list.

[]
> BTW, if you can, can you give me a quick overview of testing it git?  I can run 'make tests' easy enough, but there seems to be a well defined framework of testing written in bash and c..  Is there a doc on that framework anywhere?
I'm not sure if there is a document, and yes, it's a nice framework.
You can have a look at t0050, it gives a good overview over the most important
feattures in the framework, I would say.

(And the shell scripts uses a subset of the POSIX shell, which means we avoid
bash-ism things like "[[ ]]" or "==")
/Torsten
