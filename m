From: Michael Witten <mfwitten@gmail.com>
Subject: Patching bad commits
Date: Mon, 28 Jun 2010 22:03:38 +0000
Message-ID: <4c291e41.4f1ee30a.3484.fffff729@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 00:12:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTMZ0-0005mn-F2
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 00:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab0F1WMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 18:12:20 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:59416 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab0F1WMU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 18:12:20 -0400
Received: by wwb18 with SMTP id 18so36250wwb.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 15:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:subject:from:to
         :date;
        bh=r31Rny0d1jFQ3fNkt6ZOc98z5IPtm8isZZuNYjmcDUs=;
        b=FcGh7N0qex9nVUl42Zp1KKFYJKiJ+Q8zqAJfjc7vkrW2YDK7lcr4ckm1bATxZkMazR
         RR/x9S31PWghXGNkWsfJf9/KRRotVPvJZEBymnW0mQUYmcMRMQivH8GxaoFGFsV8L4Qh
         NXzSKzgRf8Uz2TI3SDqOGCAzi9WR3MFA2dnLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:to:date;
        b=wF7lJEspKw5kJGdhBdOfWIQ+Rj4tGovYMNOy32BDYaLCEbU6b0+1Pjc2c9KPXnfeqR
         ILLTFFAOMwTANWSMw8u1YFJrYSX42qknN0TJlpbKpWDlapvTtdjggkVyLuhe52s71lDy
         LZujGQddZDdlbQegJQwdb+WByvuLr5cC3aB2I=
Received: by 10.227.156.13 with SMTP id u13mr4385576wbw.184.1277763138359;
        Mon, 28 Jun 2010 15:12:18 -0700 (PDT)
Received: from gmail.com (gpftor3.privacyfoundation.de [62.141.58.13])
        by mx.google.com with ESMTPS id t15sm67910448wbc.17.2010.06.28.15.12.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 15:12:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149865>

Sometimes bisecting is less than useful because a number of commits
fail to build.

How about implementing something SIMILAR to "git notes" (perhaps
even using "git notes") to store and apply patches for such bad
commits?

For instance, bisecting could transparently apply any patches that
are necessary to make a bad commit actually buildable; such patches
could be distributed as usual for the benefit of others.

I'm thinking that a "patch note" could have 2 forms:

    * A plain patch file (or maybe a git tree of patches).

    * A reference to another commit that should be checked
      out instead.

Is this a worthwhile idea?

Sincerely,
Michael Witten
