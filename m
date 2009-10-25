From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 0/3] format-patch updates
Date: Sun, 25 Oct 2009 16:54:48 +0100
Message-ID: <4AE474C8.9000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N25Qq-00058U-GI
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbZJYPyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 11:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbZJYPyr
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:54:47 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:47550 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbZJYPyq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:54:46 -0400
Received: by ewy4 with SMTP id 4so2959555ewy.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=rktkLPNd8MxivohejAGu86EubFy5ikiHJc6ICk5H8og=;
        b=bwmL6Af6neEqatlTRzzr+7DHEKPru47gWNHDeGcAL22cJWsMmHrDaVVIuUTz4PFjqJ
         JYyCq2j7ubwmI1Jv11Jy5yxy0m7tWQbwHqau1wLa3/3Pj3WO1q/7tI+qU17N/KDfy//E
         AjR3vi6G+ox56e8XYiQr7RSvSQ7nQZ0QoVHfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=bJS84lzSgEzy2wsuVFRxmTBg1HPyZaVt21orP9g4tfJWMdgkxuZmJ7eWYjtobBRhep
         +iPU17cEHwQCKYG0agnXgfuo2CT4zuOh0kbNw+XY7a+nReOrGJ89W7HcyxUoxMqowJJV
         D+xO7ucVKBP3GOcx4jN84SelPiFpqruG3CSmg=
Received: by 10.210.2.17 with SMTP id 17mr2636717ebb.46.1256486090278;
        Sun, 25 Oct 2009 08:54:50 -0700 (PDT)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 23sm10420532eya.12.2009.10.25.08.54.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:54:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131215>

I noticed that the description of the -p option for the format-patch wa=
s out-of-date.

In the first patch I suggest how the documentation and implementation c=
an
again be made to agree.

The second patch builds on the first patch and removes the description =
of
common diff options that are not useful for format-patch (AFAIK), to ma=
ke the
documentation easier to read.

The third patch cleans up formatting of git commands and options.

Bj=C3=B6rn Gustavsson (3):
  format-patch: Make implementation and documentation agree
  format-patch documentation: Remove diff options that are not useful
  format-patch documentation: Fix formatting

 Documentation/diff-options.txt     |   54 ++++++++++++++++++++++------=
-------
 Documentation/git-format-patch.txt |   44 ++++++++++++++--------------
 builtin-log.c                      |   12 +++++++-
 t/t4014-format-patch.sh            |   18 ++++++++++++
 4 files changed, 85 insertions(+), 43 deletions(-)
