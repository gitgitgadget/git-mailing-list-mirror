From: "Ludvig Strigeus" <strigeus@gmail.com>
Subject: Git rebase -i failing on cygwin -- git checkout-index says File Exists
Date: Tue, 20 Jan 2009 21:09:23 +0100
Message-ID: <4285cd450901201209i792195dfmdec1fb14d627b25e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 21:11:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPMvz-0008Iy-PQ
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762890AbZATUJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 15:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756937AbZATUJ0
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:09:26 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:47503 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762881AbZATUJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 15:09:25 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1579797ywe.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 12:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=JU0FLZylLW/5L69lJJMwhHPg1nSlW6kCfb1n/XFUtsA=;
        b=ToHysHlcQKkqIvZQxOQ0ZuBU0Xq16u24tPyE1uImv3UG79XCigDD0uIUvBZz0Oa8ru
         +6cb+lHvJhQABNGfbKStFVCYgJ5xTwf4V7Fn3tIYn8ponEqjMDXO/mRYoEtLNwJ+ymrI
         sdblcSpuKUKQxg+QLSZNT0UW2ZKdy9JbcVygQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ohru4D1B4o8YQIXv6DppTnS0t+icPglRNjb8OEa53bRwEQ1+C4DURcKbLUtVCB+p7n
         6HnGDlCnJTVatEprpwCm7qMwtYFtmDqvrxGTVgKIlv6PhO2B+p5OIpggeM83XpRe6pPY
         NC3Xw60H1uhXDeT5di0Sco7O6uEj0VQdQx2TQ=
Received: by 10.143.160.17 with SMTP id m17mr1102643wfo.298.1232482164005;
        Tue, 20 Jan 2009 12:09:24 -0800 (PST)
Received: by 10.143.109.1 with HTTP; Tue, 20 Jan 2009 12:09:23 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106514>

Hi,

I'm having some weird problem with Git on Cygwin on Windows XP. I
start with a totally clean repo, and then run interactive rebase to
edit a historical commit. I exit the editor without doing anything (I
get similar issues if I modify stuff inside the editor).

$ git st
# On branch master
nothing to commit (working directory clean)

$ git rebase -i 4a1552c81b622f85b0e9170c6fd7a22b4a3e633c
error: git checkout-index: unable to create file util/stringfuncs.cpp
(File exists)
fatal: Could not reset index file to revision '4965936'.
error: Entry 'util/boink-py.cc' not uptodate. Cannot merge.
fatal: merging of trees 0c27b10e163f00655486976896d096302b0f5c21 and
7c7dfd93d678cfc564649738d45260e0b5d9f5a7 failed
Could not apply d9c7ac9... Various reorganizations.

Any clues?

Thanks,
Ludde
