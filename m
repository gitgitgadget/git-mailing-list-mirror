From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] am: allow some defaults to be specified via git-config
Date: Mon, 19 Oct 2009 11:49:13 -0600
Organization: icecavern.net
Message-ID: <200910191149.13698.wjl@icecavern.net>
References: <1255650627-17576-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nigel McNie <nigel@catalyst.net.nz>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Oct 19 19:49:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzwMI-0001Hi-VS
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 19:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbZJSRtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 13:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbZJSRtQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 13:49:16 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:51517 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753787AbZJSRtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 13:49:16 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 37153359E4;
	Mon, 19 Oct 2009 19:49:17 +0200 (CEST)
User-Agent: KMail/1.12.0 (Linux/2.6.29-2-amd64; KDE/4.3.0; x86_64; ; )
In-Reply-To: <1255650627-17576-1-git-send-email-sam.vilain@catalyst.net.nz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130720>

On Thursday 15 October 2009 17:50:27 Sam Vilain wrote:
> +am.*::
> +	Specify defaults for linkgit:git-am[1].  Currently, the three
> +	boolean options, 'sign', 'utf8' and 'keep' may be specified.
> +

The 'git am' option is 'signoff', not 'sign'. Shouldn't the command option 
and config option names match?
