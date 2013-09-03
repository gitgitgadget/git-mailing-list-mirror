From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Remote's 'currently active branch' not HEAD?
Date: Tue, 3 Sep 2013 15:02:50 +0200
Message-ID: <20130903130250.GB20459@pc.elego.de>
References: <20130903104652.GA5813@inner.h.apk.li>
 <20130903114831.GA8559@inner.h.apk.li>
 <20130903123733.GR12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 15:08:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGqLS-0004dD-RU
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 15:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759988Ab3ICNIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 09:08:30 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:58712 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050Ab3ICNI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 09:08:29 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2013 09:08:29 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id E6785DF867;
	Tue,  3 Sep 2013 15:02:52 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DrWmosmZsYR6; Tue,  3 Sep 2013 15:02:52 +0200 (CEST)
Received: from localhost (unknown [10.10.10.226])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id BCCAADF866;
	Tue,  3 Sep 2013 15:02:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130903123733.GR12966@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233723>

On Tue, Sep 03, 2013 at 02:37:33PM +0200, Andreas Krey wrote:
> On Tue, 03 Sep 2013 13:48:31 +0000, Andreas Krey wrote:
> ...
> > I now have a sample repo that reproduces this behaviour.
> > Unpack tar file, clone, see clone having 'wrong' branch
> > checked out, apparently independent of the transport:
> 
> Ouch, it looks like 'git clone' doesn't actually know
> the 'current remote branch' but picks one of those that
> happen to have the HEAD *commit* as their tip.

Yes, it picks the first of those:

http://thread.gmane.org/gmane.comp.version-control.git/168144

> At least the 'git clone' doc would be misleading then.
