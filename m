From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Sat, 1 Oct 2011 14:11:39 +0000
Message-ID: <CAMOZ1Bvn64q5sVfo2-ZhTSpBttpjG1pHELJMM9sEmWsrqANCkw@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <119711285.RuumktFLOq@hyperion> <loom.20110930T041939-332@post.gmane.org>
 <CAMOZ1BsTKBPArRF-LxoNOJcQarMWx-2a2UBoVjWN-96xJ3Ad8A@mail.gmail.com> <loom.20111001T073652-884@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Shenkin <shenkin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 16:12:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA0Ia-00078X-1b
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 16:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519Ab1JAOMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 10:12:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33101 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480Ab1JAOMJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 10:12:09 -0400
Received: by iaqq3 with SMTP id q3so2930035iaq.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Nq///bQLm777+8vvByEGTYfMRjb7lO7MnAz45/uJ45g=;
        b=pvcEmEO8mLMgZiIQcPzOaNN1zV92eGYmnbdSsfQMgCGMrpsBUzc1bIFXTOoICZF4/h
         ZHko9SaWmYjT9RDE6u9OjZEyoOhGjIplv7PPHaX8Z3P6LouX3hVdh5I0hQtQ+rPaJdga
         oSa7FNpiCvcOJD0gZ5IeJYBu6jmEzOWROzFxQ=
Received: by 10.42.18.74 with SMTP id w10mr4431411ica.164.1317478329100; Sat,
 01 Oct 2011 07:12:09 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Sat, 1 Oct 2011 07:11:39 -0700 (PDT)
In-Reply-To: <loom.20111001T073652-884@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182551>

On Sat, Oct 1, 2011 at 05:40, Peter Shenkin <shenkin@gmail.com> wrote:
> Michael Witten <mfwitten <at> gmail.com> writes:
>> Well, you're missing the fact that it not only causes those to
>> be downloaded, but it also causes the defaults to be ignored,
>> which is why you don't get the other stuff. You can still tell
>> git to fetch anything else you want in addition.
>
> I was no longer missing it at the time I posted.
>
> But that is indeed what I was missing when I first encountered
> the behavior. The purpose of posting was to point out that
> with =C2=A0a very small change in the documentation, =C2=A0I would no=
t
> have missed it.

However, my point was this:

  You can still tell git to fetch anything else you want in addition.

That point doesn't seem clear with your proposed alteration.
