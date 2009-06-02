From: John Tapsell <johnflux@gmail.com>
Subject: git checkout -b -t
Date: Tue, 2 Jun 2009 15:49:53 +0100
Message-ID: <43d8ce650906020749r36a0cceao20dc54d1446a6ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 16:50:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBVJT-0003IB-Pd
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 16:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbZFBOty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 10:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753783AbZFBOtx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 10:49:53 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:33061 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbZFBOtw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 10:49:52 -0400
Received: by qw-out-2122.google.com with SMTP id 5so5610047qwd.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=QZpW/qTlgJjG7oe9t6yONfL5T+UpTEitHd8+qpn9rGk=;
        b=izSx51HoKJ0z16QVpEOkQDv8rxLO6sihxHW7oWtaBCOx03KdBXOu+CX9hswOstEN8z
         OMcmFPjV14NZ94GsG/iEe3cb15m84EEO3R7Cw13kQEfIhPjxamPR/216JgA3SdqyuCUH
         VQ0msmoQEam8gtEusDyXtIGYlSxeN32YauVPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Jhrb7vaoQNKutVBH2utkVkXapmAfD3gCCsHz7hbqatZqEg0QvouPgVV13gLKrZP4VG
         MbP5OTnzCwYZyQAP6kBxUiXneRhts6S6cpjmKQsRRxz/RJ3PN4SOdlHN5Y3HVy0CeT7s
         SFGyhdeixCkeUQOpwsG+XwLC8n0sxZS3HYaiQ=
Received: by 10.151.125.1 with SMTP id c1mr14435743ybn.208.1243954193939; Tue, 
	02 Jun 2009 07:49:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120514>

Hey all,

  I've become the "guy to ask about git" in my company and people are
always getting into a mess with git.  So in turn I try to get git to
be a more friendly.  Today someone had a problem.  Basically they had
done:

$ git checkout -t origin/mybranch
fatal: git checkout: --track and --no-track require -b

So they do exactly what it tells them:
$ git checkout -b -t origin/mybranch
Switched to a new branch "-t"

doh

How can we make this less easy for people to shoot themselves in the
foot?  The behavior of -t has changed recently iirc, so I think that
problem has gone away?

Also:
$ git branch -D -t

Doesn't work.  I can see why, but it does make my life difficult :-D

John
