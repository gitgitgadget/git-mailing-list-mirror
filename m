From: Gulshan Singh <gsingh2011@gmail.com>
Subject: Why can't I push from a shallow clone?
Date: Thu, 25 Jul 2013 19:33:16 -0700
Message-ID: <CANEZYrdsCgH+3NnZnnmsn_znt=+01aNn02u4mWyb3td9XypUog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 26 04:33:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2XqZ-0000DV-65
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 04:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810Ab3GZCdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 22:33:17 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:45665 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756859Ab3GZCdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 22:33:16 -0400
Received: by mail-oa0-f50.google.com with SMTP id k7so6391674oag.9
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 19:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tjwE2QTdvBcOUHGBXQQNWI3yYo07qWsh/qUwkv8Yk2w=;
        b=bgF76KKEURJ01a6seh8T4H9OEmmYfI7Vc5K2bOKS4fqbOWL9UFaDJmhxtUEzhXQscW
         e1s5kWYkv9x4FeBCkaTbuJC44+Fb1WlahveKV4eyH3TQgL9SKz/6yhiG4v7+bNf5u6wF
         86mSe799AJNUIMG1mrd2FjztwQW2JjBKssbcIbcDZwfi3apsCM8pD3EBWLLW5dUxRt17
         bNhNhz2xwMcOEjPkxUFbofvf/2TmMpylf7zvnSuzkUzo1RuSkawJRPLJ6Z2JsbM0dm/U
         hvVe1ywmH2GldP2dSLNRA0SQlaBD6Q4a6lTwEBMRPK78nxG07unEhsVBEC8IeP3xDvZp
         jqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tjwE2QTdvBcOUHGBXQQNWI3yYo07qWsh/qUwkv8Yk2w=;
        b=dzrc12DlDGpilu+b+2xj/r7EG1zRylMmuzCSMt2P/e+6NgSKiJKo8p72JQOL6cs2qo
         e+smZY6qFG10fr+pZ1nHTv27PE2h82MRBJd2Bv/rWmRdmpn/HW1cwsoczTlq4qVvp1a1
         stIHXeFS2omj2/wbQQtiV/Q/h7rHmd3BqmFLcWqSCls7T7XZUbktJiQeZrMujdoeaTNT
         CUbulSMVG+/0tsdtuQgW9wGHFUZCGzu2hCUZ2nYoEJdEiirgZIpQO398Ry6KWYhjL8dr
         yH//TLgCepaqXQQkMCWFLR41kCGSYQKb/HCuaFCJctbRsXUgy5MIqk+F5pzSLV5pyEDN
         JBwg==
X-Received: by 10.50.22.105 with SMTP id c9mr731650igf.36.1374805996177; Thu,
 25 Jul 2013 19:33:16 -0700 (PDT)
Received: by 10.64.41.67 with HTTP; Thu, 25 Jul 2013 19:33:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231159>

I've been trying to figure out why I can't push from a shallow clone
(using --depth) to a repository. I've made simple examples where it
works, but I've read that in doesn't work in every case. However, I
can't come up with a case where it doesn't work. Googling gives this
answer: http://stackoverflow.com/questions/6900103/why-cant-i-push-from-a-shallow-clone,
but I don't completely understand the explanation, so I was hoping
someone could explain it.
