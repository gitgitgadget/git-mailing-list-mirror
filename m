From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Mon, 20 Oct 2014 16:17:47 -0700
Message-ID: <CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>
References: <20141020115943.GA27144@gmail.com>
	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
	<20141020222809.GB223410@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 01:18:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgMDB-0006ZI-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 01:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbaJTXRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 19:17:49 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:53005 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbaJTXRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 19:17:48 -0400
Received: by mail-yh0-f41.google.com with SMTP id i57so118076yha.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=nuEGSXt5zGylpyTJoHnBnUXuGVUd0YNu0fNQwda4C3c=;
        b=p7cpMBvm3iv7tQTvadGBE7zuMv9EdpGOVge1SMY8jjhpshi8msEpSiYOBVa40FNmUR
         gZGBlsNDGyNxWBEy7WQSOn9C1lri/4+tDKQ+PYxbKOrzGhx6ZLQE04s1JFmYQUJdY9cp
         gcXDPgWTnHZKa/q1RhFksCt+meBtSi02WxEC5Wu5vf4OOwdQ76+y4FinTBxgxn071lPW
         XhrgqPQvcuuig+xvHKl/OtSDN5jBo7A+PiVrfW7jqIru9VkmpKrzEYFohueY4Dk2louC
         QZBGanu4HamAjxKXoydBk3vKhmwFtpF5uL0UjQ2LLf0pCamd2vUOtQg4fMo1NAKWn4Wr
         L28A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=nuEGSXt5zGylpyTJoHnBnUXuGVUd0YNu0fNQwda4C3c=;
        b=LSZn03yJZVuvQaWYC7WhKcL1dAdJ0B5i4IZ5AZDl7ycIeDfY1LCq1S42ZGzOMYMRJa
         ZubnPr6hg9FWlQcVnZCPcRxf220QKbgO1LmseEXuh5AmklFP5v2SRELdFeFF7TmK0Q6X
         47EPzQ5d58VVDOvQcTiEOTx0J59WjT3qv83RU=
X-Received: by 10.52.30.17 with SMTP id o17mr21952822vdh.5.1413847068007; Mon,
 20 Oct 2014 16:17:48 -0700 (PDT)
Received: by 10.220.3.148 with HTTP; Mon, 20 Oct 2014 16:17:47 -0700 (PDT)
In-Reply-To: <20141020222809.GB223410@vauxhall.crustytoothpaste.net>
X-Google-Sender-Auth: gN3Wb94_lLk_2CC5ZqkjY-6TFXs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 20, 2014 at 3:28 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> It doesn't appear that the stability of git archive --format=tar is
> documented anywhere.  Given that, it doesn't seem reasonable to expect
> that any tar implementation produces bit-for-bit compatible output
> between versions.

The kernel has simple stability rules: if it breaks users, it gets
fixed or reverted. That is a damn good rule.

I realize that some other projects are crap, and don't care about
their users. I hope and believe that git is not in that sad group.

The whole "it's not documented" excuse is pure and utter bollocks.
Users don't care. And stability of data should be *expected*, not need
some random documentation entry to make it explicit.

                      Linus
