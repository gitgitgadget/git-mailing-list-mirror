From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Tracking CVS
Date: Fri, 23 Jun 2006 14:14:58 -0400
Message-ID: <9e4733910606231114g5d16b05k21069c628f9ea9ca@mail.gmail.com>
References: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com>
	 <20060622135831.GB21864@pasky.or.cz>
	 <9e4733910606221918r775f49f0l4929f4703281115f@mail.gmail.com>
	 <20060623023131.GK21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 20:15:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtqBM-0003aN-7X
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 20:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWFWSPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 14:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWFWSPA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 14:15:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:41335 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751863AbWFWSO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 14:14:59 -0400
Received: by nz-out-0102.google.com with SMTP id o37so297704nzf
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 11:14:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VSTh+D+MYKlOEcdTNwebQRMriDlmPPXr096E6jah24g92Qy6mn1QfIW5FhiRtnGnxoO+cxe+pggvh5yy3uh7ibSyR7aJpwcA8YYe7yGc/qTZETmmbEYg1SN5w9ysbP9OcRfu+8j00RMJZDzMymrp/wDrh7nYpkgB0ZQ3muPceMQ=
Received: by 10.37.2.46 with SMTP id e46mr706400nzi;
        Fri, 23 Jun 2006 11:14:58 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Fri, 23 Jun 2006 11:14:58 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060623023131.GK21864@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22434>

My cg-sync script looks like this now:

#!/usr/bin/env bash
cg-rm -a
cg-status -wnSs \? | xargs cg-add

But when are no files to add or remove I get this:

[jonsmirl@jonsmirl mozilla]$ cg sync
cg-rm: no files to remove
cg-add: usage: cg-add [-N] [-r] FILE...

This is definitely a useful script for tracking CVS. I'd like to see
it added to cogito once it is fully debugged.

-- 
Jon Smirl
jonsmirl@gmail.com
