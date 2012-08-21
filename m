From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Mon, 20 Aug 2012 22:16:56 -0400
Message-ID: <CAG+J_Dz3SHyNSUBuFcHu-x8gkE+wj5wJGLOfopNQw0dBThtSuA@mail.gmail.com>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
	<CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
	<7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
	<CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
	<7v628dght9.fsf@alter.siamese.dyndns.org>
	<CA+sFfMexCWLza65bVp2uXoqo3+yY5MPBBcGugoEA6UCEwAv6Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 04:17:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3e1g-0002iL-9c
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 04:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab2HUCQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 22:16:58 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46727 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab2HUCQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 22:16:57 -0400
Received: by obbuo13 with SMTP id uo13so10468778obb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 19:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kMg5Y/WXqqsLE8qWm9fKrUWFEM5SgRgY7zmiDTcoSPE=;
        b=WHjRJRsw9ZrJZda2j/7FvAiS2Q7OsG6Sl3btsnytWpWlezo5kXoGhZpWcqPKiPmvxr
         Vr3cc4t545t8VnwUEAZgNCGDwq4dNWR47oyDsRrDraMGq1x1nlt77xYXpgmoWdyar2tw
         8l5Phc/zeKcDHnK1GhkcU0gPB7z7ACRthhfbfMb0ZU4Gvwh0C9X5oKIx0WGAKbo6o8c1
         b+/uJwm44PgXqwxUooYmFzTjQhnl6sg+UIVPG6cbWgyQcLr1AykV2Pdj1jV5iznzXxK3
         wWdhwDRATT2vLKm+trEzQHoL6nHXD4HDTr6bkVVGq3P4kkRQxYm4+oJNdgaKJPJQ9tqG
         QDCg==
Received: by 10.182.167.101 with SMTP id zn5mr11657452obb.60.1345515416523;
 Mon, 20 Aug 2012 19:16:56 -0700 (PDT)
Received: by 10.60.2.69 with HTTP; Mon, 20 Aug 2012 19:16:56 -0700 (PDT)
In-Reply-To: <CA+sFfMexCWLza65bVp2uXoqo3+yY5MPBBcGugoEA6UCEwAv6Ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203919>

On Mon, Aug 20, 2012 at 9:53 PM, Brandon Casey <drafnel@gmail.com> wrote:
>    git config --system -e
>
> Hopefully your editor exposes the path that it is editing even if you
> don't have permission to modify it.

  GIT_EDITOR=echo git config --system -e

works for me.

j.
