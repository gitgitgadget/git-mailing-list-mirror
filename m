From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.3.0
Date: Fri, 6 Feb 2015 13:56:19 +0100
Message-ID: <CACBZZX7a-NndphJMOcdh-v91_yOnicLzhSoO17jtcOKJn23gXA@mail.gmail.com>
References: <xmqqvbjghsw0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Feb 06 13:56:46 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YJiSj-0000dC-FD
	for glk-linux-kernel-3@plane.gmane.org; Fri, 06 Feb 2015 13:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506AbbBFM4l (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 6 Feb 2015 07:56:41 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:46659 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbbBFM4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2015 07:56:40 -0500
Received: by mail-ob0-f171.google.com with SMTP id gq1so12966158obb.2;
        Fri, 06 Feb 2015 04:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wJygbTSQi+/UEwxz82ILd4Uz1iXXrzLL7WB+N4TrpOQ=;
        b=OQ/LfcFkqv+xWLQmfcuDHfuBdcGOy/sulz9TPNx/YaA7mEOgpzeptg6Odwg+Ki8yuL
         Ll7GZEmDFP19VG55s4jyc+QgXGYJZ6LITBWGJxkbSGpoMLN8roRWuBtlagcc1TPjRg/U
         I5e4/jY8EJKrHJi3Je1mHSCZjbhghwewkxfzezfJXdj9f4zaMLK0CtckJIeZ+fSDgjhC
         jgjo+DE5O0Kh9zMjKC3EivLrHDbyBXUimfHR828FBiWSmIKRQHPpAeAXbE7qF0+MuTUe
         tgly0ddGCvxVgl+VRGryUWspSUhmcMzt0UL9b7A0XYnYye5/o3vD1lBEN26mrShGAWZ/
         gEMQ==
X-Received: by 10.202.104.68 with SMTP id d65mr2219671oic.129.1423227399475;
 Fri, 06 Feb 2015 04:56:39 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Fri, 6 Feb 2015 04:56:19 -0800 (PST)
In-Reply-To: <xmqqvbjghsw0.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263417>

On Thu, Feb 5, 2015 at 11:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The latest feature release Git v2.3.0 is now available at the
> usual places.
>
> [...]
>  * Git 2.0 was supposed to make the "simple" mode for the default of
>    "git push", but it didn't.
>    (merge 00a6fa0 jk/push-simple later to maint).

Maybe I'm misunderstanding what this does, but changing the push
default was *the* backwards compatibility breakage we advertised for
v2.0.0[1].

A lot of users (including myself) upgraded to v2.0.0 very carefully
making sure that the common pattern of "git push" our users were using
wasn't broken.

But apparently that change isn't taking effect until now. If so I
think this needs to be advertised a lot more prominently than buried
down along with other miscellaneous fixes in the changelog.

1. https://git.kernel.org/cgit/git/git.git/tree/Documentation/RelNotes/2.0.0.txt
