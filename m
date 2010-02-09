From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [stgit] Documentation build error in proposed branch
Date: Tue, 9 Feb 2010 23:07:29 +0000
Message-ID: <b0943d9e1002091507p35d93796x183d81996b4106c@mail.gmail.com>
References: <a1e915351002080500u74e4878fy500713ddb25aa750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:07:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NezBA-0002W9-T2
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 00:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab0BIXHc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 18:07:32 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:54793 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab0BIXHb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 18:07:31 -0500
Received: by fxm20 with SMTP id 20so652498fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=o+KTOM9N1M3DnUsDrZJ3F1gpKs8ArvRNdGxAOs54wY0=;
        b=MkdhCwllNF2a04XMXp4U3ntG3vm2w0n8LpvNIPc6RZhra+cJAFKguCCt4UeFyx1yB5
         U0u04cWu5avqz3mXusPTvLu1iwT8P4fp1YlcwapHnshrmTruLJVNUJksBBorWD8n9GVQ
         G1GC2Fz5bzrDcgvVKMIM1+obHvxeR812xF+Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bimOuu8R6VSc+MTdzjmBCCToSfDc6iJMwJVRqVafknEcEuxhCsWYWrCbR0qb62ClPG
         yFxCrdAfX/PgLbPlcFbLTjul+x4ufHScm9abfkbSYVxUov6a2tDWtCEutedv0brX55ga
         lLuALjz/X69AlLazAEESiTQljs+C3ETK6quUA=
Received: by 10.223.5.87 with SMTP id 23mr5847377fau.87.1265756849938; Tue, 09 
	Feb 2010 15:07:29 -0800 (PST)
In-Reply-To: <a1e915351002080500u74e4878fy500713ddb25aa750@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139457>

2010/2/8 Gustav H=E5llberg <gustav@gmail.com>:
> As of recently, I cannot compile documentation in
> git://repo.or.cz/stgit.git proposed:
>
> lux:~/devel/stgit$ git ls-files -o | xargs rm
> lux:~/devel/stgit$ git rev-parse HEAD
> c7506039d0299c093140857b7a617ec6bcdbfc13
> lux:~/devel/stgit$ make all doc
> =A0 :
> cd Documentation && make all
> make[1]: Entering directory `/home/gustav/devel/stgit/Documentation'
> rm -f doc.dep+ doc.dep
> perl ./build-docdep.perl >doc.dep+
> mv doc.dep+ doc.dep
> make[1]: Leaving directory `/home/gustav/devel/stgit/Documentation'
> make[1]: Entering directory `/home/gustav/devel/stgit/Documentation'
> ../stg-build --cmd-list > command-list.txt

Thanks for reporting this. I actually pushed it to master without
checking the documentation building. I'll have a look tomorrow.

--=20
Catalin
