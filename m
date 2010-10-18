From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: corrupted repo and "git push --mirror"
Date: Mon, 18 Oct 2010 09:38:03 +0530
Message-ID: <AANLkTikZEa4GeQHMXC2vBc8_+1208oEs7d-0KGXBw0p2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 18 06:08:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7h1B-00045D-2s
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 06:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865Ab0JREIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 00:08:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52169 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab0JREIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 00:08:04 -0400
Received: by gyg13 with SMTP id 13so155966gyg.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 21:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=vGp2FUcy7SzrigGLH3KSBw8u5HIFP6kbBSuDGkZ7c8o=;
        b=U4UXz3SJvALzCbysDh16FXr4+i5YA2ZjKboj7GaN+sXeZIaNBSLWY2Ydv0kjyexOFK
         IFmh+iAJhBoQ6LmOp5L7U/XyXuLLSELiaQDiG1+F7c+TPd3ZOAji2TyJtE4YFmPQUJZI
         LyxvHwRD1P3RAIe2eC3yATQi54n6mA1og2Rzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ct6RrJdJLREXf2n218VdnRip8N/3HhOOSxDSxlgLDlIJM+79sIsPxo/1CbUQi2x67n
         WkcV/yVI7eTLJqFgwisNkebpmi61d39nZaUUFi2UnqJiurslwvo22FAFXQMW2PBXkF7q
         amGbbE4v1cp1Q40/SDUSYLbFZb+uRM61pYxi8=
Received: by 10.90.88.20 with SMTP id l20mr1513236agb.136.1287374883865; Sun,
 17 Oct 2010 21:08:03 -0700 (PDT)
Received: by 10.90.83.17 with HTTP; Sun, 17 Oct 2010 21:08:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159230>

This is probably a stupid question, but in the spirit of extreme
paranoia *and* because it's kinda hard to "try it and see", I'm going
to risk the ridicule :)

Gitolite has mirroring support now, basically using "git push
--mirror".  The question I was asked, and I couldn't *confidently*
answer, was: what happens if the source repo suffers some corruption
for some reason?  Does the corruption propagate?

I suspect not, but I'd appreciate corraboration and if anyone can sat
what actually will happen that'd be great.

Secondary question: what happens if the receiving repo is corrupt?

Thanks!

-- 
Sitaram
