From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (May 2016, #02; Fri, 6)
Date: Tue, 10 May 2016 07:52:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605100751050.4092@virtualbox>
References: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 07:52:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b00ax-0004Ud-Q0
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbcEJFwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:52:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:59935 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbcEJFwb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:52:31 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LoVOE-1bXgRk2W8w-00gUgd; Tue, 10 May 2016 07:52:18
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ef1G87enzDa1GXH3wCmoSfVQ6xgu+7KyVAeMA/qCrPWieUa78wN
 lFwOLzRCtck/Tz/jnPSG5DxkcgozpoFnNnOuDliyYgVr1FzbDOhwz0OHmXuojsVSu8UnX1v
 y5Z7/IsQ3IxhHH+YiqsJ9UzATjSq3Tn8VJJ+AVI3zER41/oqLG1czgVISvX1EVcsWHZwCWu
 YTE875ki0O5fFLJoprHsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:56Ya2yNljKI=:71aIvhJhlPAX15bd6Z3+tT
 jIpwp5ke52SSZRRIOJ5J9X7Mu3tusVhGgv9uC688Ahszl61XCRtuxTF+pUKBYYRvnooh5AcYH
 YYmq0Qs1ZViSzPRC4/hPZ8lKYPnuFP7jz8AL1w+Bz06LY6PijUIwMcjuZeR0LaYsF5SZWcddD
 SHwnhc8yyYFaF3VF5jNILUY/moBhs1APHzFupi/UUxnQnfj4T4x3nPhFRBuxuPc9wveml+mjZ
 nE+Nwipjuwzl0nqmx/HDcwUW32oaNObiTWUs2tA8CZISpZcaJshj9C+QgSwWdPortY4FwEvVC
 2koFFvEbLwS3EsK0eO7Hn8y6K+b4/gY7qXWbHy3NK8t5CSo/TokbDgVIOSx5eU9PvuOFt5wd6
 WYl10TVYaxwLE6nNfzwr9py7xZhaBa7sp8RJx0TD+6kG6DAiHuSneZs3bSSzBcxqeq23YeYbj
 5xQy0PULDIvaHvE5LKy24EMniY56d92YLU9pjcspWCu7/uULa8mNltK0FMioEhbl4Fw6+tVfH
 e3AG6+31ZseE9ErPN6yClU0iW//oBfgKPwZoyKRTptbdee1D9PW5S1CC3kk9FuEJ0toT1blzc
 24LrKkSpNE42l8TBUIbyiYE00wOpwyKqoFPnj5bTsC6orJmEzG8UyiLqosU8721zbc1wPtP0N
 dro/tAe91CV2j+ALCTuCoZ6oQdY0yMTh13qGP0uGHMmOEUoePq25SEHAWpSMtPaN/q69E5CqY
 LiI/NhHPUN4M3lfJGBL7veTd9GgeW442cr0BRXX72+d0jdsgPJVwxqg/OiyHBFYMkqSzCLCm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294095>

Hi Junio,

On Fri, 6 May 2016, Junio C Hamano wrote:

> * jk/submodule-c-credential (2016-05-06) 6 commits
>  - submodule: stop sanitizing config options
>  - submodule: use prepare_submodule_repo_env consistently
>  - submodule--helper: move config-sanitizing to submodule.c
>  - submodule: export sanitized GIT_CONFIG_PARAMETERS
>  - t5550: break submodule config test into multiple sub-tests
>  - t5550: fix typo in $HTTPD_URL
> 
>  An earlier addition of "sanitize_submodule_env" with 14111fc4 (git:
>  submodule honor -c credential.* from command line, 2016-02-29)
>  turned out to be a convoluted no-op; implement what it wanted to do
>  correctly.
> 
>  Everybody happy?

I cannot speak for everybody. I am happy, though. In particular with this
topic branch ;-)

Ciao,
Dscho
