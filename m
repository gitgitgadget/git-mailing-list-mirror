From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Ignore updates to files which are ignored, even if they're
 indexed.
Date: Wed, 18 May 2016 08:38:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605180830110.3477@virtualbox>
References: <CAK-5vhzvuwteJgWSkAhAAFf9-L4FSs2o58yNF5rQQrrE231d3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Josh McCullough <joshua.mccullough@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 08:39:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2v8H-0004aZ-NE
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 08:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbcERGi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 02:38:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:51885 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbcERGi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 02:38:57 -0400
Received: from virtualbox ([86.110.65.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MEWxh-1anq1U0IrR-00FigM; Wed, 18 May 2016 08:38:53
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAK-5vhzvuwteJgWSkAhAAFf9-L4FSs2o58yNF5rQQrrE231d3w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:bbBZHq57Yd8+8m4g3UoGigb0ZHf1I+xj09gcSJ1wJ9vCuI/pwg2
 KTB1AMByyPCIIhVMZTSrteGfaFxxkxH1+TSUcSBF9PUUT9t0iz3d+zNYh1yzRy2ZAwkE5st
 OvLjxY+pA8YuiywlHxvuGDv8fPPt//ePbmIt0YLF+CbutP7wjj3v5k7egCDVZHcMdB+caj2
 XZ5gQQXV4Q+82aXDO/2pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qUKONbH4YB4=:UmY+DWZwtLw9IFvCKp0jSc
 WwJbKLiAA183la3mgJkxF8fl86gAxRaqBDTixL/qtncrpHQMI4q+qoTKXvNvtTwi/EhhiatF1
 SCoWQFy+kFUcI4GEQRNi0FWsTNXZp86oi4eAF9AdpwOzzQPWD8UsOf3nPI0zw7kcnHOljS+YF
 jugt3Yp7pfpD9KsR7FpsnGp6EeC6Us53cgo1K76riohEqsjd67gnyjJfkRBhYvR1zfRgneu7i
 s3MKIJJmhtmTZHgXwEyuzAwXI3L9yipL7aIDDaTTIqFLU3zKg4cvTA7rDEuATzs8GWTVPUqN4
 71fOJyLtx5Y88FH6Uozp6FwtHiqLA6ft0VGGJXjOSmnlUKEjtHaQzrRXFLuykRqi/hcuZNRfg
 pFDN90N/oQdgfihjN5YcE4h1AOEWoVlsIX8aaHq8zq5jvcudqPrdhG0YwYgtuMPPAJm4K8Al3
 u6feuYnG2IxupQJdtxpowNtFcqt7PkQFeyjtzPz5b6TQtqp3NOAJ8KqNvHTyf1NNk1wJlgwdf
 x+0zCL3Zn+ZisAkBvvfz8S+Uh07ZdOdfoGN5/rWLmThJClfnzwdL8dMVGTdJ+PHHr3zvQQsMv
 uwv96rSu5zjC0w7OEpMFoc1xsaKxCpRsAdJiAv3vuH+Hvx7dQ2PUFelIbV5Jzs9ql+tOwPWzO
 SHC/FWA/clQO0sQFUvVX5ETC+jpNcsZRGOBEXoOgj5nadm6gbOm/9q7OVazmymx55IznNC0oG
 p3IpfdGrPXh8GGuWbH+BgMRljKweCalYLmPRSxz2g4PjnjT9xcidGMecLPr+YFhaQmB6Zqcb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294936>

Hi Josh,

On Tue, 17 May 2016, Josh McCullough wrote:

> TL;DR: Git should ignore files if they are in `.gitignore`, regardless
> of whether or not the file has changed (or been removed).

This would break at least one of my setups, where I was too lazy to add
negative rules to .gitignore.

I imagine that I am not the only one relying on the current behavior.
Which means that you would need to tread very carefully should you choose
to work on this.

Besides, it sounds like you want certain files to be "tracked a little",
and at the same time be "untracked a little".

Maybe there is a better solution. Would you care to describe your use case
in more detail, in particular the goal?

Ciao,
Johannes
