From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: 'git gc' & number of unpacked objects ?
Date: Tue, 17 Jul 2007 05:14:19 -1100
Message-ID: <f36b08ee0707170914g7ece7124qf5d8d6a1307cc07e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:15:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAphT-0003Mw-K5
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbXGQQOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbXGQQOW
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:14:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:33092 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbXGQQOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:14:21 -0400
Received: by wr-out-0506.google.com with SMTP id i30so849172wra
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 09:14:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AqYe1kYdl1GA+Bo2hAQOer3ilqQQyz5X5hGrkCDSlkyINaw6IOcU32JhaZ/c26V4uyhVxUO1ZQt3+3J6NokcnawGksh0A3BOtse7uJhp6LHmZflCFZkLcQPnxrLVC0WTHp20dwqKl+PUZ8NTUtgWeFB4ES1aRTx3nYANOzpBW4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Remvpx3QplyT7fgzw72S9P1ps/EQxpToXpf54NOXgFrBvFxNSrE0XuCVUQ+bC3u+vu5Fu/wDVL22aj8qpjcxh/N63Oja0ZsvFsr52X8XnOzMrXabc/tDua+L3qm5Jxb7Or8vItg8hQIWIYvFHkAXqgl6OR6Rm7tdIaceVRb8nuQ=
Received: by 10.143.9.5 with SMTP id m5mr45929wfi.1184688859657;
        Tue, 17 Jul 2007 09:14:19 -0700 (PDT)
Received: by 10.142.116.4 with HTTP; Tue, 17 Jul 2007 09:14:19 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52769>

By the analogy with the maxtime and maxmount in the ext3 when it
reminds you to fsck, when number of mounts since last fsck, or time since
last fsck is above some limits. I think this makes practical sense. I think
the similar thing makes sense wrt to 'git gc'.

Is it possible that git repo had a parameter N, and when the counter of
unpacked object hit this number,  then git operations start to print
semi-annoying warnings
      "Time to optimize your repo using 'git gc' command ... "
?

I am naive user. I forget things. Really. I rely on git to remember things.
Is this a reasonable parameter  ?

Thanks
Yakov
