From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Proposal: sharing .git/config
Date: Tue, 19 Feb 2013 14:55:23 +0530
Message-ID: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jSk-0000LB-82
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444Ab3BSJZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:25:45 -0500
Received: from mail-ia0-f177.google.com ([209.85.210.177]:37273 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758390Ab3BSJZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 04:25:44 -0500
Received: by mail-ia0-f177.google.com with SMTP id o25so1083153iad.8
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=/Om5TSnYvnK3TfWZgXiGqBbS/32EoQR0rDbV2zEl1nw=;
        b=emuEUgszWGtcxKJJwHDxv0tDxdpjXnm0Yi8VbIFPM49vUDGnmpLDZA2fhr+xd6kzGy
         xl8RooxUIy4Y8xrKlgYkJQ2Xhiw03r3wx6kOWirt3KfxYucSCF33gi5t/LgczyzicWDa
         B5jtVWX4xE05UzMB1+gV2eVjKMAOD3lY+kAsAOKzpQkWx55Tb84erNNcDz0Mf6r3kaQt
         MCE/atNx8smT6mn4N+UB3ISzGPrvFBDdMsoac1uTfQHcTHc8fR8AvtD3WM33PNPsoSdD
         +SkIY+Vj0Hh8rfX969Hd3qoOnXTA8oae6Xi0KeWjeecFAlCMzDAe+E4NFkKOs/078pDc
         PDLg==
X-Received: by 10.42.18.138 with SMTP id x10mr7264149ica.22.1361265943510;
 Tue, 19 Feb 2013 01:25:43 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 01:25:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216579>

Hi,

I have this itch where I want to share my remotes config between
machines.  In my fork, I should be able to specify where my upstream
sources are, so remotes get set up automatically when I clone.  There
are also other things in .git/config that would be nice to share, like
whether to do a --word-diff (why isn't it a configuration variable
yet?) on the repository.  The only problem is that I have no clue how
to implement this: I'm currently thinking a special remote ref?

Ram
