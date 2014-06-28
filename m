From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Experimental TDB support for GIT REFS
Date: Fri, 27 Jun 2014 17:37:52 -0700
Message-ID: <CAJo=hJu3QD09JccSvUrpnNSpFE5ppDHEzozkKyZZAyutvCQTGg@mail.gmail.com>
References: <CAL=YDWn-CGZGr5bXNTiZmzr4-w_8CERx3r2bmLWbczqJ0Sn7dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:38:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0geo-0003jQ-FT
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 02:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbaF1AiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 20:38:14 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:48231 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaF1AiN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 20:38:13 -0400
Received: by mail-ig0-f171.google.com with SMTP id h18so2574583igc.4
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 17:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CTKC6fwrLt+BQHACD0jClcoS4aoPqAnbGVtFs0JjgjY=;
        b=V506ToJN0rr/Us+DdyCkkqYX03NRFA3CAvb8j+yCnAjvbMvcb67fYU23tVdbjB1VFe
         IIwlej6J7/DuKPnCaoRGSpAlGhmJq+9RtWtjkI+avgDYNX5qdIiq3p39WejX9PSfp3GV
         ZGj1ietL1v4QDM9XVG06IREKJOT8mabLD2J+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=CTKC6fwrLt+BQHACD0jClcoS4aoPqAnbGVtFs0JjgjY=;
        b=FOTH6VPE1Iz/Gl6iQuDC/EK2exbhvL2QbqK1W/5pCkwvi5TANXhRNSM3FEV8NRll5H
         gh0pMA7nyQSiw1yEdKOT4xYj7wW2usvAx2U5Z6YZLWf6xuwOd3dviCYmtDO0A9J8VEHX
         9gE60Ccl+DwQgAHfEzbrCzORECO4vn2qAWd4eOkovlGtzbNnFUBGupmTfXplulXm8USb
         W492ZvRy+2jTjJq4II/Ps5Wl2yMaASqx0tPoBv2XZbNogXYWV2OP3lKLfSETfxhde2Kc
         uMCigiU5PknUZgleNVCp5eF5jlkx/eme5zNhO2sW73Z9F6IqEiF9RCAhojOe1HoGQeYq
         DmRw==
X-Gm-Message-State: ALoCoQk5NOJx+pEp8DQ1zUN5M1Vex9aNygQYSJsV2h+ShW86RxSJFL8cf0VdI+307/5ybfHHUSRx
X-Received: by 10.50.13.102 with SMTP id g6mr11779987igc.20.1403915892913;
 Fri, 27 Jun 2014 17:38:12 -0700 (PDT)
Received: by 10.64.208.12 with HTTP; Fri, 27 Jun 2014 17:37:52 -0700 (PDT)
In-Reply-To: <CAL=YDWn-CGZGr5bXNTiZmzr4-w_8CERx3r2bmLWbczqJ0Sn7dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252590>

On Fri, Jun 27, 2014 at 2:30 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> List,
>
> One of my ref transaction aims is to make define a stable public API
> for accessing refs.
> Once this is done I want to make it possible to replace the current
> .git/refs/* model with a
> different type of backend.
> In my case I want to add support to store all refs and reflogs in a TDB database
> but once we have a pluggable backend framework for refs, if someone
> wants to store the refs
> in a SQL database, that should be fairly trivial too.
>
> There are a few series queued before this becomes possible, but is
> anyone wants to test or play with my "git can use TDB database" you
> can find an implementation of this at
>
> https://github.com/rsahlberg/git/tree/backend-struct-tdb

Interesting! But the link 404s :(
