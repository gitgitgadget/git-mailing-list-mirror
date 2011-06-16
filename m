From: Ilya Basin <basinilya@gmail.com>
Subject: rewrite history
Date: Thu, 16 Jun 2011 23:17:58 +0400
Message-ID: <362053118.20110616231758@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 21:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXI51-0004YX-JP
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 21:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab1FPTSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 15:18:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40689 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab1FPTSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 15:18:08 -0400
Received: by bwz15 with SMTP id 15so225291bwz.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-mailer:reply-to:x-priority
         :message-id:to:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=FhbI0tqnBjBEV9fmfYeu5byod4FIo/vk6tOfN5zJUzY=;
        b=oN5KAXAQ1pNoaSl8AB477eeLS5d6imiswexoBKa9VZ/Bd2GJQUBtRYNBtKmGoWwVJy
         mpzIPmOvSteUk/VNJJ8rwiStTMheuy5QnjWAR5mTh0Rl6lTrSQJl0+RZyAApyI3Qb4rI
         MImdnzyF8KbQNGCdV50PPiYyLFAlf9l3wElBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        b=w7G2iffR5j0Ez7KKhEWQ1wryZQADyMfcL0tgC5EqHlP5p+inwfAwx4cvs+zE2nkhtp
         7sD+ZpLkj3n4fX5SghyX/8iBpDZz8NzNy4glZz8lDpZ07nfTJ8vIITmYnU3st1Xx3dsH
         R4S78+UAtkr0Ojnhz8OpR7nwHh807gqv7K9XI=
Received: by 10.204.9.208 with SMTP id m16mr1001217bkm.83.1308251886553;
        Thu, 16 Jun 2011 12:18:06 -0700 (PDT)
Received: from MAR2.localnet (pppoe.95-55-137-3.dynamic.avangarddsl.ru [95.55.137.3])
        by mx.google.com with ESMTPS id ag6sm1410876bkc.18.2011.06.16.12.18.04
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 12:18:05 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175917>

Hi list. There were 2 branches. One's HEAD was modified to match a
specific commit at another branch. Now, how to merge them according to
this scheme?

A---B---X---E---F
                     =>  C---D---X---E---F
C---D---X'

X and X' have no difference. I tried to write a script to cherry-pick
E and F, but some of commits are merges and cherry-pick fails.
