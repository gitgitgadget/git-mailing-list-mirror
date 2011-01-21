From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Fri, 21 Jan 2011 14:36:31 -0700
Organization: icecavern.net
Message-ID: <201101211436.32033.wjl@icecavern.net>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com> <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Montellese <emontellese@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 22:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgOf2-00038N-8z
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 22:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab1AUVgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 16:36:39 -0500
Received: from rinoa.icecavern.net ([92.243.7.152]:43572 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750889Ab1AUVgi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 16:36:38 -0500
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id D200535B27;
	Fri, 21 Jan 2011 14:36:34 -0700 (MST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165394>

On Friday, January 21, 2011 11:57:21 Eric Montellese wrote:
> To whet your appetite to read all of the below (I know it's long),
> this is the root of the solution:
> 
> ---       Don't track binaries in git.  Track their hashes.       ---

Comment from the peanut gallery:

I haven't read your approach in great detail, but just in case you are not 
aware, there is a project call git-annex <http://git-annex.branchable.com/> 
by Joey Hess that I believe takes a similar approach.

Since you've obviously given this a lot of thought, you might want to take a 
peek at that and see if it already does what you want, or if your proposal 
does something significantly different/better.
