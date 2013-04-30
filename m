From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 16:40:02 +0530
Message-ID: <CALkWK0mftWaC0Mi6QYm+iPk8bMgmS05--nevVKdOeOM9sPyg5w@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
 <517F6E40.1040606@alum.mit.edu> <CALkWK0naGx6Vrb3_iZbXefQqmwOhaTSRXxBT6K-cheiUwr3Ptw@mail.gmail.com>
 <CACsJy8C34vN7SB62-+Z3BNZeroTB_vm-n-NMhFRbAuBPQZFKcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 13:11:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX8SS-0001Jl-DY
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 13:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760236Ab3D3LKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 07:10:46 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:55953 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760149Ab3D3LKn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 07:10:43 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so335108iag.28
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 04:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GisBsXzwIHf0AsDMEZWpO0rdE4VzuIA5SkqKgR5FsmA=;
        b=EXogIqgs5Y1j88UXKwgnTYL6xJAEsVwAoyjxNVB6RnDwsp5Zo9FPQQyuiAOQ+LJRRI
         nKSjIkswhBCGu6eZjpPA0rAwG1hES5V19VRHb5dkoD1P+l7hdgH3IQ9CDNZIgVB9sb9E
         YgxgayN1W/fv+i/dMzcRYdvQdW8qRlF/8DTpomcuIRe93Eruoc7kJWhK77aJm+MZ2SQT
         9UYufL8KzWnOlZeZAYmZStRnEotYMOsSsQ24pggkUeu6KDiFPsRmA1zofi8P8jSLadZc
         ERZEUNfFc4uNDM6au3EFF+KQKC8ZuXCzhTJ85tDwpvRRdf/oQMxlrZ3xkbbk0P09+H/R
         pk7w==
X-Received: by 10.50.72.65 with SMTP id b1mr10095316igv.63.1367320243084; Tue,
 30 Apr 2013 04:10:43 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 04:10:02 -0700 (PDT)
In-Reply-To: <CACsJy8C34vN7SB62-+Z3BNZeroTB_vm-n-NMhFRbAuBPQZFKcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222927>

Duy Nguyen wrote:
> Habits aside, why do you do H@{u} when @{u} is enough (and shorter)?

I don't.  In the @{} spec, HEAD is implicit.  My initial itch was that
HEAD is not implicit in the ~<n> spec, and started off by thinking how
we could make HEAD implicit specifically for that case [1].  Since
then, we've realized that it's probably easier (and more useful) to
have a synonym for HEAD that works in all specs.  As a side effect,
master..@ will work too.  I was looking into the repercussions of
this, and noticed that Michael's @ symref is not equivalent to my H
symref.  I previously thought that all symrefs would behave in exactly
the same manner, but @ clearly seems to be a special case: I was
merely pointing this out with an example.

[1]: http://article.gmane.org/gmane.comp.version-control.git/222343
