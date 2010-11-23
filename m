From: =?ISO-8859-1?Q?Tarek_Ziad=E9?= <ziade.tarek@gmail.com>
Subject: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 13:23:17 +0100
Message-ID: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 13:23:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKruG-0001Jd-3g
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 13:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab0KWMXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 07:23:20 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40465 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab0KWMXT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 07:23:19 -0500
Received: by bwz15 with SMTP id 15so7030118bwz.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=E8NGUUZVtFteVwxf93sUaFjnQEqThPWPZEhZ1aYqA3c=;
        b=A28tj72LNbJ7vB6aiJu3TTQEx3dbR6r5Gs4OqMBMQrLF3xgsnB+ZFNfK8hLH4lp8pT
         wTkyexokIFDadT6UUiUnfUEtkw62XXQo5TV9C6RHbGOJI5263T8EHPKAOR2fx8EhuHM0
         42HG+shkYjPCvKIe3F1jlE0rPbq3U+P3zU5Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=l7OzD+7ZKxvTLVbwYX5Kn8hMRSdjsKkbvPk1HEDeVgo0UybdoMDdcxZ4rBu3vZMcEO
         1XYA12I/F7fMRQ1+QXce4dKBSe5FlEHvo4ke2cV4enWc3QUu7aLTcTnOpeS1McKAUJSg
         T3BesFBw3ckArmuvYnCYmVoiKWLbbgcr3mIfs=
Received: by 10.204.52.136 with SMTP id i8mr6503653bkg.96.1290514997344; Tue,
 23 Nov 2010 04:23:17 -0800 (PST)
Received: by 10.204.54.207 with HTTP; Tue, 23 Nov 2010 04:23:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161947>

Hello,

I am new to Git and I tried to run "git st"

I have found one small bug: "status" is not listed in the help screen
Git displays in that case.

$ git st
git: 'st' is not a git command. See 'git --help'.

Did you mean one of these?
	reset
	stage
	stash


I also have a suggestion: I was looking for the way to report that bug
by visiting http://git-scm.com/ and looking for the bug tracker.
Someone eventually explained to me on the IRC channel that I had to
post a mail here. I would suggest making it clear on how to report
bugs on the project's website. Maybe under  "Got a question" /
"Email".

Cheers
Tarek

--=20
Tarek Ziad=E9 | http://ziade.org
