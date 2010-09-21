From: Graeme Geldenhuys <graemeg.lists@gmail.com>
Subject: staging specific lines out of a hunk for a commit
Date: Tue, 21 Sep 2010 12:40:35 +0200
Message-ID: <AANLkTin4U78N_8LV8fCWuinNH9AFeOsRBjnvHM0qt2ZH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 12:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy0HC-00017C-V7
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 12:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab0IUKkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 06:40:37 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51884 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0IUKkg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 06:40:36 -0400
Received: by qwh6 with SMTP id 6so4115986qwh.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=O0ghfpsLRZ1cDCeQLSjB+ecPudabQ5YPYUekqN5tqIc=;
        b=M8Zq+uGe3dF0T7hqUJwD2h+6AZkxk1qZKMnFaDKtRz489Jup9Iy/qoo4o39rSLd7Bh
         eEOBKeR4g+dezM1tkGvCSZVSafP/5ODQpM627968MCQ2VQdaL86IqpVjDuPr6LhvY05O
         ehovOJgjxJB6XyP6EsRzNHQbA6bXQUtlaEyPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=gdrqc0fY32CY/+TgycStNwdts9AP3SVyrk43ZL3YTy0EyvmP8XbSNK9Hcom6fCYAXf
         M4Bl4dNnWYmxei4J9+ibU1ZUHyKlHV50660UJom50+6Z/x682T5OOxKhsAAd3x29tXfh
         /cVegYdMfaAkq3oYFvUVemOOIGHFI4Anvby1U=
Received: by 10.224.6.145 with SMTP id 17mr6831605qaz.130.1285065635594; Tue,
 21 Sep 2010 03:40:35 -0700 (PDT)
Received: by 10.229.212.129 with HTTP; Tue, 21 Sep 2010 03:40:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156707>

Hi,

I know 'git gui' has this cool feature where you can stage one line at
a time. This is really handy, but also very annoying, if you have a
large piece of code you want to commit.

eg: I have a single hunk, which can't be split into smaller hunks
because it is all new code. But that hunk fixes a few bugs, or
introduces a few new features.

Is there a way to use 'git add -i' or 'git add -p' or 'git gui' and
tell it to add for example lines 5-20 of the hunk to the index?
Currently with 'git gui', I have to right click and select 'Stage line
for commit' 15+ times! :-(

Maybe 'gui gui' can be enhance (don't know if development work is
continuing on gui gui') to use the same feature as in the "unstaged
changes" area of the UI. There you can simply click the icon next to
the file name to add that file. Maybe the same could be implemented to
the "diff" area of the UI. Simply click the first column in the diff
area (where the '+' or '-' or ' ' appears), to add those lines to the
index. This will make adding or removing line to/from a commit so much
quicker and easier than the popup menu.

I'm using git-gui 0.12.0.64 and git version 1.7.0.4.

--=20
Regards,
=C2=A0 - Graeme -


_______________________________________________
fpGUI - a cross-platform Free Pascal GUI toolkit
http://opensoft.homeip.net:8080/fpgui/
