From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/5] gettext docs: programmer docs in po/README
Date: Fri, 10 Sep 2010 19:35:48 +0000
Message-ID: <1284147353-18000-1-git-send-email-avarab@gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 21:36:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9OK-0006JH-Hp
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab0IJTgB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 15:36:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58786 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab0IJTgA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:36:00 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so3171634wyf.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6PQwYfk30QUZkwXOSjORJf7LCZ3KebmeLmFH1SvfF9Y=;
        b=NKbuOKLI5GXqPo72Ds/QbgW8Jq0GMzY5bjrRljCQT2nVc6q6udyaqGAy3aNBN02yJ4
         CUoYn/cjeMdiLj3rsov9LE8h70OsAqoZJIeL+xAorPgXzrc4yytNCkuAM6fOjpK1sH/w
         5UFvjPWEzYovEO5SuvgJpIzzpH2RqxXUiKcgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SuI/8hDlQQG2qJ+CY4tH06MoVp1XAKrqj9IkJfUc9IaphI+Lg29mLd6Z2Cs3aSiDyj
         0+oiQa7Wp7IoGDPmdXa81hPdoBNEfB6h7B/Z+jBM2pjHbO4ru3a2ALYnnbORXHqd0gMR
         is73AxloZ/1hbdjAvAB0YrMtt3jaM5XuwCNdY=
Received: by 10.227.37.95 with SMTP id w31mr378405wbd.0.1284147360019;
        Fri, 10 Sep 2010 12:36:00 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm2534921wbb.8.2010.09.10.12.35.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:35:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155960>

On Fri, Sep 10, 2010 at 17:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Fri, Sep 10, 2010 at 16:01, Junio C Hamano <gitster@pobox.com> wro=
te:
>> As a companion update to 6495411 (gettext docs: add po/README file
>> documenting Git's gettext, 2010-09-03), we would need a file in
>> Documentation/ directory to describe the use of _() and N_() for
>> programmers and point it from CodingGuidelines.
>
> I can add that to ab/i18n-for-junio, but haven't already. Isn't it
> better if I send that to the list for review instead of just tucking
> something at the end of the series. I can do either.

Here it is on top of ab/i18n-for-junio. These can also be fetched
from:

    git://github.com/avar/git.git ab/i18n-for-junio-with-docs

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
  gettext docs: add a "Testing your changes" section to po/README
  gettext docs: add "Marking strings for translation" section in
    po/README
  gettext docs: the gettext.h C interface
  gettext docs: the git-sh-i18n.sh Shell interface
  gettext docs: the Git::I18N Perl interface

 Documentation/CodingGuidelines |    7 ++
 git-sh-i18n.sh                 |   16 +-----
 po/README                      |  125 ++++++++++++++++++++++++++++++++=
+++++++-
 3 files changed, 133 insertions(+), 15 deletions(-)

--=20
1.7.2.3.313.gcd15
