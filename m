From: Ivan Lyapunov <dront78@gmail.com>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 13:14:48 +0400
Message-ID: <CANKwXW10tA+qNZ21YYcZxFLL4fWVRhq42nrkSogtmwAMTgPAzQ@mail.gmail.com>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx> <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
 <CANKwXW2h1+CGw2M3CmeXzXAX+wdCPgs5Ff_bGvTgYVpkwpijUw@mail.gmail.com>
 <CANKwXW0WkZXJMi+6T8ymvTi5-JpRfrn_xKmjGw-FsXpaCGuK5g@mail.gmail.com> <20130417082701.GP2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 17 11:15:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USOSn-000568-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 11:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966009Ab3DQJPa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 05:15:30 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:39402 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965887Ab3DQJP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 05:15:29 -0400
Received: by mail-vc0-f175.google.com with SMTP id ib11so1129049vcb.6
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=+/honjtUTNyTeTBvvkRbkbWS6IIcO1C2tU+c1XJcJa4=;
        b=vur6d5kFvldtY3Hs0WatsINWZSnp6Bd7qxsr3NARuJEduzwbL/RA0SrGsrLIW6eYi6
         88x+c4jvZtK4wDBC9+1NUH4xsqRoLmK7FBmh1ZJipuzKVbb7ZQbv4pZd5OOu+CdbIH7Z
         NG3WrZzt7RDPrvOgJHJ7Z8aIMJwnOCKDxIld0my4wX8kX/sRP42jdy9aTgfnA1+4ElbH
         G/SMh980Zen7zgOmEM9NvGfNos2Ktk1ocIbL07TFX/uFbfHNqCigjgWheS4XWIQtHQfH
         EG6DlzuK4au8S4R0nSy0VcHET3uB6FYAEPfCGop9LnOOgVL1Hd+jS9STr2owElhsSoNZ
         tFxg==
X-Received: by 10.58.34.12 with SMTP id v12mr4108540vei.55.1366190128681; Wed,
 17 Apr 2013 02:15:28 -0700 (PDT)
Received: by 10.58.231.161 with HTTP; Wed, 17 Apr 2013 02:14:48 -0700 (PDT)
In-Reply-To: <20130417082701.GP2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221524>

netbeans use some integrated git wrapper and I don't know about JGit
source base or not. In Eclipse we use Egit. Also all broken commits
limited to november 2012, but we still continue to use the same
development environments without any problems
Ivan

2013/4/17 John Keeping <john@keeping.me.uk>:
> On Wed, Apr 17, 2013 at 09:22:01AM +0400, Ivan Lyapunov wrote:
>> I checked Ren=C3=A9 Scharfe's patch and it works - no more git log c=
rash.
>> Also I checked a broken commits by git show and the most of them
>> created by me. I can confirm I never used anyting else except consol=
e
>> git commit or netbeans gui to commit, which is just git gui wrapper
>> tool.
>
> Doesn't NetBeans use JGit[1]?  That makes it a bit more than a wrappe=
r
> for the Git command line tools.
>
> [1] http://eclipse.org/jgit/
