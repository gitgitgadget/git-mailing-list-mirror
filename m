From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: sh -x -i -v with continuous integration, was Re: [PATCH 1/4]
 t7601: test for =?UTF-8?Q?pull=2Eff=3Dtrue=20overrides=20merge=2Eff=3Dfal?=
 =?UTF-8?Q?se?=
Date: Tue, 19 May 2015 15:22:49 +0200
Organization: gmx
Message-ID: <dc9d4364b795ad0c9d128a9e0c06e681@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 15:23:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuhUC-0008Un-R1
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 15:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbbESNXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 09:23:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:64334 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbbESNXC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 09:23:02 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lm7MT-1ZTlBT1S4X-00Zj3l; Tue, 19 May 2015 15:22:50
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:OSf75+xO5acwlwZRB89lgsofwN4V/fHhIGusJIQKUzHfCoupB2v
 s4LSnwncyfgVRrZu97lebOfO+iPe7Pokyyts5ownhip9m9y1Kt73Vfjn80gebXoMnR4EsdF
 ZvVJDq70G1mCIpwiG2V7c43igNb6m4CBT0Y9Nr69nvTNGLMkDdAnfXD0zF3FCyLYDnocb/e
 NtgNEmoQ8izzDHthbAOzg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269352>

Hi Paul,

On 2015-05-16 14:33, Paul Tan wrote:

> On Fri, May 15, 2015 at 12:53 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> Asketh and ye shall be given: without running the tests in parallel, our Jenkins would take *even longer* than the three hours per test suite run (which is really painful, still, by the way). And as you know, running the tests with "-v -x" is awfully useless if you run the test suite in parallel.
> 
> Would the --tee option work for this case?
> 
>     --tee::
>         In addition to printing the test output to the terminal,
>         write it to files named 't/test-results/$TEST_NAME.out'.
>         As the names depend on the tests' file names, it is safe to
>         run the tests with this option in parallel.

Thanks for pointing this out to me. This is such a useful option.

Now, who made that patch... Oh, wow, oops [*1*]. Time for a coffee, I guess.

Thank you!
Dscho

Footnote *1*: https://github.com/git/git/commit/44138559e8b7c89768a2450220b831847059311c
