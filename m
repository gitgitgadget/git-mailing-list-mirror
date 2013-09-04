From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: German translation errors
Date: Wed, 4 Sep 2013 13:11:39 +0200
Message-ID: <CAN0XMOJn7_c51G=peUKJzNqkQpWu7JQ8Uv2TB+hpvUO1ztPEPw@mail.gmail.com>
References: <2896292.CgjyIcF3NN@moria>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Dirk Heinrichs <dirk.heinrichs@altum.de>
X-From: git-owner@vger.kernel.org Wed Sep 04 13:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHAzx-0005BM-Fw
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 13:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996Ab3IDLLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 07:11:41 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:47145 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514Ab3IDLLk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 07:11:40 -0400
Received: by mail-wi0-f176.google.com with SMTP id cb5so3257792wib.9
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sdQHmlbTNh/uWjTj+J4BMJKQMX5zjOELa3O1ZbwBbBU=;
        b=SvvEJMGCdN51Zwb860Ggn3p6vh3z4iRtb3LVEPM8CctQe6K4T0fpVED229nJICNcNs
         7c35lo9xv8Nsy0mbZNIEHkF7Y/H6xy+3ZU+vX38qjXmr1kM6BWr1g3/ldB5UxaoZ+A47
         J1p43LHLk81FM6ga1Kgy2aTZZ4grzs7h02QEKFNJJLTEOWlqcPpRgDpVDAc6Jjhd8TAw
         F/firLKlMN3ItjJBh7tJvlW3P16XhNxRHLBE2SmCIIsIjtMLGIox3Nwv5n+Q8RPAZmTp
         aw3iFEsaSqMJGNUlNJUPhpHeTAyW48vPFFEDt89y6nARe3Z9qA2YLqpUA3EWbM2d+4zu
         wY2g==
X-Received: by 10.180.188.49 with SMTP id fx17mr1601542wic.49.1378293099469;
 Wed, 04 Sep 2013 04:11:39 -0700 (PDT)
Received: by 10.194.169.2 with HTTP; Wed, 4 Sep 2013 04:11:39 -0700 (PDT)
In-Reply-To: <2896292.CgjyIcF3NN@moria>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233830>

Hi,

this is not an error but intention. From Git 1.8.4, the German translation
switches from pure German to German+English. For me the most important
reasons for that are that terms like "Branch" and "Tag" are well-known SCM/Git
terms for many German people, and using "Zweig" and "Marke" could be more
confusing than just use the english words. It's not just these two
words, but also
terms like "remote-tracking", "index" and some such. The second reason is to get
closer to books. The books I know do not translate Git/SCM terms, e.g. the
Pro Git book [1] and also books you can buy on a store. I think it's better to
read the same terms in Git messages as you read in books.

Ralf

[1]
http://git-scm.com/book/de

On Wed, Sep 4, 2013 at 8:24 AM, Dirk Heinrichs <dirk.heinrichs@altum.de> wrote:
> Hi,
>
> when I fetch from remote repositories, git tells me about new branches and
> tags by saying "[neuer Branch]" or "[neuer Tag]". While "Branch" translates to
> "Zweig" in german, the german word "Tag" actually means "day", so git is
> telling me something about a "new day" for every new tag. Should be "neue
> Marke".
>
> Thanks...
>
>         Dirk
> --
> Dirk Heinrichs <dirk.heinrichs@altum.de>
> Tel: +49 (0)2471 209385 | Mobil: +49 (0)176 34473913
> GPG Public Key C2E467BB | Jabber: dirk.heinrichs@altum.de
