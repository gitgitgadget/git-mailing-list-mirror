From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Mon, 5 May 2014 12:53:48 +0200
Message-ID: <CABPQNSb83H7EEeAfaxC7KVpZmv-KEqE1wavTf53kA=aoDQz4Tw@mail.gmail.com>
References: <1398702545-9860-1-git-send-email-kusmabite@gmail.com>
 <xmqqfvkuhm77.fsf@gitster.dls.corp.google.com> <CABPQNSZUCPd=1Eu8VUCP01tkdYkBC=xspFZuDuywuYZUH8ewvw@mail.gmail.com>
 <alpine.DEB.1.00.1404301851210.14982@s15462909.onlinehome-server.info> <CAHGBnuPrQzSAVRZCneHdodAAQjA4dkGk0AguNm3xhW+cQ4XESQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@gmail.com>,
	Marat Radchenko <marat@slonopotamus.org>,
	tuomas.silvola@knowit.fi, msysGit <msysgit@googlegroups.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:01:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhxY-0005Yp-BB
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbaEEKya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 06:54:30 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:58857 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbaEEKy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 06:54:29 -0400
Received: by mail-ig0-f170.google.com with SMTP id r10so4245553igi.1
        for <git@vger.kernel.org>; Mon, 05 May 2014 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hB/8uF1BGZ5Y7Qfn+0SSCr7yqANnXZS/zxekOEoPONE=;
        b=VtweXXLK6gSYyPIIhUO29Mj1FiNqCm7gTWHTrU6z8p3cfcx1tspXauRdIWuTR96zqr
         MqXOCtVDnFRrljLTOxdC6FwjOGwKF/ltm5D7Ng0ScOtGgtXV5XUCVnHSNLOAjALlnoJk
         zi1dAUH2eSFXQ4g+pYZxmmIYVXUdwFEr9udQxjH9wkdMvpEruYg24nnSEcT+Z5fpGkTT
         iZKj1RRTzlxEdnh50HLBmxG0LCt+9QXgahNWhAnyzmosdLyECOpHhWqV6FSg9HESbkK7
         n1n1Xw53AdqSX0J54XGrrF68acyIyx0bwa+JNL+/AoXU4Pphd1MGC/68ziCYk7jNM6pl
         VS3Q==
X-Received: by 10.50.85.37 with SMTP id e5mr22199977igz.43.1399287269116; Mon,
 05 May 2014 03:54:29 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 5 May 2014 03:53:48 -0700 (PDT)
In-Reply-To: <CAHGBnuPrQzSAVRZCneHdodAAQjA4dkGk0AguNm3xhW+cQ4XESQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248165>

On Wed, Apr 30, 2014 at 9:46 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Wed, Apr 30, 2014 at 6:52 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
>>> We can keep this patch in the msysGit repo for the 2.0 release.
>>
>> FWIW the plan is to switch to mingwGitDevEnv for the 2.0 release. It is
>> not quite clear as of yet how patches will be managed with said
>> environment.
>
> The environment is just that: The environment to build Git for
> Windows. This means that patches on top of Git for Windows could still
> be maintained in msysgit/git (or a fork thereof) on GitHub.

Thanks for the heads up. Even so, are you guys OK with me pushing this
patch to our downstream repo?
