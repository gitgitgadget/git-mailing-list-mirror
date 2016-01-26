From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 19/19] mingw: do not bother to test funny file names
Date: Tue, 26 Jan 2016 15:03:55 -0500
Message-ID: <CAPig+cQXVwfyaEzf9fR2tFNon-Jq93iPCMwW9gsB8BnUVv5p3A@mail.gmail.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<cover.1453818789.git.johannes.schindelin@gmx.de>
	<47914e4ceb3ea51636dd5ae308679c9c92fcbef0.1453818790.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:04:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO9qL-0007i1-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 21:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbcAZUD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 15:03:58 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35013 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbcAZUD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 15:03:56 -0500
Received: by mail-vk0-f68.google.com with SMTP id e185so7343449vkb.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 12:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8DPGZ2BPwYfdNf9qOOGlIyfbrX2rv0ZAypGXUyLfopE=;
        b=Q4Prt7BMdpdrakAi/lFVfaj9gXxabj9NiOjJW2bxJlneJgX0mKjL/aofo9wic7Xy/J
         rx9m2grBd7llF2YGu7D2WhuIwCbnEXS+0jIecaVQgvhDG+1n6bN3yRBlV08vecjfOy/q
         rLZ0C/1jzomIeGIMdpktB/VA+IpQ4QIDF9XHOy8RimjknVx7Q9HFuJJrGFXABSy1+aJM
         qRE1B47CLOe4t+DXVy+Gx2NnkbWexMw3RhUzXKRnoLlqOSnLjV1pFCslndm6zQ0uWi/X
         m78jW5CGHedK/w3vW7Rj0OgHsnFOkKHRE9wTWbWT8rQbyAHU/QXrfUjfQwfIDJTUr06w
         aDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8DPGZ2BPwYfdNf9qOOGlIyfbrX2rv0ZAypGXUyLfopE=;
        b=ZY0U9K3ugzZcKg+ieCqyjA2V0EbpDkXJ5w84gjdhq2XZU7dn8CJpsy7VGwnbRhYEF9
         SxQR/BMo06FkDlr+zM4x2SQkJA1UR6KPdixWWCms7/1lVI4JoSGFhQuya/HAkH69vVN4
         925QPD46+WDG1GXCNXq0v+6QeLBd4yiIYndIsmzcNSjeqK4t3QndDgHJS37v5E1GiUoc
         k+wZv15nLcTdquO0HLYqSNlBOj0IbVeSFKTTECMw73LEDacBRDTnfe9OMl+Hi+Bc2Dgl
         Mcl0ew8OSf2VTOb58we8LkSiQav3NY0TO615+3Ae1ndUUrcT4USaN15w1KFkuOv81D2V
         dZNA==
X-Gm-Message-State: AG10YOQr8CMgTxJb2emKUoNHYte7SeO2yV0glMRXsgwRZId2FmnSGo7ArF+syX8O0FWVfEAS2R8hbrPVgloDvw==
X-Received: by 10.31.164.78 with SMTP id n75mr16411222vke.14.1453838635530;
 Tue, 26 Jan 2016 12:03:55 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 26 Jan 2016 12:03:55 -0800 (PST)
In-Reply-To: <47914e4ceb3ea51636dd5ae308679c9c92fcbef0.1453818790.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: IjUGNQOCyhgqQAL5noRR0qluixg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284850>

On Tue, Jan 26, 2016 at 9:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> MSYS2 actually allows to create files or directories whose names contain
> tabs, newlines or colors, even if plain Win32 API cannot access them.
> As we are using an MSYS2 bash to run the tests, such files or
> directories are created successfully, but Git itself has no chance to
> work with them because it is a regular Windows program, hence limited by
> the Win32 API.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> @@ -14,7 +14,8 @@ test_expect_success \
> -if touch -- 'tab       embedded' 'newline
> +

Is this new blank line intentional?

> +if ! test_have_prereq MINGW && touch -- 'tab   embedded' 'newline
> [...]
> +test_have_prereq !MINGW &&

Where negation is concerned, is there a non-obvious reason that this
patch sometimes says:

    ! test_have_prereq MINGW

and sometimes:

    test_have_prereq !MINGW

? Is one form preferred over the other?
