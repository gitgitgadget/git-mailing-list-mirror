From: "Christian MICHON" <christian.michon@gmail.com>
Subject: how to change/fake the time for next commit ?
Date: Fri, 23 Nov 2007 01:29:45 +0100
Message-ID: <46d6db660711221629j5d294a5dp4771778e38b14962@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 23 01:30:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvMQo-0000eS-2A
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 01:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbXKWA3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 19:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXKWA3s
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 19:29:48 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:19429 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbXKWA3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 19:29:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3323939wah
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 16:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=2yTGNVIPBrEt24yq4jG+G9mFKdLagagRKbcV6z4IxJ4=;
        b=oxh/QWQhqJg0rSVoBeJmCGNuOoHyK+HVJn3m8gi1bG3SEpkkOJXd/MHhbi6MxxciJGNHjGblgQLwYyPC8nvR0ddCTO00Z/aXPfikZHo/IZPhMy88k/Yn4kv6Vy2IaaBAzP4lATPH29ck47DgrcG6H3wyrcQKdksD1mtaURSqbJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CUzPQOEBmfQKJGCviM6ow9y4S/6eMA0oy8CDSx2zgPS38miX/fdtDa1DCl4ZUsOP4/Sl7ChEHPWShJkkTqv5PfCyGN58+dceY0TFftQKbIP8hCa/6+rQfFgAp93UkLue+zkj9Jp88VXSXgcR6bLsM4NXntp3I6MAGIhyZ03oZFs=
Received: by 10.115.22.1 with SMTP id z1mr881883wai.1195777785948;
        Thu, 22 Nov 2007 16:29:45 -0800 (PST)
Received: by 10.115.18.10 with HTTP; Thu, 22 Nov 2007 16:29:45 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65861>

Hi Git list,

I'd like to recreate a git repo with kernel version, using exclusively
tar.bz2 files.

I already did such approach in the past by script, but usually the
dates of commit are the timestamps of current tar imports. I'd like
the date of commit to match any date I would give (without changing
the time on my linux system): the date I would give would be (of
course) the date of the released version.

example: date of 2.6.23.8 release was 2007-11-16 18:16 UTC, so if I
import linux-2.6.23.8.tar.bz2 into a dedicated "2.6.23.8" branch, I'd
like the commit to have "2007-11-16 18:16 UTC" as date.

Is there a way to do this, by plumbing or porcelain ?

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
