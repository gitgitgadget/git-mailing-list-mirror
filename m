From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: translation difficulties :: revision and commit
Date: Wed, 27 Apr 2011 11:34:06 +0100
Message-ID: <20110427103406.GA7186@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 12:34:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF24X-0006ud-Vj
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 12:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756054Ab1D0KeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 06:34:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46107 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750Ab1D0KeK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 06:34:10 -0400
Received: by wwa36 with SMTP id 36so1727088wwa.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 03:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=FrqHjGnBzCkxYqG7sjE++GcrCmQIbKBGCh3V0dL7NJ4=;
        b=JFUtvv+VnY2XetSwLnl/p/LJ/o/G2ZAeVMN6SYiJhAQ5pjZ/y+zmQZKbGa3qLc63i1
         XNdoNlAS2lEMHvL49Aikcs/SLVHWLUX46ItGOeNPHE9nYFuapT4OnH0+TtXZvYiymVfR
         Hz1r5U4cg5R/p4r3PWo50bNZN07oItuWySvgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=lzKQ+3va3EhgnUXRjMhoRvpJCZGgQ6B6tPfBSUkFmtIFy6MtcZknUkYRrPsAxqHMRX
         3jCEMf5qoXteppE76XWmrdBve0hrqEnHHg1Z/f2fQ5e4KJO3AA6OrgedTjV6VduE8193
         xQa9RvZ0PSD+RiFNY6aGSgeRAigabTDMbJqME=
Received: by 10.216.62.195 with SMTP id y45mr915043wec.15.1303900449534;
        Wed, 27 Apr 2011 03:34:09 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id n2sm282689wej.22.2011.04.27.03.34.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 03:34:08 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172215>

I am doing git translation to Lithuanian, and cannot find the differenc=
e
between "revision" and "commit", as I need to create a word for
"commit". It is confusing.

The problem is we don't have a noun for commit. Verb would be =E2=80=9E=
=C4=AFkelti=E2=80=9C,
which is suitable, but noun out of the verb (=E2=80=9E=C4=AFk=C4=97lima=
s=E2=80=9C) is
linguistically unsuitable and messes up meaning in some cases. Therefor=
e
local community is suggesting word =E2=80=9Erevizija=E2=80=9C (revision=
) for noun. It
would make perfect sence in SVN context.

Are there any objections? Can verb "commit" be called "revision" in git
in noun context? What are the differences? From
Documentation/revisions.txt:

    A revision parameter '<rev>' typically, but not necessarily, names =
a
    commit object. It uses what is called an 'extended SHA1' syntax.

Is it that revision is a name for commit object, stash object,
cherry-pick object? No? Please clarify.

Thank you.

Motiejus
