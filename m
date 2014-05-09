From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 9 May 2014 10:33:28 +0200
Message-ID: <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com> <536c8e63448c2_25d198d30c55@nysa.notmuch>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:34:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WigG0-0004Q2-Ke
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843AbaEIIeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 04:34:10 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:46577 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbaEIIeI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 04:34:08 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so858394igb.0
        for <git@vger.kernel.org>; Fri, 09 May 2014 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KKe5+AOcdJvyzQpDhqt79vbar/Jf6QO0iHADadZhtYE=;
        b=jEz3I9xqg+mTFfkDFrfIRJ5g+EunFXmwsAL+WSUtUiuOQVUQmp5IOl7wVW/f6pGWv6
         O3DukSpG1vmj7TOx7/QgtjxH0zAwzGlVcrz8xTKFOpjl8ssxav7pPaDadovRgBky3De0
         /Y0N0pKRhgngO+qjBMpA4Nq95e7cGbLw8ek1d68yIlvWEmrEN/sczkKMz4jLx6gW2seo
         h3+YEZGEVXh7Fn4fxqO7yTFFKScV3hQ3jpO09QUQ++U7aDW7MnpsMRUgkcZfBuSUe/y5
         75eiWOhTfrqtGssvEyOJiwS42csu5XWHg/hvd12dDwW1YWwQIpqAemeh/vqC8qzfBTDB
         lkgw==
X-Received: by 10.50.22.69 with SMTP id b5mr6313174igf.45.1399624448140; Fri,
 09 May 2014 01:34:08 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Fri, 9 May 2014 01:33:28 -0700 (PDT)
In-Reply-To: <536c8e63448c2_25d198d30c55@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248533>

On Fri, May 9, 2014 at 10:14 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Erik Faye-Lund wrote:
>> On Fri, May 9, 2014 at 2:58 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > No activity since 2010, no documentation, no tests.
>> >
>> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> > ---
>> >  contrib/buildsystems/Generators.pm        |  42 --
>> >  contrib/buildsystems/Generators/QMake.pm  | 189 ---------
>> >  contrib/buildsystems/Generators/Vcproj.pm | 626 ------------------------------
>> >  contrib/buildsystems/engine.pl            | 359 -----------------
>> >  contrib/buildsystems/generate             |  29 --
>> >  contrib/buildsystems/parse.pl             | 228 -----------
>> >  6 files changed, 1473 deletions(-)
>> >  delete mode 100644 contrib/buildsystems/Generators.pm
>> >  delete mode 100644 contrib/buildsystems/Generators/QMake.pm
>> >  delete mode 100644 contrib/buildsystems/Generators/Vcproj.pm
>> >  delete mode 100755 contrib/buildsystems/engine.pl
>> >  delete mode 100755 contrib/buildsystems/generate
>> >  delete mode 100755 contrib/buildsystems/parse.pl
>>
>> Please don't. This script is useful to build with the MSVC IDE, which
>> enables us to use their excellent debugger.
>
> If you want this script to remain in contrib, please:
>
>  a) Write at least a few tests
>  b) Write some documentation
>  c) Explain why it cannot live outside the git.git repository like other
>     tools. [1][2][3]

(Adding Marius, the original author to the CC-list)

Uh, why is such a burden required all of a sudden? contrib/README
mentions no such requirements, and the scripts have been accepted (and
maintained) since. Besides, you say "No activity since 2010" - this is
not the case, bc380fc is from November 2013. And there's already
*some* documentation in the scripts themselves.

Please stop your pointless crusade that'll only break other people's work-flows.
