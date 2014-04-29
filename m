From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 08:31:29 -0500
Message-ID: <535fa9b15a495_6d5dff2f0e0@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <87bnvl6bdg.fsf@fencepost.gnu.org>
 <535e8e4253196_45651483310b3@nysa.notmuch>
 <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
 <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
 <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
 <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
 <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
 <535f62c1e740a_45e485b30887@nysa.notmuch>
 <87r44g33z4.fsf@fencepost.gnu.org>
 <535f702352d21_3aee3b2f0b9@nysa.notmuch>
 <87mwf431t3.fsf@fencepost.gnu.org>
 <535f76db38a34_6f23159b31099@nysa.notmuch>
 <87eh0g30it.fsf@fencepost.gnu.org>
 <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
 <752e9542-7450-4928-a9cb-79b9c3b69bcd@email.android.com>
 <535f915e3ed89_2719108f30817@nysa.notmuch>
 <514ff3d6-aea5-4b1d-8ff4-14e779876fb1@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 15:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf8IU-00071s-UJ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 15:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbaD2NmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 09:42:06 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:45608 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbaD2NmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 09:42:05 -0400
Received: by mail-yk0-f180.google.com with SMTP id q9so181535ykb.11
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=FT7hj8aFsumRwyBKeGZDgIiBo26eoOb8+ij5LtB8Knc=;
        b=zBJ0xKpqb40Ymk+Gl3bHnIb8mR4p5CFNgVt1rEXQtFslGeDEYCRk8TCenYjQOjZHbK
         aWZFE6c6sn5IGIhJvfOXHdmzY7xeaM4YrcszTs/f4ko+I0aGWAL2ISASsoTLohX+i8Jw
         2wVJSijcy1f0JTyep5CpHE3Y3tjk7z8YiiCaPav5IsYnscdfU2XDZDYLK3/6fDneF0j1
         3ZHkyW/WFLu33AEpMmtdu4t5mzFSY4gN1TQVkI5YKkINuNUUZwur1rFX7LDvK1oNGtqp
         dFmyUGxvoR2wCVR7Cl7Cm9fJAq2jo+wMo7n+7AQ8N84YgkvNV7Px5dx+PwrB5VbAPL7x
         +Ovg==
X-Received: by 10.236.135.197 with SMTP id u45mr2559455yhi.150.1398778923563;
        Tue, 29 Apr 2014 06:42:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id z69sm36729939yha.26.2014.04.29.06.42.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 06:42:02 -0700 (PDT)
In-Reply-To: <514ff3d6-aea5-4b1d-8ff4-14e779876fb1@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247584>

James Denholm wrote:
> So that we can all have egg on our faces when it takes off and is
> proven superior... Right?

I don't know what you mean by "we", but it certainly doesn't include
you.

  % git log --author=nod.helm@gmail.com master
  empty

-- 
Felipe Contreras
