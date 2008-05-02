From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH] gitk: disable "Reset %s branch to here" when on a detached head
Date: Fri, 2 May 2008 16:56:57 +0200
Message-ID: <200805021656.57929.barra_cuda@katamail.com>
References: <200803181535.53635.barra_cuda@katamail.com> <18459.3700.934377.597975@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri May 02 16:55:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrwfB-0005yB-5h
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 16:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbYEBOyQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 10:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755824AbYEBOyQ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 10:54:16 -0400
Received: from smtp.katamail.com ([62.149.157.154]:49935 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752797AbYEBOyP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 10:54:15 -0400
Received: (qmail 14632 invoked by uid 89); 2 May 2008 14:49:08 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host198-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.198)
  by smtp2-pc with SMTP; 2 May 2008 14:49:07 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <18459.3700.934377.597975@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81006>

On Friday 02 May 2008, Paul Mackerras wrote:
> > -=A0=A0=A0=A0=A0$menu entryconfigure 7 -label [mc "Reset %s branch =
to here" $mainhead]
> > +=A0=A0=A0=A0=A0if {$mainhead ne {}} {
> > +=A0=A0=A0=A0=A0 =A0 =A0$menu entryconfigure 7 -label [mc "Reset %s=
 branch to here" $mainhead]
> > +=A0=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0 =A0 =A0$menu entryconfigure 7 -label [mc "Reset %s=
 branch to here" $mainhead] -state disabled
>=20
> I wonder if we can make this message something more appropriate than
> "Reset =A0branch to here" (since $mainhead has to be the empty string
> here)? =A0Not sure what I would suggest though. :)

Oh, you're right. I'd say either "Reset detached head to here" greyed o=
ut
(i.e. change the words as little as possible), or something more
explicative like "Detached head: reset not possible". I'd go for the fi=
rst,
but I'm really not sure about this: you'd better seek suggestions from =
a
native speaker :).
