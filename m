From: Sabyasachi Ruj <ruj.sabya@gmail.com>
Subject: Re: Confusion about content of conflicted file after : git remove/add
Date: Fri, 25 Jun 2010 11:06:46 +0530
Message-ID: <AANLkTinQu19HKUC2a_JkSyeZ_SynE11eNwgH9zEMiY8g@mail.gmail.com>
References: <AANLkTimqrfeNEmlfHGxWTdLgS7tAMOA66N4nV8b5I8F6@mail.gmail.com> 
	<20100624061029.GA11020@coredump.intra.peff.net> <AANLkTilo0b9aL3oxk0b8eNkBWygwA7xSclTy1MaK8qba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 25 07:37:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS1bU-0002IR-0F
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 07:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942Ab0FYFhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 01:37:08 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44798 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab0FYFhH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 01:37:07 -0400
Received: by qyk38 with SMTP id 38so441027qyk.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 22:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=IutryG496yuVnrYt7lQKEuPXe/BBu6oVbnD++TV0e/Q=;
        b=VbTTGwmwX0faOKB7pswoxcvwg8j+XEL1QNBnyi/5ZxKfru4BTwnar/5Qxq6ob7wNgF
         dAEgvpPlc/1hn+Pk0DmqTyYzv7xMesWqA9IxELeeprgkM7g4//4rywNWHwyGIMtOqQkM
         5oYZIAmCUTsimGXI3v7TbfciJugZs/Q0RiHAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qSDCTwmKEigpUOgQrE/kBzN94U1OH/HIBsVeaA/z/t8aN7QEe63J/QKcdYHidyzdwR
         96/xNYKQTLd9dJ8jcsYlsnDwUo4eDJvVM8lbgouRuKf3YnSsFGpYbVEleIx6MPlOpfdP
         6xQTGgApHgNSkbwT/xJu+DAHQ9CZEbonAhupU=
Received: by 10.224.87.169 with SMTP id w41mr86736qal.292.1277444226184; Thu, 
	24 Jun 2010 22:37:06 -0700 (PDT)
Received: by 10.229.241.149 with HTTP; Thu, 24 Jun 2010 22:36:46 -0700 (PDT)
In-Reply-To: <AANLkTilo0b9aL3oxk0b8eNkBWygwA7xSclTy1MaK8qba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149665>

>> So I think there may be a bug. I don't really see any code in
>> merge-recursive.c to handle conflicts on _both_ sides of a rename, but
>> obviously that is possible here.

Then I guess having contents of both the files would be an expected
behavior. Should I report a bug somewhere?
-
Sabyasachi
