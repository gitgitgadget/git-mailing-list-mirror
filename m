From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 01 Feb 2011 21:11:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102012110320.8580@xanadu.home>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
 <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
 <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com>
 <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
 <AANLkTikaztSn+xQ3xT7d-3-Yghk69qXXN1DRg9h+kEHx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Q1bQXMK9bLGtowVEDPVRPQ)"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 03:12:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkSCT-0006JZ-Gp
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 03:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab1BBCL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 21:11:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38539 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1BBCL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 21:11:57 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFY00EPZWR1RE00@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 Feb 2011 21:11:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTikaztSn+xQ3xT7d-3-Yghk69qXXN1DRg9h+kEHx@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165884>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Q1bQXMK9bLGtowVEDPVRPQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 1 Feb 2011, Shawn Pearce wrote:

> On Tue, Feb 1, 2011 at 13:51, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 1 Feb 2011, Shawn Pearce wrote:
> >
> >> On Tue, Feb 1, 2011 at 09:11, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> >> > Narrow/Subtree clone is still just an idea, but can pack cache support
> >> > be made to resumable initial narrow clone too?
> >>
> >> This would be very hard to do.  We could do cached packs for a popular
> >> set of path specifications (e.g. Documentation/ if documentation only
> >> editing is common), but once we start getting random requests for path
> >> specifications that we cannot predict in advance and pre-pack we'd
> >> have to fall back to the normal enumerate code path.
> >
> > Also... people interested in Narrow clones are likely to be shallow
> > clone users too, right?
> 
> I think that depends.  Some users might want the full history of the
> files they are working on.  Others wouldn't care and just want the tip
> revision so they can make changes.  Obviously a shallow clone of depth
> 1 is very cheap to implement on the server; there really isn't any
> caching required.
> 
> Probably 50% want full history, 50% want shallow clone.  So I doubt we
> can assume that narrow implies shallow and thus is cheap.  :-(

Let's see what happens when this gets used in the wild.


Nicolas

--Boundary_(ID_Q1bQXMK9bLGtowVEDPVRPQ)--
