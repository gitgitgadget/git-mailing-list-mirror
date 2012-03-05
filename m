From: Scott Chacon <schacon@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2012, #02; Sun, 4)
Date: Mon, 5 Mar 2012 15:30:50 -0800
Message-ID: <CAP2yMa+GgRV3W7FcRhVrpRTRfWrDxKhWgbkWVdzCyyN-zgcifA@mail.gmail.com>
References: <7vk42z32jo.fsf@alter.siamese.dyndns.org> <CAFfmPPNWXG2iP4jg0v0EoMuGb6eNoEvFuserc7vtP9EeLFp1CA@mail.gmail.com>
 <7v1up6zmwr.fsf@alter.siamese.dyndns.org> <CAFfmPPPa=s8NAYDxoSa5SR91Y_tgRLUVo_bzgViE0wV5g0Ld3g@mail.gmail.com>
 <7vsjhmy6x2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <davidbarr@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:31:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4hN7-0002Ef-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 00:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757747Ab2CEXbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 18:31:12 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53699 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671Ab2CEXbM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 18:31:12 -0500
Received: by pbcun15 with SMTP id un15so3340511pbc.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 15:31:11 -0800 (PST)
Received-SPF: pass (google.com: domain of schacon@gmail.com designates 10.68.232.169 as permitted sender) client-ip=10.68.232.169;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of schacon@gmail.com designates 10.68.232.169 as permitted sender) smtp.mail=schacon@gmail.com; dkim=pass header.i=schacon@gmail.com
Received: from mr.google.com ([10.68.232.169])
        by 10.68.232.169 with SMTP id tp9mr20733966pbc.79.1330990271517 (num_hops = 1);
        Mon, 05 Mar 2012 15:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4X/vuAqgSpxBEVTHbXbATUAMiiLPtnk35/kSnYpCXKs=;
        b=uQtF4ZMrEMZzSDv6RVKqKJ5f3bYLT5uNvWDaib9L5n42kBX01sPcpnPoqW5Mc+W5Ir
         qGr8PH+wlr7hsQ7iPkMsxkYxRtIVm4disbpdxrd4ckiyoqo55/KFiNrGsa5i/xAr9ULr
         qUjeVuSOL58rr3YS2oo9CigiS2TLZSmH8zTbZAduTudcrfZ76Mzdkb4eZ6v0cmwdMVyq
         YerLql5CHgcplCW9QVmmvttJ/ttBHA1qJ/1T7z3d1Zl8Z4IgDZjJK1Can+SrfWAvnBnq
         5tAALhwaArRJyVwb9ENDYtqDMz9Eo9cjPsv7nyFZSSnad4EesI+qT5dYakwc0p7bVBvT
         rPmw==
Received: by 10.68.232.169 with SMTP id tp9mr17976373pbc.79.1330990271471;
 Mon, 05 Mar 2012 15:31:11 -0800 (PST)
Received: by 10.68.41.230 with HTTP; Mon, 5 Mar 2012 15:30:50 -0800 (PST)
In-Reply-To: <7vsjhmy6x2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192288>

Hey,

On Mon, Mar 5, 2012 at 3:17 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> David Barr <davidbarr@google.com> writes:
>
>> GitHub has a different mechanism for publishing project content.
>> They expect a special named branch, gh-pages.
>
> Hrm, so if they add a mechanism to name what branch to show the
> content from, I could set it from gh-pages to master and we will
> have an online HTML pages. =C2=A0Nice.
>
> I wonder if they can also do historical documents (e.g. manual pages
> for release 1.7.0) that way.

So, gh-pages is how you can publish project pages for a project.  If
you don't want to push to the gh-pages branch, you can just name the
repository 'gitster.github.com' and push to the master branch there
and that static content will be available at that url.

It just serves static content, so we won't serve older content automati=
cally.

I am also working on parsing the content automatically and hosting it,
including all older versions, under the git-scm.com domain. - also
making it searchable and whatnot, FYI.  This won't be done for a
little while, but I am working on it.

Scott
