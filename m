From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Pay attention to GIT_DIR when searching the git directory
Date: Mon, 05 May 2008 07:10:53 -0700 (PDT)
Message-ID: <m3r6cg6dur.fsf@localhost.localdomain>
References: <1209946178-29398-1-git-send-email-joerg@alea.gnuu.de>
	<alpine.DEB.1.00.0805051234260.30431@racer>
	<20080505125302.GA11523@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=macintosh
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, jjengla@sandia.gov
To: =?iso-8859-15?q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon May 05 16:11:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt1Px-0005DX-4g
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 16:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbYEEOK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 10:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbYEEOK7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 10:10:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:54561 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbYEEOK6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 10:10:58 -0400
Received: by ug-out-1314.google.com with SMTP id h2so58499ugf.16
        for <git@vger.kernel.org>; Mon, 05 May 2008 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        bh=hdD62X0z23Ne38k4d+2xbm7SM3TKVti2uSAUfQY8I38=;
        b=ZYuCy+khUa9F25bMOrM5QuxNDVu0iWDtdR7GAjMmUY14imqvC0LNdPPBUbjX90TQeoV1X4XhZvDAFBSpAcEAoAw5jI5KPm4TzgrO+Xl1OXG4BFzlpGWCaUO0lskjDyMnHYBesd/vACRfMEHLoL2FQ13iaYY4vhc4vwbiBJsEnlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        b=j5zacap+o047KM2BwUeGDCfnm6NVbFtfwxaETRzbvx9C942TKD/VA0jdlERYRwuX2B4g8Q5ysdxDYuiPgf8TNtjV2PPmL0IiTq4D7ZGA0n/lAr5GsCslhdX/0WUXAHhIA6QL0MGT6zcVMuDLUojfNlqez34T1ZtRvmH0obVh1R8=
Received: by 10.66.249.8 with SMTP id w8mr4539700ugh.75.1209996654759;
        Mon, 05 May 2008 07:10:54 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.199.6])
        by mx.google.com with ESMTPS id w28sm2135106uge.79.2008.05.05.07.10.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 May 2008 07:10:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m45EAgek011005;
	Mon, 5 May 2008 16:10:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m45EAbK7011002;
	Mon, 5 May 2008 16:10:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080505125302.GA11523@alea.gnuu.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81284>

J=9Arg Sommer <joerg@alea.gnuu.de> writes:

> Johannes Schindelin schrieb am Mon 05. May, 12:36 (+0100):

> > If you do not say _what_ is affected by the change, you only confus=
e
> > the readers.
>=20
> Do you want something like =D2initialization: Pay attention to GIT_DI=
R when
> searching the git directory=D3?

I think the idea was to use
  "contrib/hooks/setgitperms: Use GIT_DIR if set"
or something like that.
=20
> Is there a document with guidelines for commit messages, e.g. write t=
he
> first letter upper or lower case?

There are a few unwritten conventions.  You can always check existing
commit messages, via

  $ git log --pretty=3Doneline --abbrev-commit --no-merges

and see that commit title (first line of commit message) is either
short sentence starting with upper case, bt without fullstop, or
sentence preceded by the subsystem affected, using "<subsystem>:"
prefix.

Examples:
  Fix use after free() in builtin-fetch
  git-svn: detect and fail gracefully when dcommitting to a void

--=20
Jakub Narebski
Poland
ShadeHawk on #git
