From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v3 12/9] t7800: add tests for difftool --dir-diff
Date: Thu, 22 Mar 2012 09:55:54 -0400
Message-ID: <CAFouetiDZYAx0MyU310Dxke4bS36D171tzazmKJ-sb4YPR12-Q@mail.gmail.com>
References: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
	<1332358560-13774-6-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7m3Ur-RNHffkW9rvbT6kpXWjKMG+Kiw5ausQw5058LHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 14:56:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAiUi-0004Hi-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 14:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951Ab2CVNzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 09:55:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49073 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964897Ab2CVNzy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 09:55:54 -0400
Received: by iagz16 with SMTP id z16so3146351iag.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wT5HE8XSVPmUkmqnZio7TsuSarok9NYsnYdKOexInfs=;
        b=hVQUqKefvLt7EdFR7lWLYj5d/wBeScaotEP+00qbWwOW+qQk0CIEukmZPQQvcbz8WC
         l02SWhUfmQhkeMJi6Tvhhm9p+NIhN/zYhcRvheDhHBJOlkHN9CbhCXj5r/uzaUvUdxQ8
         kR85HbkPEKwz9QT1eV4/Gj4wsK//nUwdNfxA25S5AoVO0zsX0rsMOnJRDCdLn0H/CK2j
         vYaygqR9ZZtzxZQIrHjv+flaQ5+l5T5IrANRQkCHTGYOZ405zhHZ6p76jVlWhewhItDa
         hHTey+Rsg9GMR3KLj4FzKaPCRI8lHIEcxie7C0f8gnj0PuYhpapEzc+sfKlQZpKncmyj
         0ybw==
Received: by 10.50.153.169 with SMTP id vh9mr1726163igb.41.1332424554191; Thu,
 22 Mar 2012 06:55:54 -0700 (PDT)
Received: by 10.42.138.5 with HTTP; Thu, 22 Mar 2012 06:55:54 -0700 (PDT)
In-Reply-To: <CAJDDKr7m3Ur-RNHffkW9rvbT6kpXWjKMG+Kiw5ausQw5058LHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193657>

On Thu, Mar 22, 2012 at 5:53 AM, David Aguilar <davvid@gmail.com> wrote=
:
> On Wed, Mar 21, 2012 at 12:36 PM, Tim Henigan <tim.henigan@gmail.com>=
 wrote:
>
> If we wrap the subdir operations in parentheses then the sub-shell
> saves us from having to do "cd ..". =C2=A0It also helps prevent leaka=
ge
> from earlier failures, which is helpful when writing new tests.

I will update the patch to include this change.  Thank you for the exam=
ple.


> It'd also be pretty neat if we could gather file content somehow.
> This would allow us to make assertions about the content of the
> left/right parameters passed to the tool. =C2=A0I don't know if that'=
s test
> overkill ;-) but it seems like it could be helpful.

This sounds like a good change for some future patch ;)
