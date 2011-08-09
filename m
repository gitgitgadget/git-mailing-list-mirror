From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Suggestion: improve cherry-pick message in case object is not found
Date: Tue, 9 Aug 2011 11:58:01 +0200
Message-ID: <CAA01CsosJJb1suq2YDmcFKPdBD4yHWXrENfCP0mewDEhsFjcOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 09 11:58:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqj4d-0004m9-N4
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 11:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab1HIJ6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 05:58:04 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64498 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab1HIJ6C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 05:58:02 -0400
Received: by gya6 with SMTP id 6so1770436gya.19
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=uUcR79pnQVMWph5xvykUqF3VcXY8cZqUHi8kzb7tpn8=;
        b=ERf8JSg6P5f5h+4rKt8BvvO9vyKOONbG+nUtnfbaI8hoYYQu01qZDwlC4KS3xt7d2S
         lnyZT6yZBsaavM3BYoG6uE0P7wkaTgPwhoBWTE3t3PICrA8UUpp5D4ua/WQzWFoVmpZn
         Z5h90EAB/icwe//pi/6rgCqMEJHB+ezL/bTFg=
Received: by 10.151.60.17 with SMTP id n17mr6599742ybk.338.1312883881174; Tue,
 09 Aug 2011 02:58:01 -0700 (PDT)
Received: by 10.150.230.15 with HTTP; Tue, 9 Aug 2011 02:58:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179027>

Hi,

I'd like to suggest improving message displayed by cherry-pick (and
others?) when it's given non-existing sha1. For example:

$ git cherry-pick 2ac2d6d5997de01b84de54fe8ac5c7d6bba139ca
fatal: bad object 2ac2d6d5997de01b84de54fe8ac5c7d6bba139ca

The "fatal: bad object" suggest to me that the object is found but is
incorrect/corrupted. It took me some time (in which I managed to run
git fsck) to find out that I ran this git on wrong repository, which
did not have object with this sha1.

Is it possible to change this message to for example:
fatal: could not find object 2ac2d6d5997de01b84de54fe8ac5c7d6bba139ca

Thanks,

-- 
Piotr Krukowiecki
