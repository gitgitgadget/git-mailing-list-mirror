From: Fyn Fynn <fynfynn@gmail.com>
Subject: Specifying excludesfile in a portable way?
Date: Wed, 23 Dec 2009 19:45:14 -0800
Message-ID: <1a04eebf0912231945l3235bc4dpdd8c541feef9bdd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 04:47:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNefX-0002lm-MY
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 04:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbZLXDpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 22:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbZLXDpQ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 22:45:16 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62714 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbZLXDpP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 22:45:15 -0500
Received: by yxe17 with SMTP id 17so7345795yxe.33
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 19:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=TXGxaNLndufN50A7+Emp6qe+x7OqxWwuZkKkuOvl6rk=;
        b=P5b8W9AWVhKOuJiPm++BfJ4b+Wbe8EeQxrzhsiS5jUN0i1OskFYElKkiQ+UDQI4wLO
         gumlHdQGtHgkzcfrCCiZv2S3bEw2DeM29YOuAdE1wk1CeTWGFHwQ2JtQWXAiG+oR/FLd
         h3uuUOTEjmKvGsBuVOGiBkAxmnlvTMwE0k7lU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bBx0qPbsxxqAmzkT9aAsLGwbqovZuCYcs9atkS4jT7x9UbfxJ8x38q6tna7Wl5+FB+
         E4A/17XSO27ikEIYklioyXpF5vbFX3C1iPVhveqatqnriro08CEBAvjOybGzQmUH1KKD
         Re3AJXJJE8BVyEQDRsiPXy3zxgaMn+ch8HoMk=
Received: by 10.101.178.20 with SMTP id f20mr10226479anp.67.1261626314662; 
	Wed, 23 Dec 2009 19:45:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135639>

I have specify an excludesfile in my ~/.gitconfig:

  [core]
      excludesfile = /Users/fynn/.gitexcludes

This works fine for my OS X workstation. But when I sync this
.gitconfig to our Linux server, the excludesfile is ignored because my
home directory there is /home/fynn.

Is there a way to specify that in a portable way?  I tried both
~/.gitexcludes and $HOME/.gitexcludes; neither worked on any platform.

git version on both platforms is 1.6.4

Thanks,
Fynn
