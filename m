From: David Chanters <david.chanters@googlemail.com>
Subject: CVS <--> GIT workflow...
Date: Wed, 1 Jul 2009 19:32:33 +0100
Message-ID: <ac3d41850907011132q8e19b37ofa10813258a97555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Chanters <david.chanters@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:33:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM4cC-0008OW-Ps
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 20:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbZGAScc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 14:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbZGAScc
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 14:32:32 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:65273 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbZGAScb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 14:32:31 -0400
Received: by fxm18 with SMTP id 18so998043fxm.37
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=EkRe2BBa6SsJ7SIzHxZJld5LbITCpViho6JRFfIhonk=;
        b=YTnEDi1U0RHu54uwOJnTNLP8LgsayA8yzNvw79b3RqBNAmMUjqrgPQrhi9mweYb/4r
         +RE2Wov0ChTxFmNTwLAtL3v6aIblxs6V3dBHDezYWTItLAdelMvjRJlHQmVm1oJLskDR
         W+WdafN82Qf8r/kZLKzmQ7qqtQiv4zUnTplP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ixTmmrCSooV5RASfbKH9+r2O5osa5p1aqtO9BTDg5aIBqZit2U7z6TJki/rWb815vh
         V31EPKSKQR18v19l7dv4i4dAe0Yb2Tkr4pDXULkdQGoVZOrU/9DBrV6lwtR5iDxKu/W4
         Jt5FwXWsH7FMPv6oAwDrOhz83EDzZL8Di6YUY=
Received: by 10.86.94.7 with SMTP id r7mr4714659fgb.11.1246473153762; Wed, 01 
	Jul 2009 11:32:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122591>

Hi all,

[ Please Cc me, as I am not subscribed to the list. ]

I am wondering if there's any best practises/howtos on using CVS and
Git together.  I have a project which is currently residing in CVS;
people actively use it to add changes, etc.  Which is fine -- and for
a variety of reasons we're unable to simply switch away from using CVS
to Git.

So... the question is, can I use Git locally to manage all my work in
-- create topic branches, merge them, etc., and then commit that back
out to the CVS repository?   Likewise, I would need to keep my Git
repository in synch with any changes to the CVS repository -- is that
possible?  Has anyone else done something like this?  What I am
effectively wanting to do is Git for my entire development on this
project and just forget it even uses CVS.

I've read up on git-cvsimport which seems to explain how to convert a
current CVS repo over to Git -- is that right?  Any information you
can point me to would be very welcome.  I am not adverse to reading,
providing it's useful to me.  :)

Thanks, in advance,

David
