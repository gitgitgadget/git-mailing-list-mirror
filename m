From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: New repo quickly corrupted
Date: Sat, 17 Nov 2007 15:13:37 +0100
Message-ID: <200711171513.38243.robin.rosenberg.lists@dewire.com>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com> <473D4827.1060109@op5.se> <200711171353.45310.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Nov 17 15:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItOOi-0007aF-EV
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 15:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbXKQOLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2007 09:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbXKQOLb
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 09:11:31 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11786 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbXKQOLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 09:11:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 301DE8026FF;
	Sat, 17 Nov 2007 15:02:21 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24567-07; Sat, 17 Nov 2007 15:02:20 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id C0E6F802670;
	Sat, 17 Nov 2007 15:02:20 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200711171353.45310.chriscool@tuxfamily.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65280>

l=F6rdag 17 november 2007 skrev Christian Couder:
> Le vendredi 16 novembre 2007, Andreas Ericsson a =E9crit :
> > Christian Couder wrote:
> > > Le jeudi 15 novembre 2007, Linus Torvalds a =E9crit :
> > >> On Thu, 15 Nov 2007, Nicolas Pitre wrote:
> > >>> Does "dos2unix" override file access bits?  Because the object =
store
> > >>> is always made read-only.
> > >>
> > >> Almost all programs like that will entirely ignor the fact that
> > >> something is read-only.
> > >
> > > What if the .git/objects/ sudirectories were also read-only ?
> >
> > Then git wouldn't be able to write to it without chmod()'ing it eac=
h
> > time.
>=20
> Yes, but some (not manly enough) people might want the extra safety e=
ven if=20
> it means a performance penalty.

Those do manly enough to do run find . -exec  ;)

-- robin
