From: "David Frech" <nimblemachines@gmail.com>
Subject: importing from svn to git:one repo or several?
Date: Mon, 2 Jul 2007 13:15:05 -0700
Message-ID: <7154c5c60707021315p39e40269v4a0a3152ea0a773d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 22:15:15 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5SIj-00089p-3q
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 22:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbXGBUPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 16:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbXGBUPI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 16:15:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:45467 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbXGBUPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 16:15:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2471113wah
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 13:15:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IT+u26AjhgMaGFh0tPU6WnDULhxZvET5+MfU5osuqSCoiFUpblvYksiIityG3Ovzy3IMVqFtF54kcy7YDLjyOEX+7meN8Pn1oyXR+VPdOdlE5tCzywdtKcgoysLcNW9eaaOOqAyjtlLBuld1/1frheuc81dhXMpa8NpsWPOEvO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DzF0tlHw5GRj7C7sNa7JwHbFtkjmifeeUq3DcO2fbU7hKDDaAJLBFzfUhoWVLxCX6Yljhgldddgzv7UoTqfNZOpPFX0iasLmuqDUrUpbJR0/o1u7PhJ6Phm9IRoBFR7sEvHlF7ujt42W0CjvUWcFnmpoWh54hirvIdpGhYwFDg4=
Received: by 10.115.77.1 with SMTP id e1mr5428021wal.1183407305976;
        Mon, 02 Jul 2007 13:15:05 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Mon, 2 Jul 2007 13:15:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51399>

I have an svn repo with several projects in it that I want to move to git.

Does it make more sense to import it into _one_ git repo (each project
as a branch) and then push/pull/copy each branch into its own git
repo, or to do the import several times, filtering the paths from svn,
and generating a _separate_ git repo each time?

Cheers,

- David

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
