From: John Tapsell <johnflux@gmail.com>
Subject: Re: git log -p unexpected behaviour
Date: Tue, 30 Apr 2013 21:12:49 +0100
Message-ID: <CAHQ6N+pgz3yzFCumgRd3yzpxpqFbkMSzB=tHxmY5hdhzTjeXAg@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
 <20130420140051.GB29454@ruderich.org> <7vd2towdiq.fsf@alter.siamese.dyndns.org>
 <CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
 <20130421102150.GJ10429@elie.Belkin> <CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
 <20130421160939.GA29341@elie.Belkin> <7vli8bu3ne.fsf@alter.siamese.dyndns.org>
 <CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
 <7va9ogezzx.fsf@alter.siamese.dyndns.org> <vpqy5c0oson.fsf@grenoble-inp.fr>
 <CAEBDL5W-xuNhyL81TBGhriAr2jM7CC3FtLhfcbEfEAf9GjCJAQ@mail.gmail.com>
 <CAHQ6N+pDeeZBabiArTXJy9POv10xCBU+=46YdYmW0Ge1qVgUCA@mail.gmail.com> <7vd2tbdcsa.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGvO-0002Z7-C2
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933600Ab3D3UNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:13:12 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53130 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933325Ab3D3UNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:13:11 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so1160457ieb.41
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=O62inyJmAmmKN7E55VcFLXFYDG5CYOVHq8UAOnw04B8=;
        b=JvGjPM7zdajc+cQFBxaG8RwuhEUch6VGLonoNB4ADfJy3TA2C46hTQXKp9FO1fOazF
         48eEWouzrZOV2XPBlfS5cKd9wIc8gEOgrxs448sfTGQZCmuYxmzPRuzip2/ZEhC6DGxi
         NPRiTDYYtJQz9T34tScxzyOoCy5ToPly1vWc18k+IewEbRbcd+wM2hogwZZo2qNraZf1
         l+ur89S2yEyQm3nCxQ64fA/+tO6oX2pa7OfH6YzTJlxRrZuNVxEn/x9jhQ3Cd1FA/N1I
         nazaqoCFZuttOhZ16ijiXhnij8ABFwi5LdC9MpTAnE198MFzbT4U42Oxw4iAYLOJ3mbF
         cjOw==
X-Received: by 10.50.147.100 with SMTP id tj4mr3034762igb.19.1367352790685;
 Tue, 30 Apr 2013 13:13:10 -0700 (PDT)
Received: by 10.64.8.235 with HTTP; Tue, 30 Apr 2013 13:12:49 -0700 (PDT)
In-Reply-To: <7vd2tbdcsa.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223003>

On 30 April 2013 20:44, Junio C Hamano <gitster@pobox.com> wrote:
> John Tapsell <johnflux@gmail.com> writes:
>
>> Is there no way to fix --cc to work even in the edge cases?
>
> Can you clarify what you mean by "fix" and "edge cases"?

My understanding is that even with -cc there will be changes that
won't be seen - and hence why --cc could be even more of a "security
risk", no?

John
