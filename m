From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Patchdiff
Date: Wed, 27 Jan 2010 08:06:29 +0100
Message-ID: <36ca99e91001262306l58234073v83ce709bee6c54a0@mail.gmail.com>
References: <fabb9a1e1001261606i4f706387vaf5647436e454fb4@mail.gmail.com>
	 <alpine.LFD.2.00.1001262014250.1681@xanadu.home>
	 <7vzl40wcz2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:06:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na1z2-0002I3-KL
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 08:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab0A0HGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 02:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754156Ab0A0HGc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 02:06:32 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:39401 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab0A0HGb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 02:06:31 -0500
Received: by fxm20 with SMTP id 20so1232529fxm.21
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 23:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DwqZ1gIO/uIZX82w3Ohn1lTGmwSYoHUfXvjzSoAaD+U=;
        b=SnTW+JXzT1+z86AGeY4dy8unSKTF56uW8lWlIJL0jsxxP2cLn74TwjBQw6ZuBs/Kq5
         k3sKSMr5QgTkVPdnWDCk3ky1fWTv2tGDGj+zEZ5LNwPO3C6jaUioVXguTnbDk4FkL2MT
         lle2ZkEjhPQadPH4qmtHfs1r39dfMaSJYULf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nB5t60XLFBljrzK0NvDVaQWfKeYnwdsDcieZlxPPCLrKw59BFSm+MszovKRhHNc/6I
         3nMApxKDLjLaoKCY2DJH3QNkb9nRM3NiI8ZwE+1y0cML9BsEm90Wcr7pu4xymnhGS4Ub
         SddOBIELFf3Edrno+EI6nDuZH+f9zRjmkNF0U=
Received: by 10.223.5.82 with SMTP id 18mr3269735fau.79.1264575989627; Tue, 26 
	Jan 2010 23:06:29 -0800 (PST)
In-Reply-To: <7vzl40wcz2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138108>

On Wed, Jan 27, 2010 at 02:30, Junio C Hamano <gitster@pobox.com> wrote=
:
> Nicolas Pitre <nico@fluxnic.net> writes:
>
>>> Do we have anything that allows me to compare two versions of a pat=
ch?
>>> In theory it'd do something like "apply both patches to the their
>>> merge base, then show the diff between the results". I don't think =
we
>>> have something like that, since there's probably some major caveats
>>> about conflicts when applying the patches to their merge-base. Or
>>> perhaps my theory is silly, and there's an easier way to compare tw=
o
>>> patches (other than looking at a diff's diff, which I've never been
>>> good at).
>>
>> What about Git's diff -c/--cc ? =C2=A0You'd have to reverse the pare=
nthood
>> logic though.
>
> When I did "diff --cc" originally, I thought about its interaction wi=
th
> reverse (-R), and gave up.
Actually, I have done this. My intention is to use this as a new merge
conflict style.

I will send the patch, but not today.

Regards,
Bert
