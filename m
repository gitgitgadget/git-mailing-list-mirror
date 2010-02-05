From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] add new options to git format-patch: --cover-subject and --cover-blurb
Date: Fri, 5 Feb 2010 15:53:27 -0700
Organization: icecavern.net
Message-ID: <201002051553.27315.wjl@icecavern.net>
References: <1265405973-5670-1-git-send-email-larry@elder-gods.org> <201002051526.18205.wjl@icecavern.net> <7vfx5fwbws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:53:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdX3U-0005KI-Hn
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 23:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933843Ab0BEWxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 17:53:34 -0500
Received: from rinoa.icecavern.net ([92.243.7.152]:39609 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757344Ab0BEWxd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 17:53:33 -0500
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id AFB3B36148;
	Fri,  5 Feb 2010 15:53:29 -0700 (MST)
User-Agent: KMail/1.12.4 (Linux/2.6.32-trunk-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <7vfx5fwbws.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139104>

On Friday 05 February 2010 15:33:23 Junio C Hamano wrote:
> The placeholder in particular and the cover letter itself in general are
> meant to be edited.  I do not see much point in forcing people to edit
>  yet another file and have them specify with an cover-blurb option.
> 
> Not very interested.

The original use-case is also pretty close to just doing the following:

$ git format-patch master..HEAD --cover-letter 
$ vi 0000-cover-letter.patch
$ git send-email --to my@mydomain.org *.patch
$ git send-email --to git@vger.kernel.org *.patch

Isn't that just as easy as the proposed --cover-* options?
