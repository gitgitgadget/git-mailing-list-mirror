From: Matthias Kestenholz <mk@feinheit.ch>
Subject: Re: [RFC PATCH v2 3/3] Implement unstage --patch and discard --patch
Date: Fri, 24 Jul 2009 18:40:40 +0200
Message-ID: <1f6632e50907240940j6174a689i4390c245f0771fcb@mail.gmail.com>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
	 <9cad6176fe941bd56bad7fed49cc55a96a7040ae.1248452530.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 24 18:40:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUNpC-0003hk-IF
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 18:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbZGXQkm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 12:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZGXQkm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 12:40:42 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:56633 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbZGXQkm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 12:40:42 -0400
Received: by ewy26 with SMTP id 26so1878115ewy.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 09:40:40 -0700 (PDT)
Received: by 10.210.10.11 with SMTP id 11mr1290605ebj.5.1248453640547; Fri, 24 
	Jul 2009 09:40:40 -0700 (PDT)
In-Reply-To: <9cad6176fe941bd56bad7fed49cc55a96a7040ae.1248452530.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123930>

On Fri, Jul 24, 2009 at 6:24 PM, Thomas Rast<trast@student.ethz.ch> wro=
te:
> This implements a new optional argument --patch=3D<mode> in the
> git-add--interactive helper. =C2=A0The modes are:
>
> 'stage' (default, as before): offer hunks from 'git diff' and stage
> =C2=A0the ones selected by the user.
>
> 'unstage': offer hunks from 'git diff --cached', and unstage the ones
> =C2=A0selected.
>
> 'discard': offer hunks from 'git diff', and discard (i.e., undo the
> =C2=A0edit in the working tree) the ones selected.
>
> With this in hand, we can then easily add a --patch option to the
> git-unstage and git-discard scripts that run git-add--interactive in
> the corresponding modes.
>

While I do not really think even more git commands are so helpful, I
like the proposed command names, and I really like that it would be
possible to remove single hunks from the index. I have come to rely
very much on git add -p to make self-contained and clear commits and
think it would be a great feature if I could use this the other way
round too.


Thanks,
Matthias
