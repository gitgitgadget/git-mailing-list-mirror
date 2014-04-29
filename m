From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Wed, 30 Apr 2014 07:04:49 +1000
Message-ID: <e31d0160-c7e1-4e80-93bb-d1da590eb8b5@email.android.com>
References: <535C47BF.2070805@game-point.net> <535D6EB1.9080208@game-point.net> <535e18cdc7bce_338911e930c72@nysa.notmuch> <87bnvl6bdg.fsf@fencepost.gnu.org> <535e8e4253196_45651483310b3@nysa.notmuch> <152626b3-0642-4e26-9333-7d911d45c669@email.android.com> <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch> <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com> <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch> <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com> <535f62c1e740a_45e485b30887@nysa.notmuch> <87r44g33z4.fsf@fencepost.gnu.org> <535f702352d21_3aee3b2f0b9@nysa.notmuch> <87mwf431t3.fsf@fencepost.gnu.org> <535f76db38a34_6f23159b31099@nysa.notmuch> <87eh0g30it.fsf@fencepost.gnu.org> <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch> <752e9542-7450-4928-a9cb-79b9c3b69bcd@email.android.com>
  <535f915e3ed89_2719108f30817@nysa.notmuch> <514ff3d6-aea5-4b1d-8ff4-14e779876fb1@email.android.com> <535fa9b15a495_6d5dff2f0e0@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:05:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfFDK-0000rk-Ka
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 23:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbaD2VFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 17:05:13 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:40324 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaD2VFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 17:05:11 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so805233pad.35
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=EKAnekXxnR4nr2+Yu/4Xs66b2LBWaHpCCle8EoBQbD8=;
        b=wWxBsiMnALpM78sUIEub62onNKqbe6Rb9c1k58ioUvFY8ab/KlanozggCXQNuZzNfa
         b5m0IB55EhdXByleoptZsa31PKaoJm10wBaoR0A9iF9EJ2zymRKjVjuR/eLTw32wbXco
         pjY77eeR25pbDO42XsB1gi1oUgz4OYy+gNc8LnBrnm0FH0HJXvw2WOLD4tvd7WRpmQT8
         KfypADsQOCHXQku5M/uKnex4gPb775jcSY9V/zoKDYHJF8N/xr38NSOovU1PzrL8zuj3
         AgksOQpFN/+XgVf2vM3rMSSlHwjLU9i/HKA4tfOgfPE4EjWp2/JS9m0vX/2sFqb+0emx
         kGPw==
X-Received: by 10.66.230.193 with SMTP id ta1mr305051pac.29.1398805510811;
        Tue, 29 Apr 2014 14:05:10 -0700 (PDT)
Received: from [10.83.103.106] ([101.119.29.20])
        by mx.google.com with ESMTPSA id yq4sm118546826pab.34.2014.04.29.14.05.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Apr 2014 14:05:10 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <535fa9b15a495_6d5dff2f0e0@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247609>

On 29 April 2014 23:31:29 GMT+10:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>James Denholm wrote:
>> So that we can all have egg on our faces when it takes off and is
>> proven superior... Right?
>
>I don't know what you mean by "we", but it certainly doesn't include
>you.
>
>  % git log --author=nod.helm@gmail.com master
>  empty

Sure it does. I didn't (and don't) have any impact on the
debate and resulting community views, but I recall recently
that I prescribed to the arguments that default aliases
are a bad idea. I'm not arrogant enough to suggest that
my views matter at this point, but if git-fc is proven superior
by community adoption, I would be as wrong as anyone else
who held that view.

So I'll ask again - you've described frustration at the
pace of git development, and that you feel that your patches
aren't being accepted. If you feel that this is ultimately to the
fatal detriment of git, why are you still trying to convince
vegetarians to join you in hunting when you could simply find
a more willing group?

Regards,
James Denholm.
