From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: How to Push a range of commits.
Date: Wed, 30 Jun 2010 11:21:01 +0530
Message-ID: <AANLkTikOffJHjzd3iBOXm7Lt7uPzHGkR1kfWtxSd-F9S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 07:51:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTqCX-0001Gh-Ay
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 07:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab0F3FvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 01:51:07 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44292 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab0F3FvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 01:51:05 -0400
Received: by gyd12 with SMTP id 12so219900gyd.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 22:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=56m9lEo6fhHd54/zTh3mPoqYZnwAmK4B4nzxKES+yTU=;
        b=YXOyCm6kIrDO+jJA1Wkhc9MTGm1aASHAl21Pga1ICa6yqcoMAoWAdLoVPf1UzvTYgM
         0XSRd8T2BdKguQfpFEKuAUDsGBzlEtg+DE2/GaW61UxUgz5qu2f3GeI+HsuT4gbebn8/
         G8vEnT7xMNtjdnxsF9CAs3Szszvm5yAHMS6+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=szLl08vpp6dAhe5oYIT0Zo9FhPSbUvoMsnEGq8dnKrwkxZsLf0VtK8SUYwmWfJEA1y
         cCw7O7OoWnGf9ftWz65qd0BBjP9PRpaBN3OhTqAtr77HhXrODXQx1PHkNuMuGQIO9tih
         sxLGEfDxcCAuAz1THW/0Ic1sQzbuhM9CVgyBE=
Received: by 10.91.63.32 with SMTP id q32mr6390110agk.60.1277877061868; Tue, 
	29 Jun 2010 22:51:01 -0700 (PDT)
Received: by 10.90.100.4 with HTTP; Tue, 29 Jun 2010 22:51:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149945>

On branch 'foobar' I have a range of contiguous  commits  say C1...C9,
C1 being at HEAD / TOP.

If I push branch all 9 commits will make it to authoritative
repository.  Is there a way to push a single commit (as C9 or C10 new
commit) which is common change set between C1 .. C9

-- 
Thank You
-Mahesh,
