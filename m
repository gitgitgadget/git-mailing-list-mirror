From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: Problem: staging of an alternative repository
Date: Thu, 1 May 2014 22:23:25 -0700
Message-ID: <CAKpPgvcbYf4nJPqYECOe3Kkgk-UnYrWePYkz76NU+-ok_6AqUQ@mail.gmail.com>
References: <CAKpPgveXqraM4bXb499mJm5Ls+EinihfEJ6VgOFikC0_Qp8iTA@mail.gmail.com>
 <20140430213545.GV9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 07:23:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg5ws-0000mC-5o
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 07:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbaEBFXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 01:23:46 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:52536 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaEBFXp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 01:23:45 -0400
Received: by mail-oa0-f45.google.com with SMTP id eb12so4690949oac.32
        for <git@vger.kernel.org>; Thu, 01 May 2014 22:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BA52w4dyuv8Fss35IZYoEsNhrXSFkDXIecbHmu1t2uw=;
        b=04TuyHayZARjbh6NKY8oP0FgW9TKNIiV9ieNtd3Q/IxKv7rwp1Rq9PhJ9lQEfTzqG+
         1YEbEdknllCQnJwgmVRgHm0pK15SiwSO8trlbQvBga1psgn9IfNMNMk5+uN2qW2sRrdd
         miQjJDjIfxqRSx/QsdpULEaqR9n/BPwMeV57txyhMmtaW2LdTJLdZbHpmizaRtypqSZe
         69M2NepIfPrOmYHluFKs5dIFhy9Nm8NR0SI09RcHcZ+pQPuq4DgUWwpWYo0eC3WioUV5
         de9Xefg82wnQZkPRH73whypKR6ohhGtqPykNfz9/Ry4YTRxIazsUDNJUJ0F6Dn+OBOf1
         PlOg==
X-Received: by 10.60.159.5 with SMTP id wy5mr81060oeb.58.1399008225432; Thu,
 01 May 2014 22:23:45 -0700 (PDT)
Received: by 10.60.246.39 with HTTP; Thu, 1 May 2014 22:23:25 -0700 (PDT)
In-Reply-To: <20140430213545.GV9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247924>

    Hi Jonathan

Thanks for the answers

> I think it's more that it never came up.  Excluding the current
> $GIT_DIR from what "git add" can add (on top of the current rule of
> excluding all instances of ".git") seems like a sensible change,
> assuming it can be done without hurting the code too much. ;-)

I did notice it to have come up in the forums in some related but
non-transparent ways.

Anyway, this can hopefully be easily fixed and I can look into it. My
understanding is, that unlike the special treatment of ".git", the
alternative repository (call it '.gut') should only be "ignored" at
the *top* of the work tree and not anywhere deeper inside. And of
course, the special treatment (that is, the ignoring) of ".git" should
be kept as it is. Am I right?

   regards
Pavel
