From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: Symbolic 'references' in Git?
Date: Thu, 14 Apr 2011 16:22:39 -0600
Organization: icecavern.net
Message-ID: <201104141622.39491.wjl@icecavern.net>
References: <BANLkTinV8niLibzOQRVraYqwB0hKW1=r1w@mail.gmail.com> <201104141524.15212.wjl@icecavern.net> <BANLkTik5tD5UOrDkpL8ahEgwFjT+suHACQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:22:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAUw5-0004lD-Vm
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 00:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab1DNWWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 18:22:45 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:47157 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753744Ab1DNWWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 18:22:44 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 60658359BE;
	Thu, 14 Apr 2011 16:22:41 -0600 (MDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <BANLkTik5tD5UOrDkpL8ahEgwFjT+suHACQ@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171568>

On Thursday, April 14, 2011 15:31:13 Chris Patti wrote:
> On Thu, Apr 14, 2011 at 5:24 PM, Wesley J. Landaker <wjl@icecavern.net> 
wrote:
> > Why not just use a tag or a branch ?
> 
> Won't either of those things create a 'next-release' that's frozen in
> time where the release-3.15 branch is *right now*?
> 
> This is for a CI system (Bamboo) so we need next-release to act as if
> we were using release-3.15 itself.

Yes, you are right, but I was thinking about how I usually see it done and 
do it in my projects is that "next-release" is what you always are working 
on, and "release-3.15" would only be made when 3.15 is finalized.

It sounds like you are doing it the other way around, in which case I agree 
that being able to easily share symbolic-refs would be solve the problem -- 
but I don't know how to do that, other than, say, a hook script that 
everyone uses.

Maybe someone else will chime in with a better solution? =)
