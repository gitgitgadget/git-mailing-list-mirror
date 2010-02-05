From: Timur Tabi <timur@freescale.com>
Subject: How can I tell if a file has been updated upstream?
Date: Fri, 5 Feb 2010 10:23:11 -0600
Message-ID: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 17:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdR3V-00071X-2N
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 17:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896Ab0BEQ3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 11:29:11 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:42373 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521Ab0BEQ3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 11:29:10 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2010 11:29:10 EST
Received: by fxm3 with SMTP id 3so4187213fxm.39
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=9E118jBH7Vk0PKhVtiPa2LhmfDQ7VBzybf0Q867JHd8=;
        b=jN0xpGnmS4Fndgm233DBegRakzPGyyXKFBlkEEorSLRYHpoiXQid4NryiLHo7P5Wir
         rdENfYdL6EZpMeSYeWps0ZoaHAwdHGtZZwQk3Ht0umdGOmMrB+uhwLXAYCRA/yApMTfW
         tWvgYt2CmUMIi2RiZtRlbDuuDU0zcy4uGs1QE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=tFeymyYR9veLOuvkiamLMVA8cgSK8eynRvgZhSIBfpeVZjX2kOUvDQ0reUenAfkJPc
         F+eDAd6uWm9kPYPHe5E/rwZzzn6Bmw74neI+IrQ2S6uJkDXMhxC3m7csyne0VMS5yp7K
         Bl4c/o2A++2Dgu8y9PE7qdipXZBEFKeZd6MUE=
Received: by 10.239.193.77 with SMTP id h13mr293122hbi.74.1265387011456; Fri, 
	05 Feb 2010 08:23:31 -0800 (PST)
X-Google-Sender-Auth: f459efb22e0e3292
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139055>

Is there a way for me to tell if a particular file in my repository
has an update in the upstream repository?  For example, the SHA of the
HEAD is different in the remote repository than it is of the HEAD in
the local repository.

The reason I ask is that I have a set of Python scripts that I
distribute via git (other people in the company clone my repository).
I want my script, every time it's run, to check if an update is
available, and ask the user to do "git pull".

-- 
Timur Tabi
Linux kernel developer at Freescale
