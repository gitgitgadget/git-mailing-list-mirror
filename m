From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 20 Oct 2009 13:29:15 -0600
Organization: icecavern.net
Message-ID: <200910201329.16359.wjl@icecavern.net>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0KOh-00082P-96
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 21:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbZJTT3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 15:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbZJTT3T
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 15:29:19 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:57205 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751072AbZJTT3S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 15:29:18 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 95FE63686F;
	Tue, 20 Oct 2009 21:29:20 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.29-2-amd64; KDE/4.3.2; x86_64; ; )
In-Reply-To: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130829>

On Tuesday 20 October 2009 12:23:06 Thomas Rast wrote:
> git-pull has historically accepted full fetchspecs, meaning that you
> could do
> 
>   git pull $repo A:B
> 
> which would simultaneously fetch the remote branch A into the local
> branch B and merge B into HEAD.  This got especially confusing if B
> was checked out.  New users variously mistook pull for fetch or read
> that command as "merge the remote A into my B", neither of which is
> correct.

One thought here is that if the change you suggested (and I personally like) 
in your "[RFC] pull/fetch rename" thread was made, then I would expect to be 
able to run this exact command to have git fetch the remote branch A into 
the local branch B (with no merging taking place, because I didn't say --
merge). So basically, it would be like "git fetch $repo A:B" is now.

I readily agree that the *current* behavior of that command would have 
probably caught me off-guard, since I probably only would have typed that on 
accident (e.g. using "pull" when I meant "fetch").
