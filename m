From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: RFE: "git bisect reverse"
Date: Wed, 27 May 2009 07:26:59 +0200
Message-ID: <200905270726.59883.chriscool@tuxfamily.org>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> <4A1CBF7A.3090708@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed May 27 07:27:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Bfc-0006c6-Mv
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 07:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759546AbZE0F1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 01:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759274AbZE0F1I
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 01:27:08 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:51999 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759169AbZE0F1H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 01:27:07 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id E2556D4803C;
	Wed, 27 May 2009 07:27:02 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 09C49D48044;
	Wed, 27 May 2009 07:27:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4A1CBF7A.3090708@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120033>

Le Wednesday 27 May 2009, H. Peter Anvin a =C3=A9crit :
> Sam Vilain wrote:
> > Oh, yes.  And another thing: 'git bisect run' / 'git bisect skip'
> > doesn't do a very good job of skipping around broken commits (ie wh=
en
> > the script returns 126).  It just seems to move to the next one; it
> > would be much better IMHO to first try the commit 1/3rd of the way =
into
> > the range, then if that fails, the commit 2/3rd of the way through =
it,
> > etc.
>
> I posted about that last year:
>
> http://marc.info/?l=3Dgit&i=3D48F3DCEB.1060803@zytor.com
>
> At the time, git bisect was still done in the shell and it was deemed
> too difficult.

Yeah, this was also asked by Ingo, and yeah, I think it should be easie=
r to=20
do now that most of the "git bisect next" shell code has been ported to=
 C.

I will try to have a look at it soon.

Best regards,
Christian.
