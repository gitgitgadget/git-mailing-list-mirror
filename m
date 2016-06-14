From: =?UTF-8?Q?Alex_Preng=C3=A8re?= <alexprengere@gmail.com>
Subject: compactionHeuristic=true is not used by interactive staging
Date: Tue, 14 Jun 2016 16:22:54 +0200
Message-ID: <CAEtHF9Na7yppEzuutp5=98KjLucgq=7Xv9GPidhaYEuC0oeqQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 16:23:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCpF9-00025Z-Bk
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 16:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbcFNOW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 10:22:57 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36387 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbcFNOW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 10:22:56 -0400
Received: by mail-wm0-f45.google.com with SMTP id n184so124211657wmn.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=h4x0FdwAFYOrdwmaVKrBtKP77DQiwcFvAit81GhOA7U=;
        b=fYODluxXgDM8AVRZwFWhttloE4kkAtGIpiwwdHiWWefDB3fhj0pNWWMaiR+WHwiRrE
         iKTaT0FtbOqYG3EjawoMMvHcW7fuWVYUXdDfLph4bpMKmeletab/zlKJQQCWpTmtM5Ju
         3AE3iMpbHaZ9iX0EafsK4/b3xy7puvfKkfsQhVWFQagZrqlL3O9/6/qFIkTasVO46kNI
         LkV4k8O5INsPtUN8YJtatSu+23hs87AwBYHRgUh9fAbC4ILCN9mrTs+Ic5VUzFClTmMU
         JJ68Jouvexn6D5nwYUXbnjEc1Wjy177zGTPSAiiE32SB0NLDe340e216FZJu9rwb+o94
         HVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h4x0FdwAFYOrdwmaVKrBtKP77DQiwcFvAit81GhOA7U=;
        b=NQPo8n3YE+K4XoAbrmLNdjzFiBd8UFjVHxAs36riixozgrkhVHEUdkkCmZZawsCeok
         WVeoNHzgWLEt6KweCRHDUkzUPKpul/Z4Zf0XkhAJaG7r6R5xuRHLZGQ8CQ1OE4Kbl+14
         rAlkd786U6cwmty2Ta8VFTr0D+CAxD7Ki0yX4Z1zuPu3Ew8G9C+Ott7oFDBRObkZaGAF
         cllVkpEhRPGnmHmsbrXTVawTPCHnwJB4idgXBmdJjTZQDndCVh5lmERzmRPkOi92CKcI
         cjxMARn+IqprXsm84mGUi7SgzjmMjd9M7J3FZGiSqK+HLCkPj6g9w3Q9zmPRswdAslCz
         1TJA==
X-Gm-Message-State: ALyK8tLMOhhjIsqMFasPppz/EQff9ce+JM2jlvgKyCrUI6ivMPQpLeu1jMfa07N1mJN8VlF35UZn620X1LhFfw==
X-Received: by 10.194.8.3 with SMTP id n3mr6504815wja.120.1465914174873; Tue,
 14 Jun 2016 07:22:54 -0700 (PDT)
Received: by 10.28.49.85 with HTTP; Tue, 14 Jun 2016 07:22:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297294>

Hello,
I just did a fresh clone of git from Github and installed the version
2.9.0 on Fedora 22.

I tried the new compactionHeuristic = true, which is awesome.
The only thing that struck me was that this option was not used when
doing an interactive staging, meaning `git diff` and `git add -p` will
format patches differently. Perhaps this is intended and there is a
way to force interactive staging to use specific diff options, but I
did not find it in the doc.

Thanks,
Alex
