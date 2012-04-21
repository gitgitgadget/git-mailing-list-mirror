From: =?UTF-8?B?VmlsbGUgU2t5dHTDpA==?= <ville.skytta@iki.fi>
Subject: Re: [PATCH v2] completion: add new
 git_complete helper
Date: Sat, 21 Apr 2012 10:20:28 +0300
Message-ID: <4F925FBC.2030406@iki.fi>
References: <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
	<CAMP44s0Q2A_oKJx27ct9W__KVQkQxzst3H7gq6sZDhrCLDQaag@mail.gmail.com>
	<20120416204641.GH12613@burratino>
	<CAMP44s23_Qx3R9TX4frM-JYNv7XT3eVbcZ_D45nEdh0rq-O8kA@mail.gmail.com>
	<20120416205952.GJ12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bash-completion-devel@lists.alioth.debian.org, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org Sat Apr 21 09:20:46 2012
Return-path: <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcsbc-bash-completion-devel@m.gmane.org
Received: from wagner.debian.org ([217.196.43.132])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>)
	id 1SLUcf-0007rb-55
	for gcsbc-bash-completion-devel@m.gmane.org; Sat, 21 Apr 2012 09:20:45 +0200
Received: from localhost ([::1] helo=alioth.debian.org)
	by wagner.debian.org with esmtp (Exim 4.72)
	(envelope-from <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>)
	id 1SLUce-0006hJ-J8
	for gcsbc-bash-completion-devel@m.gmane.org; Sat, 21 Apr 2012 07:20:44 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by wagner.debian.org with esmtp (Exim 4.72)
	(envelope-from <vskytta@gmail.com>) id 1SLUcY-0006gh-Ls
	for bash-completion-devel@lists.alioth.debian.org;
	Sat, 21 Apr 2012 07:20:42 +0000
Received: by lbjn8 with SMTP id n8so4364428lbj.6
	for <bash-completion-devel@lists.alioth.debian.org>;
	Sat, 21 Apr 2012 00:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:x-enigmail-version:content-type
	:content-transfer-encoding;
	bh=PO1Bz9oPXu0OyLT6vS9Nol5v/3/O2mnDme8bos247zM=;
	b=vpXOpXu8q8nXQ7RmcQxOrXDMD9oUIp8lrkTzhPuXskIqF0BeRv+A1sClcRHFVxoaya
	egq+41T1PyO8TUsGyxy8NYiNs2FILFwuiBqCPzecfaHreIZl1xuV3oSkhndsdlZxRywb
	G1HRav4Rnh80n03xVEupLysbYtqztE8DeNukYjTkLpFqwF6dUP5x73+PBbMMOZ1E0h4Y
	eOXGEnAnmw3fB5QcX9+Y3nrqlaFI7OpBZOqNWtFpRbxbKa/NWe30bzxSzqUM0S1CmDLH
	i37vn8sKRPool8JeUiWCM9YQBysbzU2mHlPG2sgsWkzHOVeno7Gr3pw1J1owGf/f6M4V
	0saA==
Received: by 10.112.47.66 with SMTP id b2mr4315777lbn.35.1334992831669;
	Sat, 21 Apr 2012 00:20:31 -0700 (PDT)
Received: from michael.steam.fi (cs78200229.pp.htv.fi. [62.78.200.229])
	by mx.google.com with ESMTPS id gw17sm8183009lab.11.2012.04.21.00.20.28
	(version=SSLv3 cipher=OTHER); Sat, 21 Apr 2012 00:20:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <20120416205952.GJ12613@burratino>
X-Enigmail-Version: 1.4
X-policyd-weight: using cached result; rate: -8.4
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on wagner.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1
X-BeenThere: bash-completion-devel@lists.alioth.debian.org
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: Coordination of bash-completion's development
	<bash-completion-devel.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/cgi-bin/mailman/options/bash-completion-devel>,
	<mailto:bash-completion-devel-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/bash-completion-devel>
List-Post: <mailto:bash-completion-devel@lists.alioth.debian.org>
List-Help: <mailto:bash-completion-devel-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/cgi-bin/mailman/listinfo/bash-completion-devel>,
	<mailto:bash-completion-devel-request@lists.alioth.debian.org?subject=subscribe>
Sender: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org
Errors-To: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on wagner.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196044>

On 2012-04-16 23:59, Jonathan Nieder wrote:

> Hopefully this information helps clarify to what extent the leading
> underscores in functions exposed by completion scripts are meant or
> are not meant as a convention.

We've discussed what a real "API" or "namespace" of bash-completion
would look like, but so far nothing concrete has come out of it.

http://thread.gmane.org/gmane.comp.shells.bash.completion.scm/2013/focus=3135
