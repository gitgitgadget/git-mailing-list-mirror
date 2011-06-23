From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] git-remote.txt: fix wrong remote refspec
Date: Fri, 24 Jun 2011 01:03:06 +0900
Message-ID: <1308844986.1332.10.camel@leonhard>
References: <1308804319-6354-1-git-send-email-namhyung@gmail.com>
	 <7viprx3yay.fsf@alter.siamese.dyndns.org>
	 <7vy60s36mm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 18:03:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZmNG-00088h-Om
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 18:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759443Ab1FWQDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jun 2011 12:03:18 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62800 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759077Ab1FWQDR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 12:03:17 -0400
Received: by ywe9 with SMTP id 9so768090ywe.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=rxvXiOeZJgP9UC97wWGYkXWkcKt5a9VxzC3QhxsOsrs=;
        b=AkmiY56fRlPtFEMvrbj+wtBJEmdY7fyTA9zXWKZdSzeOL6u+onalaTw3IEvEtaX69c
         6WrEySCYGHAzExXgipiEwNha71h+/r7iadNjmUrsYlQoejiSJzYqgxTWhGA+tyM4OUlg
         s1Fg58pKd+qrh6n+Dw4iX8EYrNwTGUu/q6Fhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CN3J8UMzxMsh4VjTaZftb+Fxp+njg+KjrrHtmSPD0iNah19t64zk4mkwhvh9JNZENo
         W9xTO5ty68QJydb6tA/TaiQsL7PNImjiPBDjWNyvmVua7P+mc4qQJaDxTA3XYyEo0P/p
         oSGqZ2ht7CR0EXZSC6hh6aXNhR+ggYAj7jJyo=
Received: by 10.236.27.37 with SMTP id d25mr3510605yha.160.1308844996531;
        Thu, 23 Jun 2011 09:03:16 -0700 (PDT)
Received: from [192.168.111.3] ([118.176.77.244])
        by mx.google.com with ESMTPS id v4sm252752yhm.48.2011.06.23.09.03.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 09:03:11 -0700 (PDT)
In-Reply-To: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176273>

2011-06-23 (=EB=AA=A9), 08:33 -0700, Junio C Hamano:

> And here is my attempt, on top of Namhyung's v2 of this patch.
>=20
> -- >8 --
> Subject: git-remote.txt: avoid sounding as if loose refs are the only=
 ones in the world
>=20
> It was correct to say "The file $GIT_DIR/refs/heads/master stores the
> commit object name at the tip of the master branch" in the older days=
,
> but not anymore, as refs can be packed into $GIT_DIR/packed-refs file=
=2E
>=20
> Update the document to talk in terms of a more abstract concept "ref"=
 and
> "symbolic ref" where we are not describing the underlying implementat=
ion
> detail.
>=20
> This on purpose leaves two instances of $GIT_DIR/ in the git-remote
> documentation; they do talk about $GIT_DIR/remotes/ and $GIT_DIR/bran=
ches/
> file hierarchy that used to be the place to store configuration aroun=
d
> remotes before the configuration mechanism took them over.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

By quick grep-ing $GIT_DIR/refs/, I found git.txt and
glossary-content.txt might need the same treatment. Did/Could you check
out those too?

Otherwise, looks good to me.
Thanks.


--=20
Regards,
Namhyung Kim
