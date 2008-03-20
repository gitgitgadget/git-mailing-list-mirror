From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC] git-bisect unsure
Date: Thu, 20 Mar 2008 08:51:41 +0100
Message-ID: <200803200851.41466.chriscool@tuxfamily.org>
References: <CE6D7D80-DC0F-4840-8B95-7482EE0E71A3@gmail.com> <7vod9az00w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 08:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcFU9-0003uH-Uj
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 08:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbYCTHqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2008 03:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbYCTHqI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 03:46:08 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60817 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755815AbYCTHqH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 03:46:07 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 21BE51AB2C8;
	Thu, 20 Mar 2008 08:46:06 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F22D51AB2DB;
	Thu, 20 Mar 2008 08:46:05 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vod9az00w.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77640>

Le jeudi 20 mars 2008, Junio C Hamano a =E9crit :
> "Rhodes, Kate" <masukomi@gmail.com> writes:
> > My proposal is to add an "unsure" option to git-bisect.
> >
> > I'm thinking that when you say "git bisect unsure" it would simply
> > shift one commit earlier or later and refrain from ever checking ou=
t
> > one marked unsure until there were only "unsure" ones left at which
> > point it would add a disclaimer when you called bad or good and thr=
ow
> > up it's hands in frustration if you were to say "unsure" again.
>
> Patches welcome.
>
> ^L
>
> But if this is what you are trying to say:
>
>     6ca8b97 (Bisect: add "skip" to the short usage string., 2007-10-2=
9)
>
> you are about 4.5 months late ;-).

Yeah, it seems that "bisect skip" should do the job.

Thanks,
Christian.
