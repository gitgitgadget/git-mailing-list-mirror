From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] subtree/Makefile: Standardize (esp. for packagers)
Date: Sun, 27 Apr 2014 13:01:42 +1000
Message-ID: <b883baa0-740f-4d2a-b7b1-4cc9294f88ed@email.android.com>
References: <1398304336-1879-1-git-send-email-nod.helm@gmail.com> <CAHYYfeGNDLVxzP6zMyJnSi8GxpQaUKGAkqaLfXbZ=8B1k7vvyQ@mail.gmail.com> <3cb4338e-de68-404d-86dc-70cac7e13606@email.android.com> <20140426072520.GB7558@sigill.intra.peff.net> <6a7bcc79-d9c3-4cf8-8f3b-a6a16298c221@email.android.com> <20140427025150.GA26382@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 05:02:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeFMb-00053n-Ft
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 05:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbaD0DBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 23:01:55 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:61269 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaD0DBz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 23:01:55 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so4556707pbc.16
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 20:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=TwCPw5vR2XhaPOaGWxtj0sW4ZOACPbOSTQNJypNtYwE=;
        b=umqEOr0XSK7zdxB5LgizJie5IvCX+nmSycijazexlFeYvnMHKMbiwVRvDuPTsRPiR3
         RZl3jLkqZGp4U1yCXpL6v6rBfva4od4HDwtH9bExTMfv2pO+vJ6+akBcAvkfB6lXdSGk
         ND+U+EUAhAMyUMukb5KFO86ACw1Kv3s45o7HHqRjwqjAD7IxwT0Mt+umhvmFhB3PMqlH
         R2Yyt/v6d838Bxwro3PWFtPQu3D72AVJCdjo1nQyU/jfwzWTjYBBQKOXNZtTjwg+kof7
         bgHQNQhgrYmyG9PIE3ybzv6T4PqXQyym27SJkg8DHKyrMkvDBu2kpOtWeKixW+MOmsNj
         4FXQ==
X-Received: by 10.68.129.169 with SMTP id nx9mr400316pbb.136.1398567714898;
        Sat, 26 Apr 2014 20:01:54 -0700 (PDT)
Received: from [10.92.67.121] ([101.119.28.35])
        by mx.google.com with ESMTPSA id pr4sm25618639pbb.53.2014.04.26.20.01.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Apr 2014 20:01:54 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <20140427025150.GA26382@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247192>

Jeff King <peff@peff.net> wrote:
>On Sun, Apr 27, 2014 at 12:35:13PM +1000, James Denholm wrote:
>
>> >Do we even make [subproject and mainline] anymore? It looks like
>they are part
>> >of the tests, but the whole test script runs inside its own trash
>> >directory.
>> 
>> subproject and mainline are actually made in  contrib/subtree,
>> but I'll look at perhaps "fixing" that when I split the proposal
>> into a series as you suggest.
>
>Are they? I couldn't find any reference to them as directories except
>in
>the test script, and doing a "make" from contrib/subtree didn't create
>them.

Yeah, I could be wrong as I don't have the code on-hand at the moment,
but from memory they're made and populated by the test script as
well. Either way I'll move all that into a subdir of t/ and rejigger the thing, if
investigation reveals that as the Done Thing.

>I'll leave it to you to investigate further whether the "clean"
>rules are cruft or not, but certainly if they are, cleaning up cruft is
>a good thing.
