From: Lin Mac <mkl0301@gmail.com>
Subject: How to move a big branches to a new base?
Date: Fri, 26 Feb 2010 11:18:28 +0800
Message-ID: <10d816431002251918vf13a5e8uf0396aa861081bcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 04:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkqpG-0005q4-BK
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 04:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935095Ab0BZDZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 22:25:08 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45855 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935056Ab0BZDZH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 22:25:07 -0500
Received: by pvb32 with SMTP id 32so1544502pvb.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 19:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=slTy8vqjamonwoFF6HnAs5LRWecNCOdmuDcBpOMJdMY=;
        b=eq0f0ECeHaXrd87/Mg4hgKIOq8uk6JysRb3EgMSdrnmOHAmWAvsLZcBLDXWQBI9CNk
         voSjpLzbmxgetye/MTE5rJKqS2FSZKqYWy+ZSlQI94egt6Va5lBjJLmqKGImetisXOBl
         KDB/XkPG1a8g16POlzjYQWEhSpGs90rjHGRMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HFLQYTSWToaGeK3NubjMqUUQaHtyptWShNVWkaeXOWf5ODIh4wYyxP/zYRm8WqueSS
         XD6rPpZNBcTlzV3FsBXEL+anWYa10QPhIjwKst70siwTIlH6nXZ542YTJkxG6nh1OG48
         oSr04ZvZ4CHQDs02v9XIyo/FwrSnqtzbyhSAo=
Received: by 10.143.26.39 with SMTP id d39mr421687wfj.33.1267154308802; Thu, 
	25 Feb 2010 19:18:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141092>

Hi,

I have a branch that have about 10 descendent branches. Now I would
like to move this branch, and all the descendent branches, to a new
base, and I might need to do so quiet frequently before I merge it to
master branch.

My "dirty" way is to rebase step by step, it takes about 15-20
rebases, but the branches is somehow complicated, and this seems
error-prone to me.

Is there a more clean way to do so?

Thanks in advance.

Best Regards,
Mac Lin
