From: Claire Fousse <claire.fousse@gmail.com>
Subject: Gate between git and mediawiki : remote-helpers
Date: Sun, 22 May 2011 17:50:54 +0200
Message-ID: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	"matthieu.moy" <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 17:51:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOAvk-0006Dw-Ky
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 17:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1EVPu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 11:50:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55687 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab1EVPuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 11:50:55 -0400
Received: by pzk9 with SMTP id 9so2294793pzk.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=SZ+T86NZWAvm72agwdKuaik7a0EBhGIDYDzr6x8viv4=;
        b=kLOlwhKThorSARMk0WDttiB7WXSJb624pLRfQGY0Im1TbpOD5c9l0VSBiF4UDq8573
         ssXt8OfWE+QUbjX3OUGuDF64szaE/mhsRN2GrRiE074Jm0mVcbq854Xi1btbk1ylDZVF
         UOW9wSqRrfQU4WZP4BlFFixOB15m9opCJ/4IY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=bp9TMuk/BVTh7e3hjrbNn5SXxIWHtA3ZLHqp6HKugzrwcj5a4Fa/H3L0QZm/aqDrKX
         Xdh0ZTfjF9l8SMPNmGtKMbE3PCVl3coX3NKiuu+3igLTB+AVYzrRBD048ZsvItoKe+qQ
         cDN0Cx44qAR9eBdvgRpU6L61UISnrVWd2dHwg=
Received: by 10.143.78.6 with SMTP id f6mr238847wfl.28.1306079454583; Sun, 22
 May 2011 08:50:54 -0700 (PDT)
Received: by 10.143.155.9 with HTTP; Sun, 22 May 2011 08:50:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174191>

Hi,

I'm a member of the team trying to establish a gate between mediawiki
powered wiki and git.

We've tried several things which seems to work. However, it is
something like git-svn and would require some commands such as git-mw
to work. Is it recommended to use remote-helpers instead of that ?

There is one problem though : nobody wants to git clone the whole
Wikipedia for instance. And we should add a functionality which allows
the user to clone only a part of a wiki. Are partial clonings doable
with remote helpers ?

Thank you for your help,

Best Regards


--
Claire Fousse
