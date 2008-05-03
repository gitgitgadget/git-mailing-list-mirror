From: max roth <maxrothca@gmail.com>
Subject: Newbie question about submodules and git clone.
Date: Fri, 2 May 2008 19:00:35 -0700
Message-ID: <C7698B88-6ECF-43BE-BE97-82B69AC138CA@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 04:01:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js745-00039J-5t
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 04:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602AbYECCAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 22:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758463AbYECCAi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 22:00:38 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:50211 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222AbYECCAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 22:00:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so212130wfd.4
        for <git@vger.kernel.org>; Fri, 02 May 2008 19:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=Ke5Uvpi/IieE9nCB7KWr+uxoKzkNbCxQqMpYUBAcm6w=;
        b=dYgxHKnm1cfXpEeM6kVR76jxc8n/FVHN+yVxgZU4EFJy5uSKx0z8Ta0/1TjbzzYXefphG3MpG/4vlEGhq9+/NFrVgaHqamvFz6TPium4qnoxrcyqJ4VOaTECa6NBl+4UyDZeFCDMeDAKoRrIR0hhr3/OPdp0asLRGRvk6Ob7jAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=frvks8kiDLAchc20rIOWB30gsve+6H6GxdkTzcKHmI/WVuinTc5lBnCf/GrbXMegSWLURgtWUiLn6po31NCc41VDJp1gOAkZXRIXlx2lj4yJUKatjJkXqqP9X1+N15+lnFeQ1qoh18w61adw9UIrmkjDOvt914gebS0Vsf+X9iE=
Received: by 10.142.53.20 with SMTP id b20mr1510896wfa.280.1209780037155;
        Fri, 02 May 2008 19:00:37 -0700 (PDT)
Received: from ?10.0.1.199? ( [72.211.218.145])
        by mx.google.com with ESMTPS id 24sm9280887wff.12.2008.05.02.19.00.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 May 2008 19:00:36 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81058>

I have a small personal project that I want to use submodules for.   
For each of the
submodules, I set up a git repository and then used git submodule add
to add them to the super project.  When I try to clone the super
project I get this error

/git_repositories/biatch/.git/refs/remotes/origin: No such file or
directory
Warning: Remote HEAD refers to nonexistent ref, unable to checkout.

What does this mean? Everything is on my laptop so I don't know if
it is trying to go to a URL or something. I'm a newbie and documentation
about this is sparse. Thanks.
