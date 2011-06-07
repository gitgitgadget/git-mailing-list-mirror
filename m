From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Sequencer: Iterating over a stable series
Date: Tue, 7 Jun 2011 11:18:50 +0530
Message-ID: <BANLkTik93BB7p0gNMx5ZfsSCjietXxiG3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 07:49:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTpAD-0004w8-6o
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 07:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab1FGFtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 01:49:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37294 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1FGFtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 01:49:11 -0400
Received: by wya21 with SMTP id 21so3290694wya.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=BcOi63HQlUTrsvum86LxYmudrpl8Ndv0pBA3UTxeGCE=;
        b=HuVzK6C0wywCP3E12l0E6bSehhZ8IzQEjAhursn1qDyQDPiYw85Zm2oYY4FosdsJtp
         udD4C+4DLP/qqB1J2vYQKZmADrWMt/LxPbORShwXQjtVB4535Ak8JD8iEFK5fBdj2OCT
         lNy5fH1YGZWU3y+HLPzctGBbZdViFdQoougVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=HV3A73mP4rIe9fI2lw+nzBWu1o3kFZVFxhvjdxhx/y6GJCIy5k7rK4Gi5hd0k8mTaI
         aLf5kFNqkGYCoozi7UjHviDsbsjebuuqrl87lueS/lNyPFpu1AkhHMVV7zxNzmpLSM2Q
         4DOx2ZQSFMTKoVLlQvLr5eUl0uFvWVfq/UGr8=
Received: by 10.216.236.208 with SMTP id w58mr3236175weq.62.1307425750072;
 Mon, 06 Jun 2011 22:49:10 -0700 (PDT)
Received: by 10.216.51.213 with HTTP; Mon, 6 Jun 2011 22:48:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175187>

Hi,

I will start posting weekly updates starting with this one, since I
now have quite a lot to say :)  Over the first few weeks, my objective
was to keep iterating the initial series I'd posted until I ended up
with a more-or-less acceptable version.  This [1] doesn't seem far
away.  Now, I'm busy writing some tests, and planning out the
functionality of each of the individual features -- as soon as I
understand the problem correctly (see discussions in [2] and [3]), I
will start working on writing new features.  I'm quite hopeful about
meeting my mid-term target.  Please feel free to email me any
comments/ queries about this project.  Alternatively, catch me on
#git-devel on Freenode IRC; I'm almost always available, except when
I'm sleeping.

Jeff: I was out of town these last few days. I saw your email about
the lockfile API confusion- will investigate and comment soon.

As usual, the latest code can be found on the sequencer branch of my
GitHub fork [4].

Thanks for reading!

-- Ram

[1]: http://thread.gmane.org/gmane.comp.version-control.git/174526
[2]: http://thread.gmane.org/gmane.comp.version-control.git/174393/focus=174945
[3]: http://thread.gmane.org/gmane.comp.version-control.git/174874
[4]: http://github.com/artagnon/git
