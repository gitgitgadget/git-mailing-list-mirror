From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Exporting a tree from a repository
Date: Sat, 14 Jul 2007 23:25:52 +0300
Message-ID: <8e04b5820707141325o400e170bu9eb80b304cae506b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 22:26:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9oBq-0000Ns-P3
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 22:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761136AbXGNUZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 16:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760256AbXGNUZy
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 16:25:54 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:16992 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904AbXGNUZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 16:25:53 -0400
Received: by wx-out-0506.google.com with SMTP id h31so801423wxd
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 13:25:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Tdc9QIqBS6Hcu7HL+iA7h5nyIzSZnV3lomMPJK/4GbWLEFM92ysUDixIl7X6l16b/v1KGbYLY5iR3Mq3Lru9uHrNSQ1Rq4tL0HPg0nTSBPxvn5J6fOGdR8lLQxWPj+3fxsKGPw8IvQDD+6zoT32S02vz6FD4v2s01Hh42iAlYS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mN+Xg3kuWpxbg7WauLNj145u91PTEhw/5stPwiEi2c1I1KKZ58fnVn0S3URhyx2RYj7T7XMsDAF1qQTzxPnDRCbw+5Og4XEtP48IWTyRyyfUV+BzjQKFOF5rUTThZhysxidpXmELOOqSt3Dr5Ti7CbxVPyU+TswsACBiDeMgaKo=
Received: by 10.70.113.16 with SMTP id l16mr5148476wxc.1184444752744;
        Sat, 14 Jul 2007 13:25:52 -0700 (PDT)
Received: by 10.70.123.17 with HTTP; Sat, 14 Jul 2007 13:25:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52504>

    Hello all!

    I am a new GIT user, I like it, so I started playing with it for
different projects I work on.

    Currently I am playing with "Linux from Scratch", and I have
written some scripts to automatize the build process -- kind of
install scripts...

    For this I use GIT to store all the source packages -- each inside
it's own branch :).

    My question is the following: How can I export an entire tree
without using a working directory, or cloning the repository. (Because
from what I have seen so far there is no way to use the same
repository with many working directories...)

    Now I know that I can use "git archive | tar -x"... I am looking
for the same functionality but without the intermediary file... Maybe
something like "git archive --format=tree <branch>"...

    Also there is also a possible drawback by using git archive with
tar format, that is if I decide to make the repository available to
the public then it would be nice to have this export functionality...
I think this could be also used for kernel sources as an alternative
to downloading the tar.bz2 file or copying the entire tree...

    Thank you all for your feedback!
    Ciprian Craciun.
