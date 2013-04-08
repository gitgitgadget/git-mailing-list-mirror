From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 20:10:34 +1000
Message-ID: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com> <20130404185522.GM30308@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:26:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEtU-0003oz-BZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936322Ab3DHKLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 06:11:09 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38047 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935736Ab3DHKLF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 06:11:05 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so6024382oag.9
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1D1wcVuT2/ZsC6aJ/VNOB61PrwCfu/g0FUKGJJnl4h8=;
        b=rOOjUBxCygcXxTY9NQyAsIiR/Yy9PbqZ/Og3G5SO8H81ayI3hFGvKdl4i3hI5qawzl
         BQOzDc/cpixO+Ke5oqlQKJOMjLjAb+cbzOpKuZNYMYqqeDE4nw7ICJgmT81URpyuBLmD
         Hbd/3hRGuQr/wnPLNPRxzDu48kJiW4nChDWApxfdlwQVWXMCGbulATeIXRr0/Ng9mg9+
         D9nnulPXqPApqNwPvfSqk6VofksvSrhZXKsS8QF9G8DXWc6p4RnWxwf8NoIehPLMT0PW
         8pS2B6jNYP8+DAFJ/pigDdq7PkhzN4PlsTUf6c8NB0Bg1Dv7Cfj6EnbR0ssAjtISu3Kr
         VaLA==
X-Received: by 10.60.135.103 with SMTP id pr7mr13583424oeb.142.1365415864899;
 Mon, 08 Apr 2013 03:11:04 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 8 Apr 2013 03:10:34 -0700 (PDT)
In-Reply-To: <20130404185522.GM30308@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220414>

On Fri, Apr 5, 2013 at 5:55 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>
>> 1. 'git add' should not go past submodule boundaries.  I should not be
>>    able to 'git add clayoven/' or 'git add clayoven/LICENSE'.  In
>>    addition, the shell completion also needs to be fixed.
>
> Yep.  This is a bug.

I notice that this case is handled by git-add, but there is probably a
bug somewhere. Ram, can you make a test case for this?
