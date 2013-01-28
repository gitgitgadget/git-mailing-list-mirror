From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo operations
Date: Mon, 28 Jan 2013 18:11:06 +0100
Message-ID: <CAFXTnz6zN0izx8S23JFww5niVD6x-r2e7TSthqZnempUrvAEWw@mail.gmail.com>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
	<1359290777-5483-2-git-send-email-hjemli@gmail.com>
	<7vk3qywiqf.fsf@alter.siamese.dyndns.org>
	<CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
	<20130128081006.GA2434@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 18:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzsF4-0004UN-4l
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 18:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab3A1RLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 12:11:10 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:33374 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631Ab3A1RLI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 12:11:08 -0500
Received: by mail-bk0-f43.google.com with SMTP id jm19so996319bkc.16
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 09:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=L5S5+JjEC58YAQW6o9zGRRtTCrs8fG6WX0RvuP6C7FE=;
        b=UU/f79FcCtAjJ4xFFPxuloOF5XlcSMx6G4l3WZ+ZxypFjQriZIww0a7gr0mb72UkKo
         FyKVUrhoiTk7kf5W6e+7Ce8f7YWcJhzjk9s3XXoHstTLCiAHjIT4/aKNRzSsY6vxfQ1p
         ovWMRDMY7Lk1+JChfZduH9j9qz7CtDvR2drd6mjjfdYrGkyFy10twswxBLutNqfJAoQZ
         K/4Ynb8hr+mRAOASL/XGlIEJ50H81mBgS4dWnBEfouL9QL6wl2uUKCvjdJL45jfKlDVb
         p3pRZ5/8uYOWku6L9NARjjSaj6BOsnn1NJRTXFeh7hSkY9rvzXytwbhAvO+IPsxSwEh7
         JFaQ==
X-Received: by 10.204.4.215 with SMTP id 23mr3319801bks.110.1359393066945;
 Mon, 28 Jan 2013 09:11:06 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Mon, 28 Jan 2013 09:11:06 -0800 (PST)
In-Reply-To: <20130128081006.GA2434@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214839>

On Mon, Jan 28, 2013 at 9:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Lars Hjemli wrote:
>
>> [1] The 'git -a' rewrite patch shows how I think about this command -
>> it's just an option to the 'git' command, modifying the way any
>> subcommand is invoked (btw: I don't expect that patch to be applied
>> since 'git-all' was deemed to generic, so I'll just carry the patch in
>> my own tree).
>
> As one data point, 'git all' also seems too generic to me but 'git -a'
> doesn't.  Intuition can be weird.
>
> So if I ran the world, then having commands
>
>         git -a diff
>
> and
>
>         git for-each-repo git diff
>
> do the same thing would be fine.  Of course I don't run the world. ;-)

This would make me very happy. Junio?

--
larsh
