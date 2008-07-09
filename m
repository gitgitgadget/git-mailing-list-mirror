From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: clever(er) file merging tools?
Date: Wed, 9 Jul 2008 14:16:17 +0100
Message-ID: <320075ff0807090616s147c805cu82ba8b3d9ba37140@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 15:17:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGZXq-0002Kn-3p
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 15:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbYGINQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 09:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbYGINQU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 09:16:20 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:12799 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbYGINQT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 09:16:19 -0400
Received: by mu-out-0910.google.com with SMTP id w8so922128mue.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=bfWPj1OY/6f5EI6rohBPo0xhqzbxqy6FwA5OpoA9St4=;
        b=R5cUtCCMR3soctfEcMKq/ae2GhS+jQz/vpZKZjgourNb7lP1EN/yXpuCZzpQ7UZs9h
         YFdmJ8/xDwkN3/fl6yHnC6ct16QXV0XTzE6WDfb+9Fn+BtUQ32A19NUjncP6qGce37HE
         WEBQYf41ix1fpY1lrA2CeUyIAK1/mI7DKFFGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=XYMLNmU0erAuuhSjuYX2lVNrMVjrfv4C8hPIwvBYWsFc/568jFw/OuDP/AUfSTsAOT
         LFDSNmrwBJfQwr4PTEjRZUn0q3u3cZPCg2yInxcdXEl1mw1hSjAoIPwbjzalyW6YNKG1
         jO7j7GEmlOKFcN3rOciyjByYPxCxthWmkPhbY=
Received: by 10.103.11.7 with SMTP id o7mr3916291mui.103.1215609377028;
        Wed, 09 Jul 2008 06:16:17 -0700 (PDT)
Received: by 10.103.185.13 with HTTP; Wed, 9 Jul 2008 06:16:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87881>

This isn't git-specific, but since git users tend to merge more often
there might be some good knowledge here.

My usual practice in merging is to issue the merge, then use 'git
mergetool' to cope with conflicts. On my mac, that fires up opendiff,
which does a reasonable (I guess) attempt at unpicking the changes and
allowing me to choose.

Sometimes, however, probably due to complexity, it spits out a huge
section of the file as being in conflict. Examining it, I always end
up getting annoyed, since for a lot of the file, the changes aren't in
conflict at all - whole (java) functions are in the conflict area
where they're actually the same.

I have wondered if I could pre-filter the sourcecode through something
like Jalopy to re-order all the blocks into a common ordering. But I
also wondered if there were any merge tools that (say) understand the
structure of Java and use it to compare at a method declaration level
rather than as a big text document? Maybe just opendiff isn't the best
(though I quite like the interface as it's easy to understand and the
price is right...)
