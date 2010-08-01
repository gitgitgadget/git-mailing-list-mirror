From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: gitweb not friendly to firefox revived
Date: Sun, 1 Aug 2010 20:15:16 +0000
Message-ID: <AANLkTimZ_DxO_TGnDBwRnurcdFuct-t509F0+DRhHo+B@mail.gmail.com>
References: <20100801195138.GA1980@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun Aug 01 22:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfewO-0003z5-NI
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 22:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab0HAUPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 16:15:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63837 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab0HAUPR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Aug 2010 16:15:17 -0400
Received: by iwn7 with SMTP id 7so3378856iwn.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6hlXvZL7IFWQ8y5IBO9RbnIle3vDFG19+bQedxi5K6c=;
        b=fzFHOkb85STH3Ahik7DAEjIMZQsRknIcreUnUUr59ZwBOeeZuZePl1oNPWD6331uMs
         ocGdj4yJ8Lfw4+2AQBNUoeoju6uBFdeZl7BDR2WWTZKpWIAbFj+GtcwQVwU7Yf3WlxBt
         SoSl5Gwq2SOsj3HkilvPs4qUqIZTaNilsCKhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MBEHdSdeYLwaBDln65BoG6FOZ6nWcEyBn7Z5yH3WPP8/APLXeKYinz23AnkLLwcgyc
         RlnP6qzH/Lb2kDeH+0LuS3HjxDSsfXSGrl74OoDbe0l3ShO05/dytOZ3mVdKHpYIWa98
         7mbH6w/lN/cl4jLfHTI7TBgFLlFg48tGOAjkM=
Received: by 10.231.193.135 with SMTP id du7mr5247726ibb.176.1280693716169; 
	Sun, 01 Aug 2010 13:15:16 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 1 Aug 2010 13:15:16 -0700 (PDT)
In-Reply-To: <20100801195138.GA1980@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152381>

2010/8/1 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:

> This is with git 1.7.1 and Iceweasel (aka. Firefox) 3.5.10.
>
> Making
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0title=3D>"Search for commits $performed by=
 $author"
>
> in line 1694 of Debian's /usr/lib/cgi-bin/gitweb.cgi from the git 1.7=
=2E1
> package read
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0title=3D>esc_html("Search for commits $per=
formed by $author")
>
> this problem goes away. =C2=A0(Still my browser barfs when clicking a=
t the name.)

That fix seems correct, the author appears to have control characters
in his name. Probably as a result of some encoding corruption.

What's the URL of the Git repository itself? It'd be interesting to
see how that went wrong in the first place.
