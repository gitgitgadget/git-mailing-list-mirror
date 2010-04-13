From: Aghiles <aghilesk@gmail.com>
Subject: git log of remote repositories.
Date: Tue, 13 Apr 2010 19:25:17 -0400
Message-ID: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 01:25:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1pUH-00051w-Js
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 01:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab0DMXZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 19:25:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51116 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab0DMXZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 19:25:39 -0400
Received: by wyf19 with SMTP id 19so477454wyf.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=ZcJq9/cIZuzffVmDIzHQfHIS4q7C525GxxrglrJIoac=;
        b=x8ZR1MggTjf1oXcJGeXIWU0xkm9f6EIzvzd40wIjbS7Km2m/c/7gx6RzLVHtYjXjEv
         c/vwGTHurcj51hI4nH6rz3ZpoEDMTztzyg1/nHZVcACV+oIqOyDtn0LoAQm6/sXD8prV
         wxdvUSvV1KOMXBpnf3pkPCAdjMgTbxvNbYxeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=G4pohqNjf2Savs6Vs5BqYkD9K8T+hBQDcNiUNUKhDdl1TTpp0k6SOTJoF034MN8c8o
         48aWpc+e1zTcoDQsDFf/uMADZUni9f+jD2KN3v0XCo19dKrno9t5DI1wSWx/k9K0iE3M
         /glcO7x9GJJQKrc+AlrMGQ/GILAx9rKstXvDw=
Received: by 10.216.157.212 with HTTP; Tue, 13 Apr 2010 16:25:17 -0700 (PDT)
Received: by 10.216.162.212 with SMTP id y62mr4307772wek.109.1271201137141; 
	Tue, 13 Apr 2010 16:25:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144837>

Hello,

I have a local branch that is a tracking a remote branch. I want to see
what are the modifications upstream, _before_ I pull. I tried
'git log origin' but that's only the point from where I pulled last.

Is there a way to do that?

I see a --remote option in recent git versions, does it have something
to do with I want to achieve?

Thank you,

  -- aghiles
