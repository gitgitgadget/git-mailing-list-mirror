From: Elijah Newren <newren@gmail.com>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 16:28:35 -0600
Message-ID: <51419b2c0906101528k66d99f7avfbb5adb8972a6fe1@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	 <4A2F0B8A.9010203@vilain.net>
	 <7vws7khlvj.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.0906092252210.31536@xanadu.home>
	 <7vab4fn7dm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Sam Vilain <sam@vilain.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 00:34:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEWMv-0008LD-TE
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 00:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371AbZFJWdi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 18:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757231AbZFJWdi
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 18:33:38 -0400
Received: from mail-qy0-f191.google.com ([209.85.221.191]:63040 "EHLO
	mail-qy0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206AbZFJWdi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 18:33:38 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2009 18:33:37 EDT
Received: by qyk29 with SMTP id 29so1577135qyk.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 15:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vL9vlNhNWjEhHtgbei4yHuffPgZ4exPigQBzbZ3SAJc=;
        b=P/L/Q6XjA3WK7zyU3STm9MmNGe9CYW06rdq2WgEaZdYIytWNCaHszMaDNNyszrYc0F
         gEfT3p0CZcegxv/VkXUs9r361qZG+hfX0BudvQh2Q4k4BiqDILeBsSerSDPY1Jv9dXo3
         QwbraxtODbksXNpZqNbp1bDJ6LugXb9aYw2Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vQyJU78ff8dFge3PUNaheEeghts/86rCnvyvXf8RzsiH9tJAWMnLPI6ar6Iqfbchle
         tXCbx/+1Mpe88LWJqfUccs++XyulM3j/DRRuIr8k+jOgRamQAYZqsGCthjt+MXYu5jsX
         Y09itp6Xiqutyp7rBw1AO1raPYcnBGqugsJH4=
Received: by 10.231.17.199 with SMTP id t7mr866896iba.46.1244672915776; Wed, 
	10 Jun 2009 15:28:35 -0700 (PDT)
In-Reply-To: <7vab4fn7dm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121314>

On Wed, Jun 10, 2009 at 2:47 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> As long as the "fork" is feature complete and the user does not have =
to
> resort to git-core, even though it may share the same issue of user b=
ase
> division, at least that would _help_ the users who choose the forked =
one,
> who does not have to know the old-timer lingo and concepts. =C2=A0It =
would be a
> much better solution than adding stupid synonyms to the existing syst=
em.
>
> But coming up with a consistent and complete fork that does not show
> git-core (not just phrases but also underlying concepts) is a lot of =
work.
> That is the primary reason why nobody did "gh".

What would you think of adding eg to contrib?
