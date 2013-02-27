From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: ESR's reposurgeon action stamps
Date: Wed, 27 Feb 2013 15:13:54 -0500
Message-ID: <CAFUtaNFUQ=kF6pktLh9wYx6Nm=c0W-YhX8vpn4SeQ+xOms0UHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Eric S. Raymond" <esr@thyrsus.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 21:14:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAnOP-0004rR-I2
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 21:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab3B0UN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2013 15:13:56 -0500
Received: from mail-we0-f176.google.com ([74.125.82.176]:36032 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab3B0UNz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2013 15:13:55 -0500
Received: by mail-we0-f176.google.com with SMTP id s43so831753wey.7
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Cvo4l9w8BWTuHE9TrM9Paes7wW0nplphUVGK081xO4Y=;
        b=RbsFUSGRJSG6E6eezfm6hir9D1egdb/h8zZQhWFXV1HkJq3CInmxwmE420vrY6q3qm
         FPjatKmKiUYx8AhUwORa8m0LOuTR3CNV7ayyOiEsGUR0iyMnjgWz7CXJ25f8SJxS85mb
         UZPt3QY483OZQhxHKb7JuwrHU4/Rul6SzJqwj+GLnbw8goXRGLbHGKvM7pUMG0DOUM6M
         aslgJVs1x6/WoEhGkmDu6gNfpaHOFnZiagHGyyiZJEBWAgejnppLRywVEqGhqi8P/UPM
         p/4tB8v8zmX1x0HXk2QVkI1zYnrBun+yx029XDxAJjo6L92gYtf3GUy5hxXBKBNaTzER
         M7JQ==
X-Received: by 10.180.75.143 with SMTP id c15mr6305435wiw.18.1361996034384;
 Wed, 27 Feb 2013 12:13:54 -0800 (PST)
Received: by 10.194.18.132 with HTTP; Wed, 27 Feb 2013 12:13:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217221>

Since it's intended as a cross-VCS tool, Eric Raymond=E2=80=99s reposur=
geon
does not use hashes to refer to commits, but instead uses =E2=80=9Cacti=
on
stamps=E2=80=9D. From <http://www.catb.org/~esr/reposurgeon/reposurgeon=
=2Ehtml#reference-lifting>:

> An action stamp is an RFC3339 timestamp, followed by a '!', followed
> by a committer email address, followed by ':' and a 1-origin sequence
> number if the date/time pair is not unique in the repository; it
> refers to a commit without being VCS-specific. Thus, instead of
> "commit 304a53c2" or "r2355", "2011-10-25T15:11:09Z!fred@foonly.com".

Would there be any interest at all in extending the various Git
utilities to understand this style of reference?

=E2=80=94Joel Salomon
