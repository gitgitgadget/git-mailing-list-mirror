From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] add new options to git format-patch: --cover-subject and --cover-blurb
Date: Fri, 5 Feb 2010 15:26:17 -0700
Organization: icecavern.net
Message-ID: <201002051526.18205.wjl@icecavern.net>
References: <1265405973-5670-1-git-send-email-larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:26:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdWdB-0002Y0-DB
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 23:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933926Ab0BEW0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 17:26:24 -0500
Received: from rinoa.icecavern.net ([92.243.7.152]:57862 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933915Ab0BEW0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 17:26:23 -0500
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id B876736148;
	Fri,  5 Feb 2010 15:26:20 -0700 (MST)
User-Agent: KMail/1.12.4 (Linux/2.6.32-trunk-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <1265405973-5670-1-git-send-email-larry@elder-gods.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139101>

On Friday 05 February 2010 14:39:33 Larry D'Anna wrote:
> This is useful because if you're preparing a patch series with a cover
>  letter you can easily put together one line to format and email the
>  whole thing to yourself.  You check to make sure everything is right,
>  and then just change the recipient address and run it again.
> 
> git send-email --to my@mydomain.org  master..HEAD --cover-letter \
>     --cover-subject "this is my patch series" --cover-blurb "$(cat
>  blurb.txt)"

One (minor?) issue is that the cover blub would be limited to the maximum 
allowed length of the command-line arguments set by the shell or OS. Since 
you are just catting a file, maybe "--cover-blub-file" would be better?

Just a thought.
