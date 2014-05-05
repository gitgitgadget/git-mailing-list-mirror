From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Mon, 5 May 2014 12:56:20 +0200
Message-ID: <CAHGBnuMTc8MuUd9_BtqkemJ--_fxmRroc0pym78hDF=Jc7KPLw@mail.gmail.com>
References: <1398702545-9860-1-git-send-email-kusmabite@gmail.com>
	<xmqqfvkuhm77.fsf@gitster.dls.corp.google.com>
	<CABPQNSZUCPd=1Eu8VUCP01tkdYkBC=xspFZuDuywuYZUH8ewvw@mail.gmail.com>
	<alpine.DEB.1.00.1404301851210.14982@s15462909.onlinehome-server.info>
	<CAHGBnuPrQzSAVRZCneHdodAAQjA4dkGk0AguNm3xhW+cQ4XESQ@mail.gmail.com>
	<CABPQNSb83H7EEeAfaxC7KVpZmv-KEqE1wavTf53kA=aoDQz4Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@gmail.com>,
	Marat Radchenko <marat@slonopotamus.org>,
	tuomas.silvola@knowit.fi, msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:54:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhxa-0005Yp-UA
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbaEEK4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 06:56:22 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:57429 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbaEEK4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 06:56:21 -0400
Received: by mail-yh0-f49.google.com with SMTP id c41so2738493yho.8
        for <git@vger.kernel.org>; Mon, 05 May 2014 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JN9UpBqI3TX5g+NAveNVjK+1EDSN8j4hUs/XrOATFZo=;
        b=02bOD12hgGQk+YJ9raiDOW3RAkTmJDJ9jZ5By73FrymKCWc3D/QXFOl1xvVrK+1t+x
         69nhr6znDNjVJbcHBBYufqsmebCFnShjAP6bMVg4zf+DPK004VL6lAtDqGGN/5Br75sR
         U/rZ7+yJWTZzsZlBrUzFxdUmYiigrxAmKBD7IxyMv5UpClF/HQ3wz2gkoxPOgjrzuPpw
         L1y5/AJOxxJHePlP8675TocLdbcE5JWJsxtQNpOBhnUe4wwupELYR+dVMJiyLKySSrU7
         ddVxgzaZCGDrT/prPD63a5863EDIDDG3V9pjei2n+4QcFaIYYdUNDjosF3+TW1ZZU4ud
         q0sQ==
X-Received: by 10.236.74.229 with SMTP id x65mr47103051yhd.131.1399287380729;
 Mon, 05 May 2014 03:56:20 -0700 (PDT)
Received: by 10.170.151.10 with HTTP; Mon, 5 May 2014 03:56:20 -0700 (PDT)
In-Reply-To: <CABPQNSb83H7EEeAfaxC7KVpZmv-KEqE1wavTf53kA=aoDQz4Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248159>

On Mon, May 5, 2014 at 12:53 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:

>>> FWIW the plan is to switch to mingwGitDevEnv for the 2.0 release. It is
>>> not quite clear as of yet how patches will be managed with said
>>> environment.
>>
>> The environment is just that: The environment to build Git for
>> Windows. This means that patches on top of Git for Windows could still
>> be maintained in msysgit/git (or a fork thereof) on GitHub.
>
> Thanks for the heads up. Even so, are you guys OK with me pushing this
> patch to our downstream repo?

Fine with me.

-- 
Sebastian Schuberth
