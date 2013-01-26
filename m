From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/3] branch: reject -D/-d without branch name
Date: Sat, 26 Jan 2013 10:12:51 +0700
Message-ID: <CACsJy8B1YS6EDNFzDL3zJiy5tb3Qn=0xxyZgSnQh4KM6yNNKpw@mail.gmail.com>
References: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
 <1359118225-14356-1-git-send-email-pclouds@gmail.com> <7vham53x01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 04:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TywDA-0002BQ-Fk
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 04:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab3AZDNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 22:13:23 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56266 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab3AZDNW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 22:13:22 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so1231074obb.0
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 19:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=TvSZ9OV4Aevz4FL+X5Hj79AJkCRnyQGayVseKkwcXLo=;
        b=ptv9cjUkkmZY2X48P9wAHDnuEjTyJx02NArMo43IZC9IFTjFNw4RRHURsgwUCRLM+W
         a2fYhI6aHuD5AycFOT+DRoQM2nN14xm6pbvq+zWj3GL4dJooIroejfx0TqexilVDhg8a
         t0vK9gp5R8srWFGSj9yk4SGNV6CRFhdPW5C5fcMR6qm+r8NvzFj7hCglrW8eou75fbKV
         h0Zws7xcUuiy20iKzPWP8qGJFR8Dg2hbqKmhttkZA8mHN5ZEjSNBBo/6IaUFLm8OY1LJ
         /i6ZDBKwGEXPCH6okDfufm1Ta9tAv8BqWe7oydA8HDENuYQgyM6azmBR/BkE/AMTaJ2D
         Nlxw==
X-Received: by 10.60.154.169 with SMTP id vp9mr6073464oeb.109.1359170001887;
 Fri, 25 Jan 2013 19:13:21 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 25 Jan 2013 19:12:51 -0800 (PST)
In-Reply-To: <7vham53x01.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214609>

On Sat, Jan 26, 2013 at 2:04 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> ---
>>  builtin/branch.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Forgot to sign-off?

Yes

> Is this a real problem?

Yes. My thoughts yesterday when I happened to type "git branch -D":

"Wait, I just entered a delete command without a branch name. It did
not report anything, which in UNIX world usually means successful
operation. _What_ did it delete??"

I knew this code so I just went check. If I did not know, I might as
well list all branches I had and see if something was missing. A short
message would have saved me the trouble.

> I do not see it particularly wrong to succeed after deleting 0 or
> more given branch names.
--=20
Duy
