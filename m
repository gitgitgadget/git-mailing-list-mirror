From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 01 Feb 2011 16:51:08 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
 <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
 <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:51:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkO83-00017u-8b
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab1BAVvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:51:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17041 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab1BAVvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:51:08 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFY0077AKOJWUF0@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 Feb 2011 16:50:43 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165865>

On Tue, 1 Feb 2011, Shawn Pearce wrote:

> On Tue, Feb 1, 2011 at 09:11, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > Narrow/Subtree clone is still just an idea, but can pack cache support
> > be made to resumable initial narrow clone too?
> 
> This would be very hard to do.  We could do cached packs for a popular
> set of path specifications (e.g. Documentation/ if documentation only
> editing is common), but once we start getting random requests for path
> specifications that we cannot predict in advance and pre-pack we'd
> have to fall back to the normal enumerate code path.

Also... people interested in Narrow clones are likely to be shallow 
clone users too, right?


Nicolas
