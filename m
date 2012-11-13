From: Tobias Preuss <tobias.preuss@googlemail.com>
Subject: =?UTF-8?Q?git=2Dgui_=2F_Warning=3A_=22No_newline_at_end_of_file=E2=80=9D?=
Date: Tue, 13 Nov 2012 21:26:53 +0100
Message-ID: <CADEaiE-J4nEwyK4WSiH=zzaH6cb85mw15O3wxrWrTXJtZfJixQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:27:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYN4z-0006XO-11
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 21:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797Ab2KMU1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 15:27:15 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49063 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788Ab2KMU1P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 15:27:15 -0500
Received: by mail-wi0-f172.google.com with SMTP id hj6so7133wib.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 12:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=J9iKO/ZAkPHRmk9UEtU3vx4XQoS1EphT546Fx5ZVQHY=;
        b=sxTUTYhEBtefIho/wPxOX/X7tReuwIaYPvC72DaqrA3mmTLS/DRJdIwWOj13Thmkuv
         X/GoX2bMdmTnKKfYJ9kadP021xcYV19I+EPcwmUGV37ApyoAWGIz2ReskM4tNuBuHBxD
         NgxakrOf4Dvb5Dv3QkkB+Ngd3F+tUCUMXgWhNwNz/V/J9LupOAuX4A8ZWo6/LRfsPjjH
         aMQhfp4CFR8bbeRMV8d2OU3CgIWWX3OroxqPSQ/kO2fQq9YAulept5nDas8ZFVh6Gi6x
         DpCNE/lCTkbFaPrmM7pHESpmWGmL+TjSj1B/d4SFS1WrcZDw7cI4aBPvr1ZRwcjLGhGl
         LErQ==
Received: by 10.216.210.165 with SMTP id u37mr470227weo.2.1352838433800; Tue,
 13 Nov 2012 12:27:13 -0800 (PST)
Received: by 10.216.29.73 with HTTP; Tue, 13 Nov 2012 12:26:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209668>

Hello.
I noticed a problem when working with git-gui which might be a bug.
The issue only affects you when you are visually trying to stage
changes line by line. Here are the steps to reproduce the problem:

1. Initialize a new repository.
2. Create a file with three lines of content each with the word
"Hello". Do not put a new line at the end of the file.
3. Add and commit the file.
4. Edit the same file putting words inbetween the three lines.
5. Open git-gui and try to stage the changes line by line.

The editor will append the warning "No newline at end of file=E2=80=9D =
to the
end of the diff. When you are trying to stage a line an error occurs.
The problem is also illustrated in a question on Stackoverflow [1].

Please let me know if you need more information or if I should send
this problem to some other mailing list.
Thank you, Tobias

____________
[1] http://stackoverflow.com/questions/13223868/how-to-stage-line-by-li=
ne-in-git-gui-although-no-newline-at-end-of-file-warnin
