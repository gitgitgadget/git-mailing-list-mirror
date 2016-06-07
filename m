From: Eric Frederich <eric.frederich@gmail.com>
Subject: [BUG] gitk
Date: Tue, 7 Jun 2016 15:20:36 -0400
Message-ID: <CAAoZyYNnWk-yE9TG_Fpxxs-oRN-yEsm_YFs+Ej7muQ+5YCW43w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:25:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAMYN-00072t-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 21:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbcFGTUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 15:20:39 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33020 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcFGTUi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 15:20:38 -0400
Received: by mail-vk0-f46.google.com with SMTP id d64so133088549vkb.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=d+dbooaG8VI7mzOazkDJWkHrXDdLSxG/oSq3HQs/OD8=;
        b=bERUIJXkIUJxsZuZk/qaloBtt1dm5Rc/fK7vaQVrn2halTJ8xY9I+2SBCaWK8yPx4g
         v34Jnk1fLLKDkvxMvnD2+kImtDgpiX7GnOS0sTK6965HWjoniCJC9EFhkrsHQSIPdn2R
         ER9/Exg5AZGvwD7xqvG5y6J0JF1D/L3o4QvFUG1VVtMkY4/X4FfyZHw39qoHfkurFwLi
         XJ9t6JwgEtl/T8XhlldE8yFpeJU1TnlAXODCMRB7ZbkqCFdZB5F1pjuvK7Q6ABo9MdKA
         SQkDSZwE88kkMEjJ5lG+5S0K2xEM5+d1AHt97b+b8JZzTysV4n6UBzvy1DlFNSMaRHJH
         jgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=d+dbooaG8VI7mzOazkDJWkHrXDdLSxG/oSq3HQs/OD8=;
        b=hLMx8D9wvuvJ/vD8YV/ZdU2vzCVlgrehb2XGDy5YZPiUvM0SOtieiPR71uMvpNmWug
         4cBC4v0683SYyiRt0ObLARfpEadr4yXoWo6eiBsuYI0aM9ImwlgpeBsTFWfTaniwYshK
         RZzCFuBYPwknQntJesZiNZk03KMoLIOr5sn1k4d24HXS8ukfXCi9u39r0cE9yQq4a3tz
         /jdqig5Z+qMA99CpunOzolqQmvmnVZ6v4klLZg4mEK1DMAmnQn8U8ecvZBB4+D5P+5Ir
         y6/VtJ1lxnELz9wLEMseO/kIwnjU5UR2eTKhhNNUxAOnR1sBdBc5WeB3I6npU9pKy6V7
         7/Xw==
X-Gm-Message-State: ALyK8tJsmnZP5zkdelvAmTdvEsjzrQcQg5JBNhYywnMR5O2sUncP+3FQY/jffA3A+3u1lh5dbTTmAciq6T96tQ==
X-Received: by 10.159.38.108 with SMTP id 99mr537465uag.27.1465327237068; Tue,
 07 Jun 2016 12:20:37 -0700 (PDT)
Received: by 10.159.37.230 with HTTP; Tue, 7 Jun 2016 12:20:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296710>

Hello,

I couldn=E2=80=99t find any documentation on submitting patches for git=
k.
I saw in Documentation/SubmittingPatches that gitk is maintained in
its own repo.
I can=E2=80=99t clone repo=E2=80=99s unless they=E2=80=99re http while =
on my corporate proxy.
I=E2=80=99m hoping someone can help me out or just do it for me ;-)
I=E2=80=99d like to revert 66db14c94c95f911f55575c7fdf74c026443d482.

That commit just renamed =E2=80=9Cgreen=E2=80=9D to =E2=80=9Clime=E2=80=
=9D
It causes gitk to not start up on when ran through VNC.
It works fine on that same system natively or over X11 forwarding but n=
ot VNC.
It also seems from the following link/quote improper to use =E2=80=9Cli=
me=E2=80=9D anyway.

=46rom http://www.tkdocs.com/tutorial/fonts.html .. quote:
    Tk recognizes the set of color names defined by X11;
    normally these are not used, except for very common
    ones such as "red", "black", etc.

Thanks,
~Eric
