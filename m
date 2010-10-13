From: Kevin Ballard <kevin@sb.org>
Subject: Manual hunk edit mode + emacs + ^G == garbage
Date: Wed, 13 Oct 2010 14:37:03 -0700
Message-ID: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:37:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P690d-0008ND-Qv
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039Ab0JMVhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:37:08 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55431 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab0JMVhH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 17:37:07 -0400
Received: by pxi16 with SMTP id 16so853291pxi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 14:37:07 -0700 (PDT)
Received: by 10.142.215.11 with SMTP id n11mr4520559wfg.224.1287005827320;
        Wed, 13 Oct 2010 14:37:07 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm3487457wfh.3.2010.10.13.14.37.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 14:37:06 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158981>

I've been having a rather strange problem using manual hunk edit mode (`git add -p`, e) and emacs together. It seems every time I hit ^G inside of emacs in this one circumstance, the entire process instantly shuts down, both emacs and `git add`, and it doesn't even give emacs a chance to clean up the terminal, so I'm left with garbage across my display (the remains of the emacs window) and the terminal settings are screwed up enough that I have to close and reopen it (even `reset` doesn't fix everything). Has anybody else seen this, and if so, do you know what's going on? I cannot reproduce this with emacs outside of `git add -p`, and I cannot reproduce this with vim even inside of `git add -p`.

-Kevin Ballard