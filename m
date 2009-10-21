From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [RFC] pull/fetch rename
Date: Tue, 20 Oct 2009 20:01:43 -0600
Organization: icecavern.net
Message-ID: <200910202001.44079.wjl@icecavern.net>
References: <200910201947.50423.trast@student.ethz.ch> <200910210053.29794.trast@student.ethz.ch> <7v7huplkyj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 04:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0QWa-0007tf-1b
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 04:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbZJUCBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 22:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbZJUCBw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 22:01:52 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:52153 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750914AbZJUCBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 22:01:52 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 90CA93686F;
	Wed, 21 Oct 2009 04:01:51 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.29-2-amd64; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7v7huplkyj.fsf@alter.siamese.dyndns.org>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130878>

On Tuesday 20 October 2009 17:11:32 Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > Junio C Hamano wrote:
> >> "Wesley J. Landaker" <wjl@icecavern.net> writes:
> >
> > ...
> > There would not be a configuration option.
> > ...
> >
> >> It's not even funny.
> 
> Re-read what you were responding to and notice that I was commenting on
> Wesley's proposal that _is_ about a configuration variable.

Yes, I brought up the configuration variable, not Thomas. 

My main goal was to try to suggest a transition plan that would be less 
painful, but maybe it was actually worse. After reading Junio's response I 
think I agree that going down that path might be the worst of both worlds, 
but the basic model I was proposing (even if it's a bad idea in this case) 
was largely basing on (my perceived impression of) how the recent changes to 
push behavior were staged (i.e. with deprecation, new configuration 
variables, etc).

I still think that, long term, making push and pull symmetric, EITHER by 1) 
making push also update the working tree (in some sane way that I don't have 
a proposal for) or 2) making pull be just about transfering objects, not 
also merging (in some reasonable way that doesn't break useability, like 
also adding "git update" or something at the same time) would be an overall 
benefit.
