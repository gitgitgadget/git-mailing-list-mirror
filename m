From: Victor Grishchenko <victor.grishchenko@gmail.com>
Subject: Git and Linux tarball size evolution
Date: Fri, 9 Apr 2010 18:33:13 +0200
Message-ID: <r2l1454bf6f1004090933g4e58277dh51c731ca6b097a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 09 18:33:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0H8z-0007BI-0T
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 18:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab0DIQdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 12:33:16 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:36985 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab0DIQdP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 12:33:15 -0400
Received: by ewy20 with SMTP id 20so1376533ewy.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=P9swZsO9WOpWLXWAtp6lMtgorIqu/+NKGGRery2GWl0=;
        b=DUMY/TpDxVxPtVzByvykPEtmr2vTgzyG8gMZxHMGAMyKNRH+0cPZjrvZuVTSAcFdzO
         Dnt11Zh8+QSlaT/ChgIMzt9YU+O2D8/3uaKUlUkfDgZCdunTj4CRmJeWYKmu1I7SIuYZ
         OeI2BazBIIzbBBo8LEjnxJjq9XgFnk2PWj6Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=YJVh9TgQVLGbcH8ri65UZ7HpCuKIi2FIy3eMOXoDzE7QuAZRjCV4n0Mch0Agla12Oe
         k0VrsyUa14CbS+jZxMPaXvI/aFgEGZdbdvZBra+dXLvQTIJjcZzpUgkdCDRcKRQA140r
         YTBciqoSRGbUvKBQQ0Rb9cq89Wb0cUxTxfs64=
Received: by 10.213.2.193 with HTTP; Fri, 9 Apr 2010 09:33:13 -0700 (PDT)
Received: by 10.213.44.71 with SMTP id z7mr148373ebe.53.1270830793370; Fri, 09 
	Apr 2010 09:33:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144452>

http://bouillon.math.usu.ru/files/linux-tarball-evol.png

I plotted sizes of official linux kernel tarballs found at
ftp://ftp.kernel.org against their dates. (Yep, the methodology is
extremely dirty.)
Long story short: the normal dynamics of Linux development is
accelerated growth. Apparently, in the end of 2002, development hits
some limit, probably a scalability problem. It returns to the
accelerated mode in mid-2005, which event coincides with the
introduction of git (pointed by the arrow).
Speculation: indeed, the git lets development scale.

It is clear that git has changed the release pattern. But was it the
reason why the development (and tarball size) returned to accelerated
growth? Another possible interpretation is that 2.5->2.6 stage
involved too much of reengineering, so "normal" incremental
development slowed down for a while.
Do git developers have any opinion on that?
Thanks!

-- 
Victor
