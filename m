From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Has anyone looked at Gettext support for Git itself?
Date: Sat, 15 May 2010 22:10:09 +0000
Message-ID: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 16 00:10:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODPYq-0005PD-Op
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 00:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366Ab0EOWKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 18:10:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48189 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab0EOWKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 18:10:11 -0400
Received: by fxm6 with SMTP id 6so2594987fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=cCdnSFjPiU36FxpKWVW/TbECyCTZ4rUwTpUMPivi5bw=;
        b=n3zATBiM2iUyxq0fTV+Q0uFSHr63c/HKC5NJWPu+xeR0nXFPL2QDOyYWacblCEv/UV
         yOC6Y6XTTIwnFLxCSbx5blyeR64jcfRMYHvShzZGYaA4EO/wHDkfRr6vKh9BBK2hYLRo
         GgdTWgbwxa9R/SNWe09HSdx1dZsbhqGZ40te4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=umN4AS8dhtZu4tj3bkPfBlYQk1VXr5V6CkeyCnqIntT5cdKdvAQVlfnF4aTq32wmTH
         PHRYS+IUMgd7L9ZV9nkHDWQgJZ3xbiu3B6ro55Te9rqAvqivBK57C7VGZbMDpM1sgvF4
         IomeQmsOymkUpsgJ0/ZknAjNgB5wPeuOcgVt4=
Received: by 10.223.144.84 with SMTP id y20mr3789516fau.78.1273961409984; Sat, 
	15 May 2010 15:10:09 -0700 (PDT)
Received: by 10.223.109.78 with HTTP; Sat, 15 May 2010 15:10:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147166>

I couldn't find anything about this in the list archives. Have there
been any discussions of adding internationalization support to Git
itself? I.e. the interface messages that the core Git utilities emit.

I tried to get started with integrating GNU Gettext, but gnuish
assumptions it makes about building make it a bit hard.

Is there perhaps another gettext implementation that would be more
suitable for Git?

I'd be interested in submitting patches to make the existing strings
translatable if someone could get the tool + build skeleton going.
