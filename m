From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH v2 0/5] contrib/subtree/Makefile: Standardisation pass
Date: Tue, 6 May 2014 22:41:32 +1000
Message-ID: <CAHYYfeGmQX3tBYA=1r9YCe0sTzHZaEWtBRcLXsrLsMv9AXTMEA@mail.gmail.com>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
	<20140505050803.GA6569@sigill.intra.peff.net>
	<69f827ea-0ba2-4ca0-b711-002e1a0010b7@email.android.com>
	<20140505220112.GA17610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Greene <greened@obbligato.org>,
	Avery Pennarun <apenwarr@gmail.com>, gpmcgee@gmail.com,
	Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 06 20:09:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiQh-0008Bg-RD
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbaEFMlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 08:41:35 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:47625 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059AbaEFMld (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 08:41:33 -0400
Received: by mail-vc0-f169.google.com with SMTP id ij19so866081vcb.0
        for <git@vger.kernel.org>; Tue, 06 May 2014 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KM3NGyjH6diIYgtBsV2jm+XQxUwWvO65eDDqu+4QJ4o=;
        b=F8ss1xVyXjaBoBmfaErpYdCPQywmk86J6Sjb8REtGXYD3QQtIj1ItATZ7Re1xO45wc
         osRZ5qX9Lp8FUAN1FuzZ3hN6iWm0DE4bZNGoS9maglJUncDtBp85NWq2TFMRGgvp2fMV
         WxbEUdahYzL167VKzbmWYGXdhpvmtlvnycxRbtx4SX7BMiBCIx327taBs6K5oFbEzOhq
         X2zx64Tuq+rq2uvevlOyltawzwqT7MypzM+3gNsN1fEc54NKYZMa72pDoUwm/Kv6R0qL
         CkfMKbbaM1VLaDHU5/P6ra8fMbL/mzCzdOqZnWagz6jJ+CC0KvPxZU+qgKjZ8NSxtse+
         1ttw==
X-Received: by 10.220.69.4 with SMTP id x4mr268404vci.74.1399380092132; Tue,
 06 May 2014 05:41:32 -0700 (PDT)
Received: by 10.58.12.2 with HTTP; Tue, 6 May 2014 05:41:32 -0700 (PDT)
In-Reply-To: <20140505220112.GA17610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248201>

On 6 May 2014 08:01, Jeff King <peff@peff.net> wrote:
> [fixed David's address in cc list]

Ah, right. Wasn't sure what was going on there.

> On Tue, May 06, 2014 at 07:54:30AM +1000, James Denholm wrote:
>
>> Given that subtree subtree doesn't really generate a lot of discussion,
>> would it be advisable to wrap this up (barring further discussion) and send
>> it off to Junio rather than waiting for further community consensus?
>
> I do not know if "lack of discussion" is a good reason to consider
> something in good shape; oftentimes it is a sign that nobody is
> interested in the area. We usually rely on "area maintainers" to give an
> OK to the patches if they are not something that the maintainer himself
> has an interest in.

Yeah, I certainly only meant that in the context of this particular
patch, post-review.

> However, in this case, you did get review, and I think it is pretty easy
> to see the patches are good even if one does not care about the
> particular area. So I think they are fine to pass on and apply.

Sounds good, I'll send it on up now. Thanks again for the help.

> Note also that patches like this are a great place to get started, as
> they help build trust in a contributor, who can later help out with
> area maintenance.

Yeah, to be honest, beyond the immediate goal of getting subtree in more
distros, that is kinda the plan. A bit of a practical experience in
contributing to the project, learning the specific ropes and such
before proposing more substantial discussion and fixes/changes.

---
Regards,
James Denholm.
