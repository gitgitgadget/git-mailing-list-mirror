From: Marc Bejarano <beej@beej.org>
Subject: git diffstat feature suggestion
Date: Sat, 11 Sep 2010 13:35:01 -0700
Message-ID: <AANLkTimr6MByE=jnKAjku1Hbcm66giHMLNz6TVxxkYkq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 11 22:35:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuWnO-00006k-Av
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 22:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab0IKUfD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 16:35:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58660 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab0IKUfC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Sep 2010 16:35:02 -0400
Received: by iwn5 with SMTP id 5so3540100iwn.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=qP5bSXGbsobMlCWxgoDZXdU9DGyQcStc04DY+LqaVZY=;
        b=sf9kbiBxhpBrgWqv0tpVX3olqUgi0aVgAcRvl9EqH6CeLQZTtCemLboB6gYuXUzhZm
         VJHr5JcDntpDuL7Uv7I7weYzQ7fBPPibUzuqKomXxsR8rVeFGUX4ybj8AlKX1ipuvpko
         lv28QqKtenf5GYD0iXkD4O8eJSKnnyuZ+29jM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=IZNfRzP6h/N660IIr3vyXTq5Oe9YNo5NOK+qQsyuxoL2qlq7Bl3MzMkX32DRJaDtkd
         7hd1G4n00Oaf05QqkIN7Tpcd3aDG5AUOeEszqbO2dAhuGBXx3IuNvIuCSTF0aPeEBUvF
         CV1hnuIoc8w2QeZjWaMpAYsJAteKyTpKjIrsw=
Received: by 10.231.169.210 with SMTP id a18mr3465323ibz.5.1284237301470; Sat,
 11 Sep 2010 13:35:01 -0700 (PDT)
Received: by 10.231.144.3 with HTTP; Sat, 11 Sep 2010 13:35:01 -0700 (PDT)
X-Google-Sender-Auth: zTj6phAKqiZPsLxJD8DG8Qca2AI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156011>

hi.

i find the diffstats that get posted to development mailing lists from
people using (i'm guessing) quilt to be great.=A0 one improvement that
comes to mind would be some sort of option that just tallies changes
in actual lines of code, ignoring whitespace and comments.

i couldn't find an issue tracker for git so that this could be tracked
properly.=A0 is there one?

cheers,
marc
