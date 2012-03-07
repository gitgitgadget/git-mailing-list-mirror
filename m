From: Nate Parsons <parsons.nate@gmail.com>
Subject: Re: Unable to make git with https support
Date: Wed, 7 Mar 2012 17:30:24 -0500
Message-ID: <CADjGbJpL69BTpOHyToqYmSWSBYA--6fSGB4CZyBXvdA9Zy4NvQ@mail.gmail.com>
References: <CADjGbJq_HL--_CAuE_Yj3B0srx=WDficot8bgadvW92zz9PJdg@mail.gmail.com>
 <87pqcotc9w.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 07 23:30:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5PNk-0006oI-CF
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592Ab2CGWar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 17:30:47 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40923 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab2CGWaq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 17:30:46 -0500
Received: by bkcik5 with SMTP id ik5so5699191bkc.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 14:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qeUlZG4JHtDC3o7N/A6rDXnUmr0l1dUFFvopiIM9X2I=;
        b=09tSMv7dELs3hGbmhSFipH8sTyTUYbBg6F3sJZmBLFNtj0NNlQhtBAgDqoDCgrcick
         UwuxA+BtGLo4IoEmVrO9fkglUMQ0LnHkK25sYBywap+fY+S6P/h/BDoQxvIgDd+X/qCx
         UIaYcNdp4cq+jw4God2Bpev7hT0pdhe5//9jEunIHuTwY7OQYy47+RjH8gR6KQHlh+wA
         qS5goltm+iOh6Jsvy/C3WwUgeSnZpFkVH8YL2Nww5vJpEmDvlDBuiONH03AkIedliP20
         59rtu1YU5dtoseYaElGfXGpRIs0HyTXGg5z4GaK7Pl5WpKyvlUSq3P8NFQ+XQday3QfD
         Bfow==
Received: by 10.204.9.195 with SMTP id m3mr1817323bkm.78.1331159444395; Wed,
 07 Mar 2012 14:30:44 -0800 (PST)
Received: by 10.204.168.81 with HTTP; Wed, 7 Mar 2012 14:30:24 -0800 (PST)
In-Reply-To: <87pqcotc9w.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192497>

On Wed, Mar 7, 2012 at 2:57 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Have you also installed libcurl-devel (or whatever the package might be
> called, but it seems you are also using opensuse)?

This is the problem, thanks. I only have curl and libcurl4 installed,
and I was hoping to not install any new packages. So I downloaded curl
and openssl and tried to make those. I was able to build openssl, but
I was not able to build curl off of that (skipping curl's ./configure
step doesn't seem like an option).

This isn't curl's mailing list, so if you don't want to help me make
curl, I understand (and have a workaround that might end up being a
better solution for what I'm trying to do anyways)
