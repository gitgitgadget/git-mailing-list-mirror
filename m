From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: git pull question
Date: Mon, 26 Jul 2010 11:26:17 +0930
Message-ID: <AANLkTimHg2wtNj2BmJKJfoisoqNEExC=jNU5wB95Bsre@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 26 03:56:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdCvX-0000yQ-RT
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 03:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab0GZB4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 21:56:18 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41512 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab0GZB4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 21:56:17 -0400
Received: by qwh6 with SMTP id 6so4750080qwh.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 18:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to:date
         :message-id:subject:from:to:content-type;
        bh=UMzBWunD9IYiAnpJAlbOFA41+uSBbZYALPlXJ02jbtQ=;
        b=EpZdyc0Et20kTpg+/TX8mROpd2uN5wHj55PexwuLmWFaMw4So1U59pxc1vKRbK4eat
         AXxhJb5P7CA5YeCX2TLtSXuvp7pjKBJnTwnWxc5vE5dfNbnhwXLCCtgJKyPPaGI0mM5P
         4u5ZVSYodauqDap99l3Q0u7ufwgtGHdu88nmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=FwagjTvLegamAxP7VU6nkA9YXVXKYjpstYv1RcAmr4rxg4kbm1teDej4B7R2B6v93K
         az7OxjNUizCkX8a3Dr+Ppea81R9yEwOkQOZTXP4oM7MhmnEvOR03a/CYp7L+FO/HipaC
         7CFDZPj0kcF0HJ6sjGyEv1eWYpZ0QuIXSdZGk=
Received: by 10.224.78.93 with SMTP id j29mr5287623qak.254.1280109377306; Sun, 
	25 Jul 2010 18:56:17 -0700 (PDT)
Received: by 10.229.227.12 with HTTP; Sun, 25 Jul 2010 18:56:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151800>

Hi,

Assuming I already have a branch called brA

$ git checkout master
$ git pull origin refs/heads/brA:brA

The pull here seems to update both the current branch as well as brA?
Is this intentional?

Cheers,
Geoff.

PS. git is at 1.6.2.3

-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
http://perfidy.com.au
