From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] Documentation: indent-with-non-tab uses tabwidth setting, not just 8
Date: Mon, 17 Sep 2012 08:20:28 -0600
Organization: icecavern.net
Message-ID: <201209170820.28489.wjl@icecavern.net>
References: <1347815548-19305-1-git-send-email-wjl@icecavern.net> <7v392hxm94.fsf@alter.siamese.dyndns.org> <7v8vc9w5hq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 16:20:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDcBr-0004Vi-8m
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 16:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329Ab2IQOUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 10:20:38 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:51126 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754663Ab2IQOUh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 10:20:37 -0400
Received: from tonberry.icecavern.net (c-76-113-27-84.hsd1.nm.comcast.net [76.113.27.84])
	by icecavern.net (Postfix) with ESMTPSA id 2A79935C24;
	Mon, 17 Sep 2012 08:20:34 -0600 (MDT)
User-Agent: KMail/1.13.7 (Linux/3.4-trunk-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7v8vc9w5hq.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205691>

On Monday, September 17, 2012 00:03:29 Junio C Hamano wrote:
> An alternative would be to lose the "8" (or `tabwidth`) from that
> description.  I've always thought that the description of `tabwidth`
> is clear enough that "8" in the patch is not a hardcoded non-overridable
> value but is merely a default, but after reading that section a few
> more times, I no longer think that is the case.
> 
> I originally wrote "8 or more space" but that wasn't because I
> thought it was important to stress "8 is the default", but because I
> didn't think of a better way to say what I wanted to say, which was
> "if you are filling the indentation with spaces when you could have
> just typed a tab with a few spaces, this error triggers", in other
> words "use of this is to encourage indenting with tabs".

Okay, I'm going to generated a new patch that hopefully reads better!
