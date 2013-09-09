From: Niels Basjes <Niels@basjes.nl>
Subject: Re: [Proposal] Clonable scripts
Date: Mon, 9 Sep 2013 23:23:19 +0200
Message-ID: <CADoiZqqKSX+=yHjU=tTz=0iP_JKzkQvsDancdVXQ3rjkbch9eg@mail.gmail.com>
References: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
	<CAE1pOi0TioYa2pWCe=8kFbrSNp847rHDUbxXdxBAe=jN3BkWxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 09 23:23:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ8vd-0002Ck-Sd
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 23:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586Ab3IIVXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 17:23:21 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:38915 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab3IIVXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 17:23:20 -0400
Received: by mail-wg0-f54.google.com with SMTP id e11so4629431wgh.21
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 14:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=VljJ97kY/BmsprnnB9SaSQDei7XxBp1hgu3d4S8xvEQ=;
        b=OVfjSYJoMf2P4UlDIhHdb4gQoWt/gOiGYAly9PxAmX6gPDoXF5tNUc5JMLJtAQlHZv
         Fa1nGpD5slKFTPJx907cZYCGhAF39TnIL39u5XCtEUsYlMhetPt6E2u6WXXy42ps2lB1
         QItveUmH1PamnpM/ekSTcFRvyCQ1IZbXJdcvyLKUCZcEp+ivHYZ+guNZVTtR8yevTJ7J
         Q5JK7oCjEGam+mmL3zT5gIpudxeV9OyqdjS1LkQIbxujzQBrnacTxvNt1YGzRh4Tlbtr
         Xve2BJmtAyTHRtFb8YG2pbjlTd+QcwnJj45oq2TyTd2i5WgknEhxnCuZBqE04mO3IRFP
         WM5w==
X-Gm-Message-State: ALoCoQmED1z92OdhMFVRMKdFVX/upEoWbnw6Uk8GboJ17aopokISecoV/5hyOj9dxK27Vwetdr1A
X-Received: by 10.180.12.45 with SMTP id v13mr9924298wib.57.1378761799684;
 Mon, 09 Sep 2013 14:23:19 -0700 (PDT)
Received: by 10.194.40.71 with HTTP; Mon, 9 Sep 2013 14:23:19 -0700 (PDT)
X-Originating-IP: [2001:980:91c0:1:45cb:c539:d56c:ff5b]
In-Reply-To: <CAE1pOi0TioYa2pWCe=8kFbrSNp847rHDUbxXdxBAe=jN3BkWxg@mail.gmail.com>
X-Google-Sender-Auth: 6Zb97qXwao-EVHV1jfLwEnJ17y4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234378>

On Mon, Sep 9, 2013 at 11:13 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> On 9 September 2013 13:48, Niels Basjes <Niels@basjes.nl> wrote:
>> So I propose the following new feature:
>>
>> 1) A scripting language is put inside git. Perhaps a version of python
>> or ruby or go or ... (no need for a 'new' language)
>
> That sounds nice but ...

>> 2) If a project contains a folder called .githooks in the root of the
>> code base then the rules/scripts that are present there are executed
>> ONLY on the system doing the actual commit. These scripts are run in
>> such a limited way that they can only read the files in the
>> repository, they cannot do any networking/write to disk/etc and they
>> can only do a limited set op actions against the current operation at
>> hand (i.e. do checks, parse messages, etc).

> ... how would you prevent Ruby/Python/Go/$GeneralProgLang from
> executing arbitrary code?

Some kind of sandbox?

>> Like I said, this is just a proposal and I would like to know what you
>> guys think.
>
> I love the idea but I'm not sure how feasible it is. I think you would
> be forced to copy an existing language and somehow "make it secure"
> (seems like a maintenance nightmare) or to create your own language
> (potentially a lot of work). But perhaps something more declarative
> might be usable?

As far as I'm concerned it should be the 'best suitable' language for
the task at hand.

-- 
Best regards / Met vriendelijke groeten,

Niels Basjes
