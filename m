From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Is current HEAD pointing at a given revision ?
Date: Tue, 14 Jun 2011 17:56:43 +0200
Message-ID: <BANLkTimMkOS_Q9gb_ta2P3NSMGyNJtKgJA@mail.gmail.com>
References: <BANLkTikFTHc4Qiu1YLxXgPhweNnVqMO11Q@mail.gmail.com>
	<m3mxhkvlcw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 17:56:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWVyz-00033T-OU
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 17:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab1FNP4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 11:56:44 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56451 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab1FNP4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 11:56:44 -0400
Received: by pzk9 with SMTP id 9so2699093pzk.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=akcI7g7W9iNlR0OCEpEYs1otUxVd1qT75DEXA8EGy1A=;
        b=Z9OwivMwi9fsCOBjYM0U2KG+zN8JBtfLd2t39CqvXMW6Gkw/CYVfJ9mz+zoLfq1fwD
         c3QuRoAVxI7N/gb+LhtNtUnKwzer/Jwonf1/mjGl2UhFIj+ShG6BM7Q8tJqjUV0uWnoV
         1tIuZIXlsEWtQI24LtxO+pHSMareFMuefiMXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q+QVLgSJE2iKavqYqzYYW8j88h2s/r2E2CHAb+xQegUbhSUGwzmijIjS7502KcZ0/+
         la+oFLrjXcr7hfIFo9hB52THEkqpJlvbHkV37Id7Ef1h/ySX8ZQWzlHJFLlC7qeHacP+
         pAD1GiuzM80NhaC5UJA6CwqZS42WV8WHEeqXE=
Received: by 10.142.240.20 with SMTP id n20mr1120954wfh.401.1308067003480;
 Tue, 14 Jun 2011 08:56:43 -0700 (PDT)
Received: by 10.142.110.7 with HTTP; Tue, 14 Jun 2011 08:56:43 -0700 (PDT)
In-Reply-To: <m3mxhkvlcw.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175780>

On Tue, Jun 14, 2011 at 11:00 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> Francis Moreau <francis.moro@gmail.com> writes:
>
>> I have a given revision (tag, sha1 ...) and I'd like to know if that
>> revisions corresponds to what the current HEAD is pointing at.
>>
>> Could anybody give me some advices for achieving this ?
>
> If you want to know if given revision (or ref) points at the same
> thing as HEAD, you can use
>
> =A0[ "$(git rev-parse HEAD)" =3D "$(git rev-parse $ref^{commit})" ]
>
> or something like that. =A0The '^{commit}' is here in case $ref point=
s
> only indirectly to commit, via a tag object.
>

I see thanks.

I'm not sure what the ^{commit} is for because in the case of tag
object, git-rev-parse seems to work fine without the suffix:

git rev-parse v2.6.39
8b0753a3df28c21b0570fa21362c5f1b3b4f59bf

This is in a kernel git repository

Thanks
--=20
=46rancis
