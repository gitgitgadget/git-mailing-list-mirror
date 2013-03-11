From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 17:34:01 -0400
Message-ID: <CADgNjanBm5bj7_jY5WrUXUENr7r6zMxve822OYKcyBpWGZv-SA@mail.gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de>
	<494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de>
	<CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
	<205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de>
	<CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com>
	<B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de>
	<CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com>
	<3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de>
	<513B8037.7060107@gmail.com>
	<C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
	<CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
	<E042F4D9-79DF-4AEF-8EDE-41BA9E5FB9EC@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Mar 11 22:34:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFAMa-0000aJ-Rp
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 22:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab3CKVeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 17:34:04 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:49725 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab3CKVeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 17:34:03 -0400
Received: by mail-wi0-f179.google.com with SMTP id ez12so1345677wid.6
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=yKE4PuzKDn6vihe1Cr1NlBYN014+EUMbvWmN00w1s0c=;
        b=xNxxRSre1iiMyrV2V4E6/BHa9sP3jEn1PVgWGVyFJJXSdeHDtPULyA9q+YnoyFiDqZ
         x6GADZO4RqVYgA+91pZt7r6X+h1arEKFoccye3yS52pmbN9COgSkcFEE+6uSdQ4+/lQp
         25wI+pKGkzIEvo/GvbYyMCzkCaTqTHt57xo0hRdLpVhlGaFcq+jAh7yQBZ9cp/ZlI8RB
         PzeVvS7J+/3esmfCAgmoVii4ZK1RT5TiWZh/5tX4XRk4xx5q7atQfGwtAcbpL2eSpYTN
         ZC1Ai/cEc+Df+pF7449+N7RWJSMbZ1s59PzzfJ5OiWsrxSa9VLChYhGqFkurCK+6w+VC
         OxlQ==
X-Received: by 10.181.12.5 with SMTP id em5mr15462346wid.24.1363037641965;
 Mon, 11 Mar 2013 14:34:01 -0700 (PDT)
Received: by 10.194.138.107 with HTTP; Mon, 11 Mar 2013 14:34:01 -0700 (PDT)
In-Reply-To: <E042F4D9-79DF-4AEF-8EDE-41BA9E5FB9EC@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217912>

On 3/11/13, Max Horn <max@quendi.de> wrote:
> So I tried this:
>
>   git rebase branches/stable-4.6  # ... which leads to the error
>   git ls-files -m
>
> but got nothing. Perhaps you had something else in mind, though, but I am
> not quite sure what... sorry for being dense, but if you let me know what
> exactly you meant, I'll be happy to try that. As for the stat command:

I'm still digesting the information form the email. Just want to
quickly mention that the "ls-files" command should be:
    $ git ls-files --debug file1 file2

You should always get output. It prints out stat-like information for
files in the index.
