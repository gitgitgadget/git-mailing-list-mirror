From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 10/44] ruby: rewrite 'request-pull'
Date: Sun, 29 Sep 2013 10:29:35 +0530
Message-ID: <CALkWK0kcu9YcOGgO45TqOYtsYd=g8GW=ELR=-SdgQJDcWTbaxQ@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com> <1380405849-13000-11-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 07:00:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ97E-0003ud-KK
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 07:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab3I2FAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 01:00:17 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33607 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3I2FAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 01:00:16 -0400
Received: by mail-ie0-f179.google.com with SMTP id e14so7423249iej.38
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D+LrgRIOwQ7HchcvNlj3eCQYWd4YBmYA1+SLnph+03E=;
        b=akrnFfEzxbvpz3QDmK4iZcpJBiex84bJfic0vlQJBqcNXV3j2YTAw6Kg6W9wSOwLYr
         3kJxzY5/qaXOdTKTfaajdyehAylei4blVefGwgB1DSc8Tx9pa6DZuBviuV29A9CgpYyk
         OXb04R7EOzgeBfAdySLn2sAF/a0iqGQoya1kd2cQD+C4nbfB3cDl5mQ4oD/jpK6w1YZ5
         8lfoim1Iztxdl5Yrqmg/I0SRgAenRWfPlLqeVF47azxeeC4zoXmKXZL2enmS+BIIcyZ1
         59/v5ZExiyn1nUzsXNmoDWQIDD7uV9V9cH4gyxajQiLmeqRIV8K3lq0kxdbq58bKHZlr
         y/GQ==
X-Received: by 10.50.23.16 with SMTP id i16mr8727680igf.50.1380430815231; Sat,
 28 Sep 2013 22:00:15 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Sat, 28 Sep 2013 21:59:35 -0700 (PDT)
In-Reply-To: <1380405849-13000-11-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235586>

Felipe Contreras wrote:
>  Makefile            |   3 +-
>  git-rb-setup.rb     |  17 ++++++
>  git-request-pull.rb | 146 +++++++++++++++++++++++++++++++++++++++++++++++
>  git-request-pull.sh | 160 ----------------------------------------------------

Excellent: git-request-pull is now an ELF executable! Normally, one
would move the older script (git-request-pull.sh) into
contrib/examples during such a rewrite, although I don't see the point
of doing that.

The proof is the pudding: all the request-pull tests pass.
