From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH 1/5] Allow alternate "low-level" emit function from xdl_diff
Date: Sun, 24 Aug 2008 03:12:54 -0500
Message-ID: <20080824081254.GI31114@lavos.net>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net> <1219360921-28529-2-git-send-email-bdowning@lavos.net> <48AFC73F.2010100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 24 10:14:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXAje-0005FF-Os
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 10:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbYHXINB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Aug 2008 04:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbYHXINB
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 04:13:01 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:35658
	"EHLO QMTA04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752422AbYHXINA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Aug 2008 04:13:00 -0400
Received: from OMTA02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by QMTA04.westchester.pa.mail.comcast.net with comcast
	id 68Cv1a0020QuhwU548Cvbw; Sun, 24 Aug 2008 08:12:55 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA02.westchester.pa.mail.comcast.net with comcast
	id 68Cu1a0044BqYqi3N8Cu3T; Sun, 24 Aug 2008 08:12:55 +0000
X-Authority-Analysis: v=1.0 c=1 a=zlwB17LTd-8A:10 a=KdOwoapOtMEA:10
 a=D4u4CS71Ku_-nJbAVaIA:9 a=Gmtp1IS3VnSbDtZWygocz2dmBTgA:4 a=LY0hPdMaydYA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id 6FD22309F23; Sun, 24 Aug 2008 03:12:54 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <48AFC73F.2010100@lsrfire.ath.cx>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93520>

On Sat, Aug 23, 2008 at 10:15:59AM +0200, Ren=E9 Scharfe wrote:
> Could we move more code into the library code to avoid that ugliness?
>=20
> AFAICS, compare_buffer() builds a struct patch with an array of
> struct chunks, whose members are then fed one by one into either
> blame_chunk() or handle_split().  Could we avoid the allocation
> altogether by using a different interface?

Thanks, I think this is a good idea.  I'll try to work up something lik=
e
this, but it may be a few days before I have any appreciable hacking
time to do so.

-bcd=20
