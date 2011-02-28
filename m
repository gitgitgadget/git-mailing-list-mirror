From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/2 v2] Adding Beyond Compare as a merge tool
Date: Mon, 28 Feb 2011 08:02:59 +0100
Message-ID: <AANLkTi=ZMt8-Xt8fX2hawJPQnSc8OCUqjLoQ04R5rHtZ@mail.gmail.com>
References: <4D6A355C.3000805@gmail.com>
	<7voc5wk5wl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>,
	charles@hashpling.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 08:03:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptx8O-0005SC-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 08:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab1B1HDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 02:03:04 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34728 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab1B1HDA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 02:03:00 -0500
Received: by qwd7 with SMTP id 7so2602121qwd.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 23:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JX84VlkvrYoq8brinTTrBJjpAaZuh9wj2lbC/WFCxu0=;
        b=mIn400ILbXw6i394Sd+Rgqwu12J/sU1Y1qyksaGo04golBSP2LE5zoTXI+s0FMDMMi
         w2yNsa0pNJSCXNUo7deXZfNUx2mvccCkXua6ciXD0LPTZVeYFT2VGmqfkQSrwIJp+U6R
         RU11R1rZoiYNBuRDSMBIltjvg8Pt4w/9UhVH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EFcdxboNqSFgZLU3ySq/KJnjzt2lFY0jjimRMpOQYufZ1FfPwO5T1zcWl5FFWGry2G
         3qT+DLiTAPQNgUywEtKltNAh5DYU0RH//T19O3pbq7hWlf17ev1c4mRTBtdg9ya4lA8e
         2XCIUj55KyN3nlnwXLB8RzNPzFneYgkAtK0sg=
Received: by 10.224.45.132 with SMTP id e4mr4141362qaf.296.1298876579177; Sun,
 27 Feb 2011 23:02:59 -0800 (PST)
Received: by 10.229.17.73 with HTTP; Sun, 27 Feb 2011 23:02:59 -0800 (PST)
In-Reply-To: <7voc5wk5wl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168073>

On Mon, Feb 28, 2011 at 07:52, Junio C Hamano <gitster@pobox.com> wrote=
:

>> Sebastian Schuberth (2):
>> =C2=A0 mergetool--lib: Sort tools alphabetically for easier lookup
>> =C2=A0 mergetool--lib: Add Beyond Compare 3 as a tool
>>
>> =C2=A0Documentation/git-difftool.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A04 +-
>> =C2=A0Documentation/git-mergetool.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A04 +-
>> =C2=A0Documentation/merge-config.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A08 +-
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 =C2=A02 +-
>> =C2=A0git-gui/lib/mergetool.tcl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0101 +++++++------
>> =C2=A0git-mergetool--lib.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0247 +++++++++++++++++---------------
>> =C2=A06 files changed, 195 insertions(+), 171 deletions(-)
>
> Hmm, I really would have liked if you took the hint and separated git=
-gui
> bits into separate patches.

Sorry, I somehow thought this would not be necessary as there were no
changes to git-gui/lib/mergetool.tcl since v1, but that was a a dumb
thought. I'll separate the patches if I have incremental updates.

--=20
Sebastian Schuberth
