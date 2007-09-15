From: Russ Brown <pickscrape@gmail.com>
Subject: Mailing patch series'
Date: Fri, 14 Sep 2007 20:06:35 -0500
Message-ID: <46EB301B.8050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 03:06:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWM7V-0005Zf-76
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 03:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759759AbXIOBGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 21:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759677AbXIOBGo
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 21:06:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:47489 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbXIOBGo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 21:06:44 -0400
Received: by wx-out-0506.google.com with SMTP id h31so944085wxd
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 18:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=0Iy4cepS0XreXtVomjbLvXv7umefFiMhzj0vfa0K3u0=;
        b=lB1IPSds3QDkBV138V0tmoy1CRqCuntAB01uvl5sEHqfm2DbifRix5jDUjDKfpiCGlKrqMQwBKgM11EH/VGNoTcjOIGKE7dWHaXjK98tnQZXCShTdjr4n8ZYy6s08k0wlr2KarlNcoKJxRd2vsutk88bEjt5dZNWvGLhWmy6qoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=b2vf0M/0rL7q3Dlt+7RP+pzdEXqRcdyRpn+fATGjHgb1H1prWMY7O/ZBjPifLBuOuK4uBxy3vHzyvGRMNh81CHQvPoVXdclvz7xljoLYK5KdnTb6nUQD5rwb+btRsVw0K0T8Jw9n+EMFjv/EoMx3rPhpIqJ36NHMUWO5w8zawgQ=
Received: by 10.90.96.7 with SMTP id t7mr587532agb.1189818402933;
        Fri, 14 Sep 2007 18:06:42 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.170.8.213])
        by mx.google.com with ESMTPS id 7sm1812904aga.2007.09.14.18.06.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Sep 2007 18:06:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58215>

Hi,

I've noticed the method of mailing series' of patches on this mailing
list, and I'd like to know a little more about how it's done, as I'm
considering how well it might work for us as a workflow and review process.

Particularly, where does the series of patches come from? Is this a
usage scenario for stacked git (something else I don't fully understand
the rationale behind as yet)? I'm imagining the developer has a local
branch to which he commits his changes, and then rebases resulting in
his branches being at the end of the local branch. How are they then
extracted and mailed out?

My next question, is supposing that the patches are reviewed and changes
suggested. How does the developer then go about amending, say the second
patch and getting the subsequent ones rebased off that? I'm assuming
there's a nice clever way of doing it that doesn't involve manually
messing with individual patch files etc.

Please excuse my ignorance: I'm still getting my head around this. Once
I do that I'm usually away and happy, but it takes a while for that
'click' moment to hit me sometimes :)

Thanks.

-- 

Russ
