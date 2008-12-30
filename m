From: "Ping Yin" <pkufranky@gmail.com>
Subject: why still no empty directory support in git
Date: Tue, 30 Dec 2008 11:42:26 +0800
Message-ID: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 04:43:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHVWH-0006Wm-AT
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 04:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYL3Dm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 22:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbYL3Dm2
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 22:42:28 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:21144 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYL3Dm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 22:42:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2519764wah.21
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 19:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=f4SMfo5N1nEZCUqUMjydVs72xA4GNLXPknQymSheFxc=;
        b=EnRIcK4dkNpui56l3vp1qkP3g6zYxdqjVW6sz/eq2U5XhpbSmlZyBV+xLCGMOlVuGj
         Mn+jY760LNk7Ek8lDt3jB7vhtLLt8Bb4VdRmSzB6k0zbn1ok9yN89vOuanjSfEL7lf4k
         8pl3mWIJsLYGJYl17xUmmw7OKrkyKQdJqLilo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=me9taF9Sxzzl5YiFAzjxfJ+xyhzaP7B9mszDtO+I5IhMDclsTN4lqP90/dEmhNm2h0
         csp1SaOl/iSe/KCJvNvF45XM7pfI2Yl0NJd7PXe8G8h69hyps4Iy5o6e9kwBpLZWBMeU
         aHkNEwyDouBPSfEeN/fcS24gyyO2E56oReXEo=
Received: by 10.114.108.8 with SMTP id g8mr9451464wac.103.1230608546747;
        Mon, 29 Dec 2008 19:42:26 -0800 (PST)
Received: by 10.115.93.12 with HTTP; Mon, 29 Dec 2008 19:42:26 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104149>

Yes, i know this topic has been discussed for many times. However, i
am still not clear about the real reason.

So which is the reason?

1. it's by design, intentional
2. unclear logic, for example, whether to remove the directory after
the last file in it is deleted
3. hard work, no one has picked it yet
4. hardly done in current model

Ping Yin
