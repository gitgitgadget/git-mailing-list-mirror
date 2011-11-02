From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: git-p4: problem with commit 97a21ca50ef8
Date: Thu, 3 Nov 2011 09:42:31 +1100
Message-ID: <CAOk9v+_xaS_Y1m17TROOSjgiscT+QEJWbpZbAZFmh8_tAviF6Q@mail.gmail.com>
References: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
 <20111101020841.GA8116@arf.padd.com> <CAOk9v+_xXRGAGWg2L5u=r9qBS=H+ZmdF=TwumSyq7WKf-15okw@mail.gmail.com>
 <loom.20111102T153631-769@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 23:43:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLjWi-0003sQ-Fu
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 23:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab1KBWnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 18:43:15 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43230 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab1KBWnM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 18:43:12 -0400
Received: by eye27 with SMTP id 27so592492eye.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 15:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=x34F4YFAucxD0NEu5kzRb/lu0HTG/pT4D4UWp9uHVdg=;
        b=agdVKGQOhSz3FlDy45eGRIzfjx0c/vGYiehv8d8W8xNKcl9sW2xeY56GzvvDAIZlBr
         xF35nX/Azi9Fu3F+kfUwuxRZi+Lloz518PP1aSAKnapBxOF44qZevpJHk/y186fvu39U
         gt3pd8/dYsfEFXxx4BfIVOjeiE7G9qHeMlb9Q=
Received: by 10.213.33.210 with SMTP id i18mr820753ebd.25.1320273791419; Wed,
 02 Nov 2011 15:43:11 -0700 (PDT)
Received: by 10.213.17.209 with HTTP; Wed, 2 Nov 2011 15:42:31 -0700 (PDT)
In-Reply-To: <loom.20111102T153631-769@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184680>

On 3 November 2011 01:43, Vitor Antunes <vitor.hda@gmail.com> wrote:
> Michael Wookey <michaelwookey <at> gmail.com> writes:
>> Of course, I'd love to have git-p4 work seamlessly for this scenario=
=2E
>> Even Perforce have a KB article on the limitation of the "apple"
>> filetype with git-p4:
>>
>> =C2=A0 http://kb.perforce.com/article/1417/git-p4
>>
> """
> Step 2: Download Git-p4
>
> Recommended version is ermshiperete=E2=80=99s branch, which is availa=
ble from:
>
> https://github.com/ermshiperete/git-p4
>
> Note: Omit the =E2=80=9Cgit-p4.py25=E2=80=9D file, which is an older =
version that is no longer
> needed.
> Avoid Kernel.org=E2=80=99s Version of Git-p4
>
> Git=E2=80=99s main source at http://git-scm.com/download and
> http://www.kernel.org/pub/software/scm/git/ contains an older version=
 of Git-p4
> with limitations that ermshiperete=E2=80=99s branch avoids.
> """
>
> I can almost guess _who_ wrote this KB ;)
>
> But this is really frustrating. Why can't people just cooperate to ma=
ke sure the
> version in the main branch is the latest?

I tried your suggested version of git-p4 (at rev 630fb678c46c) and
unfortunately, the perforce repository fails to import. Firstly, there
was a problem with importing UTF-16 encoded files, secondly the
"apple" filetype files are still skipped.
