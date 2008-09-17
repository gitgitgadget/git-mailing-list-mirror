From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 20:25:09 -0500
Message-ID: <_MhavOIoKmx4_xVm-blejLMi-eFa1T8Huv94Uz9PxwJ3DyOMzuyUeg@cipher.nrlssc.navy.mil>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net> <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com> <20080916234624.GA14405@coredump.intra.peff.net> <alpine.LNX.1.10.0809161900340.17105@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Arjen Laarhoven <arjen@yaph.org>,
	git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 03:27:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kflox-0006Uu-5P
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 03:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbYIQBZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 21:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbYIQBZs
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 21:25:48 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39090 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbYIQBZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 21:25:48 -0400
Received: by mail.nrlssc.navy.mil id m8H1PA9k007051; Tue, 16 Sep 2008 20:25:10 -0500
In-Reply-To: <alpine.LNX.1.10.0809161900340.17105@suse104.zenez.com>
X-OriginalArrivalTime: 17 Sep 2008 01:25:10.0090 (UTC) FILETIME=[39B79AA0:01C91864]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96064>

Boyd Lynn Gerber wrote:

> So with path set so my /usr/gnu/bin/ is before any others this is what I
> get as the next failure.  After a long run...
> 
> * FAIL 5: alternation in pattern
> 
>                 git config diff.java.funcname "^[
> ]*\(\(public\|static\).*\)$"
>                 git diff --no-index Beer.java Beer-correct.java |
>                 grep "^@@.*@@ public static void main("
> 
> 
> * failed 1 among 5 test(s)
> gmake[1]: *** [t4018-diff-funcname.sh] Error 1
> gmake[1]: Leaving directory `/home/zenez/build/osr6/git-1.6.0.2/t'
> gmake: *** [test] Error 2

That's the one, thanks.

And just so you know, this isn't a regression. It's just a new test that
was designed to reveal a shortcoming that no one knew existed before Arjen
discovered it.

-brandon
