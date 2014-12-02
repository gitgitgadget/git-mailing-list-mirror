From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] ls-tree: disable negative pathspec because it's not supported
Date: Tue, 2 Dec 2014 19:14:37 +0700
Message-ID: <CACsJy8CY0r0V7syGbtor2t+eOM4Tmzj38qL4EaL+QiE-z7B+AQ@mail.gmail.com>
References: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
 <1417338302-8208-4-git-send-email-pclouds@gmail.com> <xmqqfvczp39n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:15:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvmMN-00059k-SB
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049AbaLBMPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 07:15:09 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:63801 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbaLBMPI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 07:15:08 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so10696143igd.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VTbi4Qlwa/n3/kuWVim412briQI7by+zud2Sb98X8kw=;
        b=AGz7rAdYYdo9K/XTZ8BGJKFkC3Ws4y5o1rla9n/mSi9DjsvGG1IODb1BvRwEHlOYyB
         x9qlgJUv+OY+l64PPQEIUbnVtm8gQL3s9Dj5Y1l4UWgJ6pu1qWAsKTLAj/4n//b2sonA
         TCI1nrTHNjrW+lh6MpRXWbBqArSy19NhRgfjaMQnwotAzYvnhiye69MtpND4B4/6o++4
         OQvq2keYlR3+fuOTZw7F25Qm8+vuoO+iqb9TjuVaUOfW4G6TQkjzoDcI6s2vs0esJV1b
         6+ie6+HFknH6wH5nfMV1aHSHgSxNn15dg8xCW1BVNCqw8WWPu9tskE3O2jYoyL8RkYuX
         JzWg==
X-Received: by 10.51.17.66 with SMTP id gc2mr7688460igd.27.1417522507955; Tue,
 02 Dec 2014 04:15:07 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Tue, 2 Dec 2014 04:14:37 -0800 (PST)
In-Reply-To: <xmqqfvczp39n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260562>

On Tue, Dec 2, 2014 at 2:40 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>
> Hmph, that's sad.  Should the below say "test_expect_failure"
> without "test_must_fail", anticipating a fix later?

Not a fix from me any time soon (I still need to improve pathspec
support in git-mv). If the git-list-files series goes well, I do plan
to make it list trees and it should support all pathspec without the
fear of subtly breaking a plumbing. But I will change it to
expect_failure unless you change your mind.
--=20
Duy
