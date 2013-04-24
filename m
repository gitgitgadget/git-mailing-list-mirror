From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 01:44:08 +0530
Message-ID: <CALkWK0m5m4maMKYfyV=rr4TWDK1FZQXXwT=cPeGoMtx6+chJsw@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <20130424164003.GB4119@elie.Belkin> <7va9ones4p.fsf@alter.siamese.dyndns.org>
 <20130424192339.GH29963@google.com> <7vli87bsu3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 22:14:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV65f-0005jA-Mm
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 22:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757853Ab3DXUOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 16:14:51 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:43886 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757814Ab3DXUOu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 16:14:50 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so2035938iag.14
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QuLSrjI+KMBWBo7FeQeLhws6Ihxr8rgDgvOknaPKrs4=;
        b=orqSK6RkxdZMM+yohdD9lNsiOMaHeK15pE+btYg9CCmG61l0tNxtuaHcPiSwZYwCl4
         DtVe/klsMkyRm9uv0e8iO1SDXw8D1u5IChbFd8Ao32GAoJ3XjVxtS3lOoGhR0imeXZQn
         Zas4ji09CZnVG7NXD09qX15hlH19pNIx5AG2hVeIzCDAHgc6x4daji7614MD5O32e5rL
         RYp1p0/AgRmZBKud8BWq9icB0mNU0nDw/62SGA/GKF1ha/9ccMZJgxGLFr4kB+kapS5K
         ACdWD8dyTApnjO/a9WU8G92oJT3HPzsJw18VO0jXgz1HFSzKkRShpR0sulMS0e37sWCi
         gRwg==
X-Received: by 10.50.57.116 with SMTP id h20mr388735igq.49.1366834489974; Wed,
 24 Apr 2013 13:14:49 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 13:14:08 -0700 (PDT)
In-Reply-To: <7vli87bsu3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222315>

Junio C Hamano wrote:
> Yeah, I am not strongly opposed to have something like that, and
> having a shorter (but not a single letter) option name might make it
> more attractive than A...B at least to new users.

I'm not married to the single character or tilde.  What I'm saying is
that we should make it a rev spec, not a command-line option.

> Which by the way is nothing new.  "A" means the entire history
> leading to the commit "A" in the context of specifying a range, and
> the same "A" means a single commit "A" in the context of specifying
> a revision.

Exactly.  And I'm introducing a third context: "when specifying two
trees to diff".  Changing meaning in different contexts is not a
problem, as long as it is consistent and properly documented.
