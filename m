From: Jon Smirl <jonsmirl@gmail.com>
Subject: Figuring out which patches have been applied
Date: Fri, 2 Oct 2009 10:36:18 -0400
Message-ID: <9e4733910910020736n539f4331nfd61175b275c7d28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 02 16:36:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtjFB-0005gU-OL
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 16:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757905AbZJBOgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 10:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756572AbZJBOgQ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 10:36:16 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:58501 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbZJBOgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 10:36:15 -0400
Received: by gxk4 with SMTP id 4so1551281gxk.8
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=ZSwIig0sj49AY3YSTppISPk3I0/FM49fXqt+rHnLm48=;
        b=xFCrmAdmM35m9zgNJZ1V0JnNYfYnaV/SCTKnWl2vr+AxdpM5J6/y7XEx9K1RgGOJFT
         Rq9b6RxG/gMefFkpG+A2S2cxT66nI7WT+U0gZ8rgyJ34tPhGJkcVkRndxOoqTCltqi2f
         VEQcvYsTCWNhJIuM8Nnk58HYJ017Ddf50MPcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=fk5rmecxgOZlFrGPIt3gmU3xDRxIOO+pAK+qzOdy3gXccz46GIkhFP17jPcAEART5W
         UcA8HKg6raTLBJjmT9YoskXZOFl5wKKKFx6wzbAxQ0KAjI2o2RpqmmG0gWRh6tc02DBo
         YEoZLJiIJq49r8GjGBs3I2MqCwzOOQCe0se+o=
Received: by 10.101.191.17 with SMTP id t17mr2949449anp.87.1254494178779; Fri, 
	02 Oct 2009 07:36:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129443>

I have a stack of 100 patches against 2.6.30. A lot of these got
merged between 2.6.30-32.  How can I tell which ones have been
applied?

It doesn't work to check if patch A has been applied to 2.6.32. Other
patches may have been applied on top of patch A obscuring it.

Once solution would be to rebase the patch stack forward one commit at
a time. That solves the problem of later patches obscuring patch A. Is
there a better way to do this?

-- 
Jon Smirl
jonsmirl@gmail.com
