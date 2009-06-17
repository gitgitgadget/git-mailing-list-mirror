From: John Tapsell <johnflux@gmail.com>
Subject: Re: git rebase --interactive squash/squish/fold/rollup
Date: Wed, 17 Jun 2009 13:55:26 +0100
Message-ID: <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 14:55:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGufw-0006lS-RA
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 14:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758916AbZFQMzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 08:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758274AbZFQMzY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 08:55:24 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:54459 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587AbZFQMzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 08:55:24 -0400
Received: by gxk10 with SMTP id 10so441026gxk.13
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nHauNHb4281Lc2rENNQnfoq+UKWjXp3CxOEIo6KLROM=;
        b=cmibCEs81zLjQ3tYCvjgF1MQawML23C3YCbmztfR8z8qe1Lof81mcDyAWMH+sKvIL/
         lW2NDdE1AaEbzLjjWd4il304bkc6ckx61Z1KfqpEBI6u3zZKFALltkQYbkNERYn1Al8+
         4zuvt3/7xPU+jF3vsxkwByivDiVery7zDyUQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=kOYiJB9dARqLY+iZbpW2AjFEByPhJg04ux0t31wiNQSgYC3B9qYDauhsJ7neCSNKdn
         LZuUN5Q3ToqODvN2GeiJL7+flaopUeaBTt8g4CKMeizTZQPTnRje8px6kbgwSl+pe/vo
         jgsTAdEuTIuy02WAUhn2Tf9U4yozfsyvA/SjI=
Received: by 10.150.149.17 with SMTP id w17mr1117193ybd.303.1245243326388; 
	Wed, 17 Jun 2009 05:55:26 -0700 (PDT)
In-Reply-To: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121740>

> branch, hack, commit.
> hack, commit, hack, commit

What if you used  commit --append  instead?

The trouble though of squashing all the commits into one is that it
makes it impossible to bisect later.  Are you really sure that your
final commit cannot be broken into small commits?  Ideally each commit
is small but self contained.  Squashing should be done only to fix
cases where you introduced a bug then fixed it, or to fix a partial
implementation etc.

John
