From: Jiang Xin <worldhello.net@gmail.com>
Subject: redundant message in builtin/rm.c
Date: Fri, 26 Jul 2013 10:37:56 +0800
Message-ID: <CANYiYbGQj6mCDraxiBHXEL+qd7OwnFCaMpB3Wb4_Pg=-p+KJAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"'Git List" <git@vger.kernel.org>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 26 04:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Xus-0007WJ-Dg
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 04:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757043Ab3GZCh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 22:37:58 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38446 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab3GZCh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 22:37:58 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so294523wiv.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 19:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=kb1r0PA5nQfDIqXNZn4vv6N9XU5bc07Th5vEe1eyokc=;
        b=XdwZctPISHdTlRx5egxPOzDLxQmsP19SBLYyQy+TAGIc1hf0YCo2Ss3QyFDxZE8ab6
         SJjxeyUz2XOhSQstRZpdTHi1ejMtJjlGyF96VYpcXc0Gr3pQ5lQRk1v7NtHp8jy63miz
         p2VGcBPzdLOLsL48bymggFcQ2ilqtYw+8l4pakdDjS9g3+muuF1+fXGOKiy+tfsS91la
         M1XTfftuet2y4djV3DkvqBqur7iE3OAzj7GyVcKu6/exMZjOssH7YxV4JD8Cf5F1Bhg8
         snSfTNpAuqu1logcxrwEfcM8U4JCbNl7UA1vYCmJmwPCzlwpi1f/DycweImMptibejEe
         5+oQ==
X-Received: by 10.194.249.129 with SMTP id yu1mr33297708wjc.10.1374806276820;
 Thu, 25 Jul 2013 19:37:56 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Thu, 25 Jul 2013 19:37:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231160>

Hi,

Commit v1.8.3-1-g914dc02 (rm: better error message on failure for
multiple files)
introduced many messages need to be translated. I found two similar messages
each has a slight typo, and the differences cause redundant works for
l10n translators.

        # builtin/rm.c, line: 90

                          Q_("the following submodule (or one of its nested "
                             "submodules)\n uses a .git directory:",
                             "the following submodules (or one of its nested "
                             "submodules)\n use a .git directory:",

                         ( no space before "use(s) a .git directory" ?)

        # builtin/rm.c, line: 240

                          Q_("the following submodule (or one of its nested "
                             "submodule)\nuses a .git directory:",
                             "the following submodules (or one of its nested "
                             "submodule)\nuse a .git directory:",

                         ( "nested submodule" should be "nested submodules" ?)

-- 
Jiang Xin
