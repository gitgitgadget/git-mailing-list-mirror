From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Take only numeric version components when
 computing $git_version
Date: Tue, 18 Jan 2011 21:47:42 +1100
Message-ID: <20110118104742.GA3279@brick.ozlabs.ibm.com>
References: <4D231646.5080005@debugon.org>
 <1294360953.21006.2.camel@fixed-disk>
 <4D2C5F3E.2020007@debugon.org>
 <20110113192243.GA20625@burratino>
 <4D355966.7090707@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Tue Jan 18 22:10:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfIpI-0007FF-NH
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab1ARVKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 16:10:47 -0500
Received: from ozlabs.org ([203.10.76.45]:50870 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab1ARVKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:10:47 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 46D57B7102; Wed, 19 Jan 2011 08:10:46 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <4D355966.7090707@debugon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165217>

On Tue, Jan 18, 2011 at 10:12:06AM +0100, Mathias Lafeldt wrote:
> Jonathan Nieder wrote:
> > [...]
> > So after building from a tarball generated with "git archive", "git version"
> > produces v1.7.4-rc1, producing errors from gitk, but after building
> > from the git repo or a tarball generated with "make dist", the version
> > is v1.7.4.rc1 (which gitk accepts).
> > 
> > Anders's fix looks good to me for robustness reasons anyway, so
> > 
> >  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> > 
> 
> OK then. Junio? :)

I'll pick it up.

Paul.
