From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Windows patches roadmap, was Re: On a personal note
Date: Fri, 18 Sep 2015 12:32:18 +0200
Organization: gmx
Message-ID: <eff1c874e630dc60fdf3847efea95ff0@dscho.org>
References: <alpine.DEB.1.00.1509031156510.29350@s15462909.onlinehome-server.info>
 <CACsJy8AcK8hAkMowA0t5SusJDTYZDWZCFN5JDs2f-puZcJAfhg@mail.gmail.com>
 <a6ea2cc0231a0fc311b45b8d6edbd305@dscho.org>
 <CAGZ79kaL6Rmmm6siN1nY-OnqK4ij_oboGgeNHz2dqYC6BKb6jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, git-for-windows@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 12:32:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcsy2-0007w2-3F
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 12:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbbIRKcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 06:32:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:49416 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbbIRKcX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 06:32:23 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lskr7-1YaZEA3V6H-012IZg; Fri, 18 Sep 2015 12:32:19
 +0200
In-Reply-To: <CAGZ79kaL6Rmmm6siN1nY-OnqK4ij_oboGgeNHz2dqYC6BKb6jQ@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:I5+NSftdhny+7iP7zYHuc2+WbW/ebkMEhik0AADLs+DQBp48Tw9
 4MPPpF/ZaZNvgg7xdzGq55Z+E50RdMJtyRiB6Erp5kaWP7BTLHfoZfMAdNicOW6ugSh+FIx
 v5b/Lae5afq6oOZlaLJBwBs3SaB0c8c0t6yyLChpTvG/BcZTEIbhgAnmyMKHqdWaDM1a/QX
 c05E04gZrxcHT5hKmFz6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VEf8mXblJqc=:J1wW8lSIKQeIC56Qsn8rhl
 4ATW3E5fuIi6sS3AbygWAplgahgbmMl5cAv1ys9T6z3ywTCe5EA/DPZAcLTQSNGoHMX8zEUy2
 m6ePQofq+p2jQU5YmA8qf5rFae9Dty1dMdLIzcf8WVWZm8/aSlQmzJzduSfBqzpH1BOOjIfZY
 IgtPYM/nRaYpg/CNiVwP0/C3r2Wx0ciKfmk6bgDaOOX2uZT3oTkGDCOdDM/IrwIQHgbVaEL9J
 bWyRemiOT5X9OUeJbOWs3BjxPmU7+3cTce2jnJAGgqa/64NdcTG9V0SiIfQApdMH01T2ZOuZR
 vN+Y5scgJKzSTrfffF2LPv/GQGqRAu5teK5bvTrFElNQfJ9CzYNJ9W1opwE2E3G0jpLH0HFCl
 0+9g1M7IjRzUEaBrEm2rbZ0lMlsenn4dHV0bscio4DmTjpAjf4QkSVtWLYQX9qTFMUiZK+IjJ
 IX+jQcg+u0VEtYaWG4bszS2iZabR+/8LTSaxWM/pwpdxKTVFQyKG4CXJZPmTu11HlYZCg2ApG
 HJl/BsoANLFaKUKY+ZrIwXodd0/ZzMEs0sBxVSRQVS4d5Pt+vNftZaIdxcCXh7NOAa12p3wfK
 X7ZfQtAWobaFXxUreNkL2pmAkE9aP62MkStAErHBONwdNCCHwu93rXSPMdXSjoStFRfNkvrJT
 6teVRxuKsCWQ6unxpaH4gKKqLIkMYMxS4Da781ix9i6cQv32l7TW9kUkBEe/t0sZWP472Z+vx
 cn/AjDtpwnMGQjDRiDbYGf0R473ag+tSs3TykA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278189>

Hi Stefan,

[sorry that your mail to the git-for-windows Google Group got rejected; I want to try to keep this list subscribers-only as long as possible so as not to waste precious time on moderating 20+ spam mails per day, as we used to do with msysgit's mailing list.]

On 2015-09-17 21:27, Stefan Beller wrote:
> On Thu, Sep 17, 2015 at 11:54 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>
>> And yes, the roadmap is pretty clear from the GitHub tickets, e.g. this one:
>>
>> https://github.com/git-for-windows/git/issues/285
> 
> That's pretty awesome. Glad it's on the roadmap!
> 
>>
>> Please note that I held off this week for three reasons:
>>
>> 1) I was submitting patches to the MSys2 and Cygwin upstream first,
>>
>> 2) I was busy fixing e.g. that bug where home directories containing non-ASCII characters were handled incorrectly (and generally trying to keep the tickets in https://github.com/git-for-windows/git under something similar to control), and
>>
>> 3) what with Peff's and Stefan's huge patch series, I did not want to overload Junio.
> 
> My patch series is not large by any means, but it seems as if it requires
> lots of discussion in the fine details. ;)

Yes, I actually meant the impact on the bandwidth of the Git mailing list, not the size of the patch series per se, sorry. I think that it is highly valuable what you are doing there, and I wish I had more time to participate in improving it... (but just when I think I have time, another bug report comes in, or some day-job stuff, or Junio releases a new version and I scramble to get a new Git for Windows version out... ;-))

Ciao,
Dscho
