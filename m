From: Stonky Fandango <stonkyfandango@gmail.com>
Subject: Highlighting whitespace on removal with git diff
Date: Wed, 20 Oct 2010 11:46:11 +1100
Message-ID: <AANLkTik7a8OQz2+SVTm+HjZkCtbjm6O9d12biCJ8MyZz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 20 02:46:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8Mor-0005Lb-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 02:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737Ab0JTAqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 20:46:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57207 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab0JTAqM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 20:46:12 -0400
Received: by wwf26 with SMTP id 26so564585wwf.1
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 17:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=rQelfVh1WfHNXwdZTPhUMtvn34xkm/JS/mqt7CzxY/c=;
        b=GHQJzGfNeQCMOpj0aR1BjQeXxK08S/sKnmmiQrYQGdPL6mXg66UVqxe/7R2PqJyP0f
         SKWlVscJGheldr0kBoi9SosOyd3nK8cMl+xmAG0tvIZBLMIHITiniDUo4N1dhTZxO0aJ
         3NIcPqy30pULr0H4mmiRAB1HrAAh7gr7oet6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rn1dOgKK9X8okmZmdUfbKtZTO6A4YqOcWduqdqY+1lQHzND8hJQqYY6wKQZzKIp3AN
         mrlvxS54r26iyuwEsZB2+08SBvHiS60y1U5R7taTj7Vjcpache7Spo3bo8Hs74N9ewNj
         BI/LvYN/CMDsY25V80/80uAKnzhuuyHWwKKio=
Received: by 10.216.157.132 with SMTP id o4mr1344827wek.7.1287535571104; Tue,
 19 Oct 2010 17:46:11 -0700 (PDT)
Received: by 10.216.65.79 with HTTP; Tue, 19 Oct 2010 17:46:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159381>

When I do say 'git diff', and I have added a line with a trailing
whitespace, i get a red square box highlighting the added whitespace.
(on the '+' diff line)
What I want, is the reverse - so when I delete an existing whitespace,
I get something similar, for example a blue box highlighting the
deleted whitespace (on the '-' diff line)

Currently the only notificate I get is identical
'-' and '+' diff lines, but no indication of the whitespace deleted

I know I can do this with graphical tools, but ideally would like some =
way
using the standard console git diff - if this is possible.

I have =C2=A0the following in my .gitconfig
---
[color "diff"]
whitespace =3D red reverse
[core]
=C2=A0whitespace=3D-indent-with-non-tab,trailing-space,cr-at-eol,tab-in=
-indent
---

Thanks,
