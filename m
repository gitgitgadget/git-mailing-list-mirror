From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: cherry-pick/revert error messages
Date: Sun, 20 Nov 2011 13:32:01 +0530
Message-ID: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 20 09:02:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RS2M8-0007qk-Qj
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 09:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab1KTICY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Nov 2011 03:02:24 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57450 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab1KTICX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2011 03:02:23 -0500
Received: by wwe3 with SMTP id 3so3637494wwe.1
        for <git@vger.kernel.org>; Sun, 20 Nov 2011 00:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vjcLJrywZ0nXoW3DWdHwPhHrgX105iQdt01xKvdykdc=;
        b=cgS9dt4q2DAanfPJYwHxVLJPSrhjnCaDlDKazdwGjt6qZfa3pc9eDckgU8zA+sj9Ki
         TSdQeDoGPBvVIJqdrqgnmjGZ1in5Z8k9RqrY+YZn9ALY686bX4RbTLkztYcjYxqUbqfP
         ULMtC8dbkieBQzN03zvzP2HkL3V3fzjIuINYE=
Received: by 10.227.207.205 with SMTP id fz13mr6051681wbb.0.1321776142197;
 Sun, 20 Nov 2011 00:02:22 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Sun, 20 Nov 2011 00:02:01 -0800 (PST)
In-Reply-To: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185717>

Hi Jonathan,

Jonathan Nieder wrote:
> Today I encountered the following error message:
> [...]

> I guess I would have expected something
> like the following instead:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git cherry-pick foo..bar
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: a cherry-pick or revert is already =
in progress
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hint: try "git cherry-pick (--continue | -=
-quit)"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$
>
> What do you think?

Looks much better!  Yes, a series pretty'fying error messages would be
really nice.  I'm busy with exams this week, and "New sequencer
workflow! v2" has been pending for some time -- would you like to
handle this bit?

Thanks.

-- Ram
