From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Tue, 18 Sep 2012 14:42:28 -0600
Organization: icecavern.net
Message-ID: <201209181442.29010.wjl@icecavern.net>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com> <98180D4AA94C468887029389CC535D4F@PhilipOakley> <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Philip Oakley" <philipoakley@iee.org>,
	"Git List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE4dA-0004cv-8J
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 22:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab2IRUmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 16:42:42 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:38633 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755002Ab2IRUmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 16:42:40 -0400
Received: from tonberry.icecavern.net (c-76-113-27-84.hsd1.nm.comcast.net [76.113.27.84])
	by icecavern.net (Postfix) with ESMTPSA id 8F96E35FCF;
	Tue, 18 Sep 2012 14:42:34 -0600 (MDT)
User-Agent: KMail/1.13.7 (Linux/3.4-trunk-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205870>

On Monday, September 17, 2012 17:49:39 Junio C Hamano wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
> > I then applied it (using git am) to a temp branch to see what it
> > produced, and could repeat the cycle until the patches looked right.
> 
> That's another obvious and valid way to prepare your series.  It all
> depends on how comfortable you are to directly edit patches.  Some
> people fear it.  Some don't.  Some can do it with their eyes closed ;-).
> 
> > However, when it came to creating the series, with comments, I
> > couldn't see a way of having my comments within my local commits, but
> > preparing a patch series that would properly include the '---'
> > separator.
> 
> An unofficial trick that works is to write the
> 
>     ---
> 
>      * This is an additional comment
> 
> 
> yourself when running "git commit".  That will be propagated to the
> output from format-patch.  You will have another "---" in front of
> the diffstat, but nobody is hurt by that.

One thing I have done is to add the additional comments I want with "git 
notes", then give the "--notes" option to format-patch or send-email.

Unfortunately, this sticks the notes right into the commit message section, 
because the "--notes" option is actually a diff option, not something 
format-patch knows about, so you have to make sure to manually move it.

But even so, I've found it a a nice way to track comments.
