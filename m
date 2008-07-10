From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Thu, 10 Jul 2008 12:42:53 -0700 (PDT)
Message-ID: <m3d4lledbn.fsf@localhost.localdomain>
References: <200807102057.15063.toralf.foerster@gmx.de>
	<7vk5ftpnek.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?b?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 21:44:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH248-0003qH-Js
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 21:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbYGJTne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 15:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbYGJTne
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 15:43:34 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:24022 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbYGJTnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 15:43:33 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1692927ywe.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=D1P0Ks+TjypX9huirLYAG/zXIYSGwvvoOsvxZpaSef0=;
        b=QeS3uTJP1LdYPgv+DkXykCSn+lHgXNWysN4WcSeIJEckVBpZbkR1/macxQP0iQZQhF
         kK73zh1PSJDFWlLUcWodVFHkig28ncYYBLf9TKVpiaStD5E+D23snh72azRFLqBTmgWa
         vi06Hpn5tyxZYPz5INwfFZz/wmBDKZ+4DW0oY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=tD7PTrs4PRKRKzppsATjsZAu7YTvi51AiLmpxk9UI1FtbJHXDGy7uskkzZOzAlhPPW
         Ct7TRtHU+cpEnhGM4U4oati0Q76xNT5WwdlguME3FZk6biaEZnJ1cn4TlC0nXvpgw4+k
         L+58KckkeQadOHreQgzgBrRjT0VN9JUaAWOvI=
Received: by 10.114.183.20 with SMTP id g20mr11950715waf.77.1215719004905;
        Thu, 10 Jul 2008 12:43:24 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.245.18])
        by mx.google.com with ESMTPS id 28sm1055108fkx.1.2008.07.10.12.42.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jul 2008 12:43:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6AJgSxH008819;
	Thu, 10 Jul 2008 21:42:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6AJg5WW008812;
	Thu, 10 Jul 2008 21:42:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk5ftpnek.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88001>

Junio C Hamano <gitster@pobox.com> writes:

> Toralf F=C3=B6rster <toralf.foerster@gmx.de> writes:
>=20
> > git-describe gives an informative string about the current status:
> > tfoerste@n22 ~/devel/linux-2.6 $ git describe
> > v2.6.26-rc9-56-g6329d30
> >
> > I appended those strings to the names of my UML kernel executables.
> > Unfortunately I didn't used the commit id and now I'm wondering whe=
ther git
> > could accept v2.6.26-rc9-56 as well in future.
>=20
> It does take v2.6.26-rc9-56-g6329d30.
>=20
> It will never take v2.6.26-rc9-56.  The world is not linear.

Nevertheless it _could_ be unique.

Besides, it would be nice to have some command (git-rev-parse perhaps?)
which could take ambiguous commit-ish, and list all commit which matche=
s
it.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
