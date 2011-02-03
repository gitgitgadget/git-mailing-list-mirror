From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: big files in git was: Re: Features from GitSurvey 2010
Date: Thu, 03 Feb 2011 01:25:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102030118090.12104@xanadu.home>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
 <alpine.DEB.2.00.1102011443380.10088@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Feb 03 07:26:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pksdm-0001VB-T2
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 07:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab1BCGZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 01:25:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64435 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab1BCGZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 01:25:57 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG1005MH36U9ID0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Feb 2011 01:25:43 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.2.00.1102011443380.10088@asgard.lang.hm>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165962>

On Tue, 1 Feb 2011, david@lang.hm wrote:

> On Tue, 1 Feb 2011, Jakub Narebski wrote:
> 
> > There is also, supposedly stalled, git-bigfiles project.
> 
> why is the clean/smudge approach that came through the list a week or two ago
> not acceptable?

No idea.

I suppose that's because it is not complicated enough to actually be 
interesting.  This is like my suggestion for simply distributing bundles 
with BitTorrent.

> If nobody else has time to take those e-mails and create a set of clean/smudge
> scripts, I'll do so later this week (unless there is some reason why they
> wouldn't be acceptable)

Please do so.  The contrib directory would be a pretty good place to put 
them.

> I guess the only question is how to tell what files need to be handled this
> way, but can't we have something in .gitattributes about the file size?

Surely.  There is even a core.bigFileThreshold config variable already 
which could be reused right away for this purpose.


Nicolas
