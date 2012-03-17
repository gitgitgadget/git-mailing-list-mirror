From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to reorder all commits include the initial commit
Date: Sat, 17 Mar 2012 07:26:18 -0700 (PDT)
Message-ID: <m3k42jl2wn.fsf@localhost.localdomain>
References: <CAFT+Tg_DmqxiK1qw1YvNZtY07ZaZ89+JWohdWw2fm8f=6hAwiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 17 15:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8uaQ-0005Fr-7t
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 15:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab2CQO0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 10:26:22 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33470 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab2CQO0V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 10:26:21 -0400
Received: by wibhr17 with SMTP id hr17so1831288wib.1
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :user-agent:date:message-id:lines:mime-version:content-type
         :content-transfer-encoding;
        bh=jQhiFjFBhd+9CvNAb1oHkF+PN6XH6pYJxeopPMgzdEY=;
        b=vSB2nUWLlmpm+CNDgXSsVNbKv3prkFNLUJIpeN5JRIqJ6tG3Ls72kLFaFtgqoBzCbK
         NbWQ+xWen/3SScbex7FRMA/6lhGfDJ1iwCNTHA5Fz8CtzRjCBsvKGlfhpiDbCKE15IUy
         uYP26wWHADYeDc+Emb6T/BBEmbPjD3oX2QI4j/VUtpDa7tUl4hWyI4zNY6bmK3GPPRD4
         Q4YTVycvLMJPxnD/aXe3pMWcMgWkEZPgRSW0mMjqN5LUiSGU+mIKluw8MdJHrAKur/gA
         2VbFbVKymN/VCXpnnbXZ+4DbacFCVCg54sFLY83o5mShIWeVPxSeKlnTlKLClOOQ/TQG
         ZFpA==
Received: by 10.180.100.196 with SMTP id fa4mr14857823wib.0.1331994379715;
        Sat, 17 Mar 2012 07:26:19 -0700 (PDT)
Received: from localhost.localdomain (aeho214.neoplus.adsl.tpnet.pl. [79.186.196.214])
        by mx.google.com with ESMTPS id gg2sm13108689wib.7.2012.03.17.07.26.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 07:26:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2HEQHJI017817;
	Sat, 17 Mar 2012 15:26:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2HEQGnd017814;
	Sat, 17 Mar 2012 15:26:16 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAFT+Tg_DmqxiK1qw1YvNZtY07ZaZ89+JWohdWw2fm8f=6hAwiQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193328>

semtlenori@gmail.com writes:

> Sometimes, I need to reorder all commits, which include the initial
> commit, in my branch.
> So I tried it using git-rebase as follows, but it failed with the fat=
al error.
>=20
> (supposing the initial commit is=A0793ea88)
> $=A0git rebase -i 793ea88^
> fatal: Needed a single revision
> invalid upstream=A0793ea88^
>=20
> How can I do that?

Use `--root` option.

--=20
Jakub Narebski
