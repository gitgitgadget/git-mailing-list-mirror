From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Sequencer: Debating the UI
Date: Mon, 13 Jun 2011 20:53:54 +0530
Message-ID: <BANLkTinxx5qFuhwsUt3JeXOO7TjBj8wFvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 17:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW900-0000uX-R9
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 17:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab1FMPYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 11:24:16 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:54812 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1FMPYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 11:24:15 -0400
Received: by wwk4 with SMTP id 4so2696567wwk.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=OvAJjb+bDajwFMyKWr9m5FDQ0SH1pTCeOUyqkC3qvCY=;
        b=xm7VItTNMM3tSvqRVRzAUYlDZDxnVJHc/UeH+J+1tNIYQK41dVJz2sAvFgANmV7r/7
         Djh5DKA4DEe9PHsJkJt9pXg2GONDd6Mh2bbyIHRAf6iGn+PIeAsXbBPIfYrCy3gGcAaN
         +RuLZFcrFmtLwxUGMXboa/0VPlgw6EDeN7UiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=cHI7Db83JAV8LompZbvPFtzCZbMlxOLG6dEI7y9X/QrCpSfn+0SZJGM6YQebrAVcBL
         dyPrEFnflRg+I3Ve3YEncFuXTj+ZnkWsmuhJE24CJilrk9NOyb2vpDP+6fXUi6EYkgmk
         YZMxLKm8WmTF1it+Pkvi/539wGfz6oXd1Ovds=
Received: by 10.216.143.7 with SMTP id k7mr4930777wej.95.1307978654152; Mon,
 13 Jun 2011 08:24:14 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Mon, 13 Jun 2011 08:23:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175712>

Hi,

Frankly, I'm a little worried about not having sent out anything
significant since last week -- I've just been bouncing back and fourth
trying to decide how to structure the UI. After trying out various
forms of --abort, I've decided to drop all UI and just write
"infrastructure code" for the moment, and letting end users decide the
shortcuts for themselves.  Among the various suggestions, I especially
liked Jonathan's --edit solution where the user gets a copy of the
entire instruction sheet (not just commands left to execute) to edit
as she pleases [1].  I've just started working on this.  I might like
to send a quick series based on my earlier series for inclusion, but I
can't figure out a good subset: Everything until "revert: Catch
incompatible command-line options early" might be a candidate for a
simple revert-cleanup series, but most of the motivation for the
cleanup comes from the sequencer needing it.

Thanks for reading.

-- Ram

[1]: http://mid.gmane.org/20110611112213.GA25268@elie
