From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Why usage function exit with code 129?
Date: Fri, 6 Jan 2012 14:22:56 +0700
Message-ID: <CACsJy8Amo_9-9oCgHbwOZvTaNOV3Jj6wLCTU7nZT5LeA55=NEA@mail.gmail.com>
References: <CAMocUqSbiO2XC3PUEciyV3HxgqDPW_rTW-hYH4P=C=BFCSrQMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?R2l0IOmCruS7tuWIl+ihqA==?= <git@vger.kernel.org>
To: =?UTF-8?B?5b6Q6L+q?= <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 08:23:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj49M-0008H1-2K
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 08:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab2AFHX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 02:23:29 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63477 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab2AFHX2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 02:23:28 -0500
Received: by bkcjm19 with SMTP id jm19so248449bkc.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 23:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=G8py8vMybPn9auz5huTE+8cwyhzgbHf/YCraKFZd/HI=;
        b=d9pdAOeiF6Fl0XJERUwE+pOonECU2loZX8cjL8ZiNlvIbaZKfjD8TQbgIENwlrBHX4
         tBbq3EvcE5QjMQw9JZfDV5dQUjT/1JVGk++pBoWmJXhhC98+KGRxTAc4zDQJfmP6KxBX
         N8s7P27lQX6ts9ZaZFFRbBNGjlipqFdJ41LSQ=
Received: by 10.205.133.139 with SMTP id hy11mr2100232bkc.98.1325834607195;
 Thu, 05 Jan 2012 23:23:27 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Thu, 5 Jan 2012 23:22:56 -0800 (PST)
In-Reply-To: <CAMocUqSbiO2XC3PUEciyV3HxgqDPW_rTW-hYH4P=C=BFCSrQMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188013>

2012/1/6 =E5=BE=90=E8=BF=AA <xudifsd@gmail.com>:
> I did like this:
> $ git add --foo
> $ echo $?
> what I got is 129, should this code being used as program terminated
> due to a signal? Cause it's 128+1. According to this[1].

usage() (in your case) always returns 129, die() 128. See 5d1a5c0
([PATCH] Better error reporting for "git status")

> [1] http://tldp.org/LDP/abs/html/exitcodes.html

No it does not mean terminated by signals.
--=20
Duy
