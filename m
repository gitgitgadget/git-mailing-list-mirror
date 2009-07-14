From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Weird behavior of git rev-parse
Date: Tue, 14 Jul 2009 11:06:57 +0200
Message-ID: <adf1fd3d0907140206v691cc27awf4f62397c5a491f8@mail.gmail.com>
References: <4A5C31CF.2090204@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 11:07:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQdyd-0002tP-Q8
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 11:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbZGNJG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 05:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbZGNJG7
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 05:06:59 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:46509 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbZGNJG6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 05:06:58 -0400
Received: by fxm18 with SMTP id 18so2676560fxm.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 02:06:57 -0700 (PDT)
Received: by 10.204.65.16 with SMTP id g16mr2448202bki.37.1247562417015; Tue, 
	14 Jul 2009 02:06:57 -0700 (PDT)
In-Reply-To: <4A5C31CF.2090204@ubicom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123232>

2009/7/14 Yakup Akbay <yakbay@ubicom.com>:
> Hi,
>
> instead of `git rev-list -2 HEAD` I've tried `git rev-parse -2 HEAD` =
just to
> see the effect of -N in rev-parse, but I've got this output:
>
> =A0 -2
> =A0 0294cdd1e2c5535f5b87eff4a1aff3390e03af39
>
> Then I've tried
>
> =A0 $ git rev-parse -'hi, this is a test!'
>
> the output is:
>
> =A0 -hi, this is a test!
>
> Is this an expected behavior?

There is no "-N" flag to "git rev-parse", neither "-'hi, this is a
test!'". The purpuse of git rev-parse is for porcelainish commands to
parse their argument, as the man page says:

git-rev-parse - Pick out and massage parameters

Many git porcelainish commands take mixture of flags
(i.e. parameters that begin with a dash '-') and parameters
meant for the underlying 'git-rev-list' command they use internally
and flags and parameters for the other commands they use
downstream of 'git-rev-list'.  This command is used to
distinguish between them.

>
>
> Another questions is, usage is printed if you omit the commit id in g=
it
> rev-list (E.g. `git rev-list -2`). Is there a reason why HEAD is not =
taken
> as the default?

You can say what is the default with --default <arg>.

HTH,
Santi
