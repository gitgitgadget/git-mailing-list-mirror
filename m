From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH i18n 00/11] Mark more strings for translation
Date: Sun, 22 Apr 2012 10:24:44 +0700
Message-ID: <CACsJy8An8qsR=T8f4ouS8FMut4Z+NOTy5w_pdzjYVyPJ8AEDyg@mail.gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com> <20120418194021.GB30361@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 05:25:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLnQy-0003rx-KH
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 05:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab2DVDZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Apr 2012 23:25:17 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:55223 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2DVDZQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2012 23:25:16 -0400
Received: by wgbds11 with SMTP id ds11so1666194wgb.1
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 20:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XvD7R9KAdJjEJJpMJ51LR2pMkbml14odkbqoHvO8Ea0=;
        b=Tj4HC4xyalRMxdM/HalwQMG5BVmNaNTFY8z/x6evuCvmdFrJw9f9gqO2WgOHu5F9SG
         RXb0BCYd21fKczfmZRbc/5GNlGxwfVPKwcoiLQmpoYpRRd4Sl6g1vA72JTyx+Ah0K5jQ
         nnstUa3pFdigb9+yiaE7X1zU8nOO65xlxk95mHZqBjmqpXkBiGhaBs1kK0Aai24Q3LZ7
         237k4gFb+zSWjxu/XeeHWOtnWasiTiPnOOok+jmVrHMUNxGByOqPwyFCAzHy/9YPPb7Y
         QQgoEoe/nIZfbbavU5dC5tUw94jx0DlTSKQWAItJ1pMHp0jedkzRENx1FqFDXd6FfSrF
         HEBw==
Received: by 10.180.107.104 with SMTP id hb8mr10276394wib.8.1335065114596;
 Sat, 21 Apr 2012 20:25:14 -0700 (PDT)
Received: by 10.223.16.194 with HTTP; Sat, 21 Apr 2012 20:24:44 -0700 (PDT)
In-Reply-To: <20120418194021.GB30361@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196071>

2012/4/19 Jonathan Nieder <jrnieder@gmail.com>:
> My main reaction is that it would be nice to find a way to check that
> parseopt users correctly mark their messages for translation while we
> remember. =C2=A0But that doesn't need to block the series. =C2=A0Idea=
s about
> mechanism from gettext wizards welcome.

How about we use msgen on git.pot to produce all-translated .po file.
Then gettext(foo) would return foo if the translation is not found
(i.e. the string not marked). Now I don't know how we force loading
this special .mo file..
--=20
Duy
