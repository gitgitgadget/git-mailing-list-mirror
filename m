From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] Developer's Certificate of Origin: default to COPYING
Date: Thu, 12 Sep 2013 15:44:04 -0700
Message-ID: <CA+55aFyQZ8EiOg+CZy-KMaX0Hnkdmvq1+8b9p6uuMuHAUzYaAg@mail.gmail.com>
References: <1379023862-29953-1-git-send-email-rhansen@bbn.com>
	<xmqqy571n05d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 00:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKFcS-0003BP-0z
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 00:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab3ILWoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 18:44:08 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:58625 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787Ab3ILWoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 18:44:04 -0400
Received: by mail-ve0-f180.google.com with SMTP id jz11so396262veb.11
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ybgDwGlWVzXFXUWvbYM62fTlVk74JwP62+knlVRRLS4=;
        b=x028w2ylfrBAeH5Gp3ZeV7pe+s+qNzgM5zMqO/3h9gADKVlWEqLbQqwY4UHLZNEGrq
         W5cr4HWLr99m90OoxUkbwrOlpZOZF6hTPw04fiYGjkQZn/k6+2VJQ+CAFZIvMMwKtH8g
         2ywk3LvfyY33BzH1bewadfu3X+n+MWmi4MnDa+nVogIKQMKiRcTNip+kRrqz5kX8HfiK
         3irUELjIkk+ci7QVSbfVVRPvJwwQyRFdVg0JEGjxkwBby8AffV7NKKBQN6B9n/EuYh55
         LBjuRVXnwMnvCwJtvjQiRbZVw8Z1i3a6iTOLwxh+Sjd6rz1daBTstnJFoOpW2A3eLSZZ
         /s4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ybgDwGlWVzXFXUWvbYM62fTlVk74JwP62+knlVRRLS4=;
        b=b0N79Z9dFYH/jla1j1r+M61h2cPRBey8nUbj+RVENE80L282k4oMka4Pwgv7XbbuRb
         ps1bbgKHzGWnUlHoPdvtoRBQliocalg0PN3XNlwFATajgaod4yfAiaTnkfdc8f2rlhFj
         arI1eew37TLNA7JPXnobkX1TZ1sFSSYMnNgwU=
X-Received: by 10.220.199.5 with SMTP id eq5mr8746446vcb.16.1379025844262;
 Thu, 12 Sep 2013 15:44:04 -0700 (PDT)
Received: by 10.220.3.137 with HTTP; Thu, 12 Sep 2013 15:44:04 -0700 (PDT)
In-Reply-To: <xmqqy571n05d.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: zknTn8wWLHdHRwgU1kvzAxX8YRs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234709>

On Thu, Sep 12, 2013 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus, this is not limited to us, so I am bothering you; sorry about
> that.
>
> My instinct tells me that some competent lawyers at linux-foundation
> helped you with the wording of DCO, and we amateurs shouldn't be
> mucking with the text like this patch does at all, but just in case
> you might find it interesting...

There were lawyers involved, yes.

I'm not sure there is any actual confusion, because the fact is,
lawyers aren't robots or programmers, and they have the human
qualities of understanding implications. So I'm actually inclined to
not change legal text unless a lawyer actually tells me that it's
needed.

Plus even if this change was needed, why would anybody point to
"COPYING". It's much better to just say "the copyright license of the
file", knowing that different projects have different rules about this
all, and some projects mix files from different sources, where parts
of the tree may be under different licenses that may be explained
elsewhere..

            Linus
