From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: html page display via cgit
Date: Wed, 1 Sep 2010 09:46:31 +0000
Message-ID: <AANLkTik-02dJZF_0m=xccg4N5Mdaj=b2JzZaMKp=vuww@mail.gmail.com>
References: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Shivdas Gujare <shivdas.tech@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 11:46:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqjtt-0002Sk-FD
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 11:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab0IAJqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 05:46:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54664 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab0IAJqc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 05:46:32 -0400
Received: by iwn5 with SMTP id 5so6667832iwn.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yiH4MJNFiWBlRScxz0bDopyy/GPu9bqBwHZIDseJuE0=;
        b=pSrb9FR2BHvHfE0jF18LV+0D6gn4x7QvP88R2bsSoaOm6hO1K/Z/hGKccHfzWnVewV
         GePl4pNaAXEGBG5dCdNquTBzFDsSAyQsgAmC/lMgMjYJtb3eI5GKBhN48bYTC9cE8Lfn
         dhG2GJWbEc/dyL5qZZejTWUc58UTZ2pCM/vZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=m8dmCn6hstiz0S54vAIjr1ySlbs1DzxGfYhFZF16RhYa0YP1+kFVWU2e0V2eyvQ+cD
         3K8/z6D5zGmoiWwB0ts21Hx0ScJWPvjaGPGTUzvJbDyjaK02xPh01n+GGXQDM3mVKxm0
         oPOzeY7VtskMiy8a/zA3Iy7yB75FIspikTDzg=
Received: by 10.231.190.75 with SMTP id dh11mr8317885ibb.189.1283334391736;
 Wed, 01 Sep 2010 02:46:31 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 1 Sep 2010 02:46:31 -0700 (PDT)
In-Reply-To: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155029>

On Wed, Sep 1, 2010 at 09:32, Shivdas Gujare <shivdas.tech@gmail.com> wrote:

> I hope, this is the right mailing list for cgit as well.
> I am trying to add some "html logs" inside cgit, but I can't open
> these logs via cgit inside firefox, i.e. cgit open every files in
> "plain" format,
> would like to know if it is possible to open "html" pages inside cgit
> so that if I click on html page added into git, it opens in html and
> not in plain format.
>
> for example:
> if I click on "download.html" from
> "http://cgit.freedesktop.org/~lb/mesa/tree/docs" it shows a raw file
> as "http://cgit.freedesktop.org/~lb/mesa/tree/docs/download.html"
> and if I click on "plain" it opens in firefox like
> "http://cgit.freedesktop.org/~lb/mesa/plain/docs/download.html"
> but here I am trying to open this "download.html" inside cgit so that
> I can view it like html web page and not as "plain" text file.
>
> Thanks for any help or pointers.

I don't know, but that's probably deliberate. You're viewing a /plain/
link, which should be the equivalent of "git show".

There's also XSS security implications to serving things as text/html
on a shared hosting site if the main site serves cookies or otherwise
has user logins.
