From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Test #7 in t9200-git-cvsexportcommit fails
Date: Sun, 22 Jul 2007 12:41:53 -0700
Message-ID: <31e9dd080707221241j5c00aaaaqa79c12d3e2a3345b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IChJV-00006T-Oz
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbXGVTlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755070AbXGVTly
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:41:54 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:39371 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbXGVTly (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 15:41:54 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1302149wxd
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 12:41:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JgAEKXgsXHljwNruj60Xj9Y9KvRw3RWGLx6V1vA6HawXBeP1qXF5qwlp0uetgQuEc7A4dr3m/W3LaRGFijxqb/e9F18vhw+T8EcL3eOSJ+tvREFK4KUlJWBkl5pUgRqwmIK1hpCTFeJYu6s/BS4w2DZb1kxcsmVt4fdEAJijGIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FkAcHKsky3lTrfqIkbfsWWLGeDxq3wcIwKB8ZUub7B+6lQR1xKKNLCeS6IQ/ywPcIvLOLiBv9SgZnMpFHxq2L6s9c8WjL5r1Gvzqm/7Eu3oZ4g4O4WTvfVV5gVGashXIMGcMrZv/QXki4Fb9NjeUcT9Yshz3KAuS5oGjDcefnlU=
Received: by 10.90.52.18 with SMTP id z18mr1412198agz.1185133313285;
        Sun, 22 Jul 2007 12:41:53 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Sun, 22 Jul 2007 12:41:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53306>

This test fails for me on the current head (pulled just now) and where
the test was introduced (e86ad71fe).

All other tests pass.

I know almost nothing about how CVS works internally, so I don't have
any insight as to the cause of this problem - all I can see is that
the contents of CVS/Entries has the 'with spaces' files at 1.1 instead
of the expect 1.2.

I'm happy to provide more information if you can tell me how to get
it. In particular, I'd like to tell you about my version of perl-cvs
(or whatever it's called) but I have no idea how to do that...

Jason

P.S. I don't use this part of git at all, so this is not a priority
for me. I am using Fedora 7, which is definitely a mainstream distro,
so I imagine others might have this problem too.
