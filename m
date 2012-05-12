From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: surprising behavior from merge
Date: Fri, 11 May 2012 18:05:59 -0600
Message-ID: <4FADA967.10808@highlab.com>
References: <9A9AD20F-B316-4DC1-8C6A-E0FC6ED80A61@highlab.com> <ae419d8bbc2b44bfa4c0a7eb421f5037-mfwitten@gmail.com>
Reply-To: seb@highlab.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 02:06:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSzql-0001GZ-0I
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 02:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761279Ab2ELAGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 20:06:10 -0400
Received: from smtp.quartz.synacor.com ([205.169.121.111]:56669 "EHLO
	smtp.q.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761220Ab2ELAGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 20:06:08 -0400
X_CMAE_Category: 0,0 Undefined,Undefined
X-CNFS-Analysis: v=1.1 cv=0ABQra+cUGCZLl+TLSZldWKxL9vllrlB+YjuiJekF0k= c=1 sm=0 a=eFosVe0FMc8A:10 a=oddu3yYFaF8A:10 a=8D6UOEW8R_kA:10 a=dMsC7yqBOR8A:10 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8 a=t0u28acgv7FDJafpC4MA:9 a=wPNLvfGTeEIA:10 a=TMBAGMHkG2eaw9KJSPgtzw==:117
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: smtp01.quartz.synacor.com header.from=seb@highlab.com; sender-id=neutral
Authentication-Results: smtp01.quartz.synacor.com smtp.mail=seb@highlab.com; spf=neutral; sender-id=neutral
Authentication-Results: smtp01.quartz.synacor.com smtp.user=highlab@q.com; auth=pass (LOGIN)
Received-SPF: neutral (smtp01.quartz.synacor.com: 184.96.169.202 is neither permitted nor denied by domain of highlab.com)
Received: from [184.96.169.202] ([184.96.169.202:59840] helo=highlab.com)
	by smtp.q.com (envelope-from <seb@highlab.com>)
	(ecelerity 2.2.2.40 r(29895/29896)) with ESMTPA
	id B0/8D-03665-F69ADAF4; Fri, 11 May 2012 20:06:07 -0400
Received: from 184-96-169-202.hlrn.qwest.net ([184.96.169.202] helo=[10.0.0.101])
	by highlab.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <seb@highlab.com>)
	id 1SSzqY-0003F6-P0; Fri, 11 May 2012 18:06:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <ae419d8bbc2b44bfa4c0a7eb421f5037-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197709>

On 05/11/2012 05:57 PM, Michael Witten wrote:
> On Fri, 11 May 2012 16:25:29 -0600, Sebastian Kuzminsky wrote:
>
>> The simplified repo is here if anyone wants to inspect it:
>> https://github.com/SebKuzminsky/merge-problem
...

> In other words, rather than burdening people with the task of
> constructing a mental picture of what you have done, you should
> show them as directly and precisely as possible; in this way,
> people can go about the business of discussing your issue much
> more quickly and, most importantly, PRECISELY.
>

Ah, I had intended the extremely tiny git repo I linked to to provide 
the info in the most concise way possible.  The surprising behaviour 
happened at the final commit in the repo, which was made by 'git merge 
other'.

I can email a list of commands to reproduce the issue later tonight if 
that would make anything clearer.


-- 
Sebastian Kuzminsky
