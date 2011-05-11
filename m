From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [BUG?] git revert option parsing too lenient?
Date: Wed, 11 May 2011 12:40:27 +0200
Message-ID: <BANLkTi=dPzu0wrDr3aycEv68M2tw7k5m8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 17:52:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBhy-0007yW-AG
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab1EKPvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 11:51:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37024 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569Ab1EKPu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 11:50:28 -0400
Received: by qwk3 with SMTP id 3so325199qwk.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=iCmY6uTrSog1ZooCNOB2OCXj/LMryerFwqIPrT2u9/Q=;
        b=inPZQi1Td4RMKSR/G57Z2JOiMK6K4ZcJFYkIoWzKukyjDj3gg2apiPNUm6dBRfRmed
         k+ipSHttibSJwPPrDWOqvTLmKfjDA/iVU0oXNg0b0gSw+BqN1ByFhO7ce3YuqzDU8W6V
         eQkbvTvI2SxzW7GiKsuVaStsrMkJLMkiZ3ELk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=mgQ9Aa1hhFd94AGljZ/JvD3jqhwgezymBTkqbOoaClegG2gDPlQ2I8GZ/Urcn4q7Kt
         49yBz2cGunceQJTsVk6cEYMaUVDipcg/9bcshFi20/QhCzsEE9/Q4Hj6q6iiFfrgTFeJ
         EcY0JYg2k0WdeL9BM5MmumlK2PWc7tL9F6H8k=
Received: by 10.229.90.90 with SMTP id h26mr7122407qcm.103.1305110467207; Wed,
 11 May 2011 03:41:07 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Wed, 11 May 2011 03:40:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173395>

Heya,

I just did 'git revert -p <commit>', hoping I might be able to
partially revert a commit, but it just ignored the -p (it's not
supported) rather than erroring out. Is this expected behavior?

-- 
Cheers,

Sverre Rabbelier
