From: Vitaliy Semochkin <vitaliy.se@gmail.com>
Subject: history missing
Date: Tue, 26 Oct 2010 23:47:39 +0400
Message-ID: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 26 21:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PApUn-0007hx-Nw
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 21:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab0JZTrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 15:47:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38195 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab0JZTrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 15:47:39 -0400
Received: by yxt33 with SMTP id 33so76527yxt.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Ob+RmzPoKF47Wh9cLCcOkAehZuOBE2p/vFKMRCriFuw=;
        b=sNf3njVUv4urOWGMNrxnJYfjRuxKm9t9k/Fk0p1fLMda1OwXsWasdVNqKqP2maVpan
         zeRqQ5sQ4Rj5Sufflw9YUjbyMx3rlQlA1pEgU1X1TNA5WqiGO9S3+eBqRqys9UhoVgZz
         P2ME9miu7M8aKjB3ldN5z0tobYthPjs+b+USs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=uqxI4E/ykuWZQRce3ixMfXYtbT2xW/iZzq+B26BToPtSA5DwloBbPwzPM2xPQ9sbB8
         NiXDt53J+skwaXM6pJXQ2yWzWK9JArAVDImiAwelFsLChM1laWgvOMYYNyGc4gxB2sxl
         TSFEh5sX3hUTQNZz9jmfBnRDkm17vFsY8VfZY=
Received: by 10.100.194.3 with SMTP id r3mr111575anf.9.1288122459086; Tue, 26
 Oct 2010 12:47:39 -0700 (PDT)
Received: by 10.101.70.16 with HTTP; Tue, 26 Oct 2010 12:47:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160004>

Hi,

I cloned a remote repository
to check recent changes in origin/master I do:
git fetch origin master
git log origin master

recently I found out that log doesn't show recent commits
I know that on server there were several commits let's say on the 19th
but log shows that recent commit was done on the 17th
the most strange thing I'm sure I have seen those commits fetched already
I did git fetch origin master several times but it didn't help
the log says that recent commit was done on 17th
after I performed git remote update
log again shows recent commits on 19th
Has anyone faced such behaviour?
I'm relatively new git user, what do I do wrong?

Thanks in advance,
Vitaliy S
