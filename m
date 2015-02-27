From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Subject: git add to ignore whitespaces, some day?
Date: Fri, 27 Feb 2015 01:09:30 +0100
Message-ID: <CAJ+F1CL_X7d3RayLmohU3tMi6w5juVFEwCEBUA_Nf-Z53bq+ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 01:09:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR8Uq-0002kk-5a
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 01:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbbB0AJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2015 19:09:32 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:41729 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbbB0AJb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2015 19:09:31 -0500
Received: by mail-oi0-f45.google.com with SMTP id i138so12863704oig.4
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=+RsHGcJeaRLgg/C8uAioafIJrcvGWQotYaGwFdgXKR4=;
        b=f020K6/wUMfHklC6J7h3gQwBo+6eIu76OSC07Cinfc68UYJH48g4rY4megT1HOb7xU
         eZWNm6v+/MV2SeyUYTnmIbyuIeWQJOW9i7yGpaMu5Lmh/pULaHQtBIjsfIKaCtGqEVyB
         HTrST+WRWNQTtl2O2ghp/WCVfNpPTxn+JTAlvQc1P4cQGKvKCJx7LYwB89+yzUnCurYb
         821nNIsYmbGoPSPgvMqqF+v6KVwur99fOc3iWZWPw2IECBMFdsONdzXOl4AzuSlvmHpO
         YINuA7yhj0wxOi4+BM+U3tIqzLHV5BNSR6juCKuniiIHqYW6tLZKG6rMh1cRuXmEEXfD
         9FNg==
X-Received: by 10.60.40.7 with SMTP id t7mr8316127oek.2.1424995770765; Thu, 26
 Feb 2015 16:09:30 -0800 (PST)
Received: by 10.76.11.1 with HTTP; Thu, 26 Feb 2015 16:09:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264484>

Hey,

It would be nice if git-add could be told to ignore whitespace
changes, wouldn't it?

According to SO, I am not the one to think so:
http://stackoverflow.com/questions/3515597/git-add-only-non-whitespace-=
changes

A change to add--interactive would be as simple as adding the diff -b
or -w option like:
my @diff =3D run_cmd_pipe("git", @diff_cmd, "-w", "--", $path);

But I wonder if this should be configured in a diff.ignorews or passed
as an argument to git add. Opinions?

--=20
Marc-Andr=C3=A9 Lureau
