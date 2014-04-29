From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 06:47:42 -0500
Message-ID: <535f915e3ed89_2719108f30817@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Apr 29 13:58:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6g5-0003SC-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933933AbaD2L6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:58:18 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:59986 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933447AbaD2L6S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:58:18 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so65744ykb.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=O7TNNlpz7HeFVv7O2iXPiw5fs9PdsaIRhr+B/GZsjaY=;
        b=um0IlxFPJzL+CjM/p+PHnE9eQIT8c48VCT7P6l4KgCNBdz+jrO2EP4qoVEQ75I1iuu
         4BXgQyvOakkUMQbIl/qymtyFBpbW8RB8kuNDg+bFOm0RzsnoyW2yy+DpLZ7Q6Y/pipo4
         3x05X17v9jiR0KxSydSks0NTEOtjR0YDws3kz4LQKxt/Mcn3ZB+9ZNRR5z6NdqnozKMb
         LwKUJngbGDu5nqMl0qsLK5iducDeP4IP+5gKY8snRAH9KWQ2mOoy8hFXHAQDJxmLhmPA
         +01kCOCGINvDhXaiHmccefllqWwcCwoq9pL9Qm2ofwrFCoL2a9Pc+SMH61VjCYQq8Vrw
         13LQ==
X-Received: by 10.236.179.69 with SMTP id g45mr39470922yhm.81.1398772697568;
        Tue, 29 Apr 2014 04:58:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id m69sm36264954yhn.16.2014.04.29.04.58.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 04:58:16 -0700 (PDT)
In-Reply-To: <752e9542-7450-4928-a9cb-79b9c3b69bcd@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247576>

James Denholm wrote:
> I've no right to say this, given that I've no contributions I'm not
> saying that you shouldn't work on the git codebase, you could very
> easily fork it and make the innovative SCMS none of us can see, and
> kill git. Can be done, if hunting really is the best choice as you
> say.

I already made a fork:

http://felipec.wordpress.com/2013/10/28/git-fc/

-- 
Felipe Contreras
