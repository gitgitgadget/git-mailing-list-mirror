From: Miles Bader <miles@gnu.org>
Subject: Re: git alias and --help
Date: Sat, 29 Oct 2011 03:25:09 +0900
Message-ID: <CADCnXoaPbCK0B=XZwdAY=yEb61YhvyQ6FA=BAxkADJ6hra-_Lg@mail.gmail.com>
References: <j8clg9$ldh$1@dough.gmane.org> <7vfwiexe6m.fsf@alter.siamese.dyndns.org>
 <7v8vo6xd4u.fsf@alter.siamese.dyndns.org> <buoty6t9937.fsf@dhlpc061.dev.necel.com>
 <m362j95jv3.fsf@localhost.localdomain> <7v62j9t2gj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Gelonida N <gelonida@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 20:25:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJr7s-0004p4-Gj
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 20:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab1J1SZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 14:25:52 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33739 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab1J1SZv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 14:25:51 -0400
Received: by eye27 with SMTP id 27so3789641eye.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hwNWvzhCBmwgnqbEuZaTfwLM045njC64IkodmJb3ZfE=;
        b=Sqc87bVgjvRpcMGLv5k2HROLcv80cWpJI1oKMxl/EMhbr3ufQXC6IW0ckwy4rCI1il
         ybnhK32XlRIiArDdTJyirJLJG8sIgrLPRnCG3uzLFGkRVLPac8ygIq76i71Eo4mzNfMS
         QLy5Cllk1gntp6J0w5BXNf344BFM/kYbkq1CI=
Received: by 10.14.17.27 with SMTP id i27mr407190eei.133.1319826350260; Fri,
 28 Oct 2011 11:25:50 -0700 (PDT)
Received: by 10.14.100.76 with HTTP; Fri, 28 Oct 2011 11:25:09 -0700 (PDT)
In-Reply-To: <7v62j9t2gj.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: fTVTnyZ7sMq_qoFOgmC_80MjxFs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184423>

2011/10/29 Junio C Hamano <gitster@pobox.com>:
> =A0 =A0$ git lgf --help
> =A0 =A0'git lgf' is aliased to 'log --oneline --boundary --first-pare=
nt'
>
> with "git log --help", but that is aiming too low for my taste.
>
> If you are redesigning the help system, isn't it a shame that you are
> discarding other tokens in the alias when giving help? Wouldn't it be
> wonderful if you extracted the option descriptions for these three op=
tions
> specified and showing only that, for example?

I think that would be the wrong thing in most cases though:  an alias
like the above happily allows the user to specify other git-log
options on the command line; when I get help on an aliased option,
it's often precisely because I want to see the _other_ options I can
use...

E.g., I have:

   $ git slog --help
   `git slog' is aliased to `log --date=3Dshort --pretty=3Dtformat:"%h
%ad  %s" --abbrev-commit'

But the typical question I want to answer is something like "OK, how
do I reverse the output order of slog?" or "how do I limit the output
of slog to a certain date range?"

-miles

--=20
Cat is power. =A0Cat is peace.
