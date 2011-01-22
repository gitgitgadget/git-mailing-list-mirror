From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Sat, 22 Jan 2011 04:05:03 +0100
Message-ID: <AANLkTimurgnSFO=gR5Z-=GM27-QD00MCdXNc0x5Q-TQ4@mail.gmail.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net> <AANLkTinKNtDDy6Pi4Tn+hpTrVw_DBoYpTn3ihCfN_fUd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Joey Hess <joey@kitenet.net>
To: Eric Montellese <emontellese@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jonathan Leto <jaleto@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 22 04:05:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgTn9-0007Ba-TN
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 04:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab1AVDFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 22:05:24 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:39888 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab1AVDFY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 22:05:24 -0500
Received: by yib18 with SMTP id 18so730535yib.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 19:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=uUtxA6Yir4LcuQIMcXB49taOnvmBiyyX3E3I9m1OvXM=;
        b=ZyZzBeqwho1sQdylic0GVA7EikT1b/Q4CU1rBW6aTm8X4ihBq73RC1DkBkF+X5cbrz
         uSrbAMxb828kF/OYJOV3vOubyUOOkIg024oHNxL9zC/UeCwJH/EsQb2SE2zgpYfONAXx
         7EnHl46EGWJ3X9CQF+jAtmzXkixm4Q26fcaaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kBhT03fZK5RZEI9Cdv5tguX4YVOjTBP2OPQoh5aNIanonyJXEeoE77CvkJV37LnJZs
         cOsSxdRcJKxgTaeeJ6TplGRIyKyiVIw7K5KST4CkZ8fK4/hSG557IVVBS95hu6TVBk4F
         SkPomz4QSAxv2NaujEyb0CzjYeLguEsrER4oo=
Received: by 10.150.158.4 with SMTP id g4mr1578776ybe.214.1295665523186; Fri,
 21 Jan 2011 19:05:23 -0800 (PST)
Received: by 10.151.6.10 with HTTP; Fri, 21 Jan 2011 19:05:03 -0800 (PST)
In-Reply-To: <AANLkTinKNtDDy6Pi4Tn+hpTrVw_DBoYpTn3ihCfN_fUd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165405>

Heya,

[More or less separate from to the ongoing discussion, so no text quoted]

Eric, at the last GitTogether Avery presented his tool, bup, which
implements a number of solutions to the problem of large binary files.
I think I remember that Jonathan is also interested in the topic.
Avery, Jonathan, you can read up on the ongoing conversation at [0] if
you like :).

[0] http://thread.gmane.org/gmane.comp.version-control.git/165389/focus=165401

-- 
Cheers,

Sverre Rabbelier
