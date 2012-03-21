From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Wed, 21 Mar 2012 08:29:50 +0700
Message-ID: <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 02:30:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAANg-0003q4-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 02:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772Ab2CUBaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 21:30:23 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34748 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758133Ab2CUBaW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 21:30:22 -0400
Received: by wejx9 with SMTP id x9so545346wej.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 18:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+2hQFdZaRgSkZBDyy7jnnAIAl4ep8vqFJGYkN/8Rdzw=;
        b=f9UgqDOxTi9Fx2fPbZ+1c/bPXqR1fmeS2cIS3RaeDtbkJrmch3ZUYxfzQCKdVDNcUz
         UBYyOlCRzeN/rBesVa0SBpA5sfta8pY5ZaIsjc6Tavdrq3ly11a9pV/RbzFqx28haRjN
         jgc6yfcS0iI1cc5Ots3yID5QntbDurOdsaEXqwZU4d6JAD1XYM0i1V1imM20Mr7oiNg3
         /plViFzkHOTBJAlSzogRFTVElLVfnIPZKdM5y/0c6QbyElgbA5nDvR6SLPMbGtLwpgjA
         UXG8YHb6km3oKEyIBgyaJ5C4ISEwIAZ1E+j+OZNrSrP1WtDM6BK28n5u0tXdvpcC+3sq
         r1Kg==
Received: by 10.216.135.225 with SMTP id u75mr1012135wei.97.1332293421406;
 Tue, 20 Mar 2012 18:30:21 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Tue, 20 Mar 2012 18:29:50 -0700 (PDT)
In-Reply-To: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193557>

On Wed, Mar 21, 2012 at 4:17 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> There are some questions I would have about the project.
> Has there already been any development or thoughts in that direction?

Tree-based format seems to be favored by core developers, for example
in the footnote in [1]. But there have been no attempts to realize it.
You may want to search mail archive for more.

[1] http://thread.gmane.org/gmane.comp.version-control.git/190016
-- 
Duy
