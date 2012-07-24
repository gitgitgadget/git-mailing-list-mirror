From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v3 6/7] Remove unused and bad gettext block from git-am
Date: Tue, 24 Jul 2012 14:16:17 -0700
Message-ID: <CAOeW2eHyLHGs3-Sd6X0b2Of1mFa1U8dCBU7L85_MJc4BY=BJmA@mail.gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
	<dc805486adc18bf70cea73f9c6363bb3c4cf6c2b.1343112786.git.worldhello.net@gmail.com>
	<20120724182700.GI2939@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:16:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StmSt-0002Ab-PE
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 23:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab2GXVQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 17:16:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57583 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab2GXVQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 17:16:17 -0400
Received: by pbbrp8 with SMTP id rp8so196524pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1D7HD3biSWtgVeeVnSw5oh3wO4i1IZ2YJKWnP3yBKMI=;
        b=qvQ519N+sT1itIw+t7rk9BLWK1VAdqxgnclo4bUtpdR+KIGTsU1XenS7lkjVW5x9QE
         f4TKECm1YfGXrcfbeeuHg8UiR0YpIK69H6ozcslwociyauDFUuxM3doRPOzcTMnwdXba
         MYmUUBJW7gP+BhskX9nJ55j8lrnMXjYpRAaAKopA0HdMDpwzvmndFbxJ7VH3wqIT/aBi
         pK+B6XZcmuPQlGfLeDSjKEGNAyuR5ZjE7IX5lPUZwyEOp06JB2cwXO6nLh1dIB5ZxWC6
         GQsfeQJe+CMIgr++InEqqj1sZlh4x3XeTsrN9xXT97vDYtxMd+qkOE4VtjNTIEdIFm5L
         J0Sw==
Received: by 10.68.194.4 with SMTP id hs4mr47347948pbc.128.1343164577207; Tue,
 24 Jul 2012 14:16:17 -0700 (PDT)
Received: by 10.68.236.138 with HTTP; Tue, 24 Jul 2012 14:16:17 -0700 (PDT)
In-Reply-To: <20120724182700.GI2939@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202071>

On Tue, Jul 24, 2012 at 11:27 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Jiang Xin wrote:
>
>> Gettext message should not start with '-' nor '--'. Since the '-d' and
>> '--dotest' options do not exist in OPTIONS_SPEC variable, it's safe to
>> remove the block.
>
> The above justification is not a sufficient reason to stop giving
> helpful advice when someone uses an option that was historically
> supported:

I think Jiang is saying that "git am --dotest=..." already errors out
because "dotest" is not in the OPTIONS_SPEC. See 98ef23b (git-am:
minor cleanups, 2009-01-28). Or am I missing something?
