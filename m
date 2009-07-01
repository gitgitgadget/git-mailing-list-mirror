From: John Tapsell <johnflux@gmail.com>
Subject: Re: CVS <--> GIT workflow...
Date: Wed, 1 Jul 2009 20:24:30 +0100
Message-ID: <43d8ce650907011224l52910844wb13df2ab1d87dea5@mail.gmail.com>
References: <ac3d41850907011132q8e19b37ofa10813258a97555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM5Q6-0006iU-On
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 21:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbZGATYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 15:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbZGATY3
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 15:24:29 -0400
Received: from mail-qy0-f193.google.com ([209.85.221.193]:64380 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbZGATY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 15:24:28 -0400
Received: by qyk31 with SMTP id 31so1261316qyk.33
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S6bTgEgBumERT1kSL/zMiYH0+txkR3nD+f3OUdtVQWA=;
        b=HzQhH391VSdfQTU1bMyeux5L8fymhdgChqxWM7m6KNCs904F6lsnHPInJ/+zCPwPcJ
         T4G5SLSItzkqd2lilI263lXeMn1YYN/UjtKlqL60lkXLUV//sXZc1y48ralwkXlsb1Oz
         QguNlhe1T3ENgixUseph6BZ3V5ksF+28Bcjqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=junwQotgpAPwIgx7Nfhe6TZh1/riRJS+xA7AqdVZNQeWDI96ve8qV5B2l84kYk9IW9
         wZS3AqQXAsHGUCvfClHgxwZlcA0voVs2SwNPH6nG4mdfUD8vIZhq0VQPjxA8xO99JPTg
         ZcfpSmmiHLmzhzbKEYizAs5Lm9YyCnEKFr6+A=
Received: by 10.231.38.140 with SMTP id b12mr2666183ibe.29.1246476270842; Wed, 
	01 Jul 2009 12:24:30 -0700 (PDT)
In-Reply-To: <ac3d41850907011132q8e19b37ofa10813258a97555@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122594>

2009/7/1 David Chanters <david.chanters@googlemail.com>:
> Hi all,
> for
> a variety of reasons we're unable to simply switch away from using CVS
> to Git.

Perhaps you could switch from CVS to SVN?  SVN improves on CVS but
behaves in a very similar way.  Then you can use the mature git-svn
tool.

JOhn
