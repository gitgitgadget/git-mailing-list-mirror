From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: New repo quickly corrupted
Date: Sat, 17 Nov 2007 13:53:45 +0100
Message-ID: <200711171353.45310.chriscool@tuxfamily.org>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com> <200711160645.04352.chriscool@tuxfamily.org> <473D4827.1060109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 17 13:49:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItN6i-0001uY-Na
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 13:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbXKQMrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2007 07:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbXKQMrG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 07:47:06 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:47368 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbXKQMrF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2007 07:47:05 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A13CD1AB2E7;
	Sat, 17 Nov 2007 13:47:01 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3A5231AB2A8;
	Sat, 17 Nov 2007 13:47:01 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <473D4827.1060109@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65271>

Le vendredi 16 novembre 2007, Andreas Ericsson a =E9crit :
> Christian Couder wrote:
> > Le jeudi 15 novembre 2007, Linus Torvalds a =E9crit :
> >> On Thu, 15 Nov 2007, Nicolas Pitre wrote:
> >>> Does "dos2unix" override file access bits?  Because the object st=
ore
> >>> is always made read-only.
> >>
> >> Almost all programs like that will entirely ignor the fact that
> >> something is read-only.
> >
> > What if the .git/objects/ sudirectories were also read-only ?
>
> Then git wouldn't be able to write to it without chmod()'ing it each
> time.

Yes, but some (not manly enough) people might want the extra safety eve=
n if=20
it means a performance penalty.

Christian.
