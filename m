From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 8 Sep 2009 23:57:34 +0200
Message-ID: <fabb9a1e0909081457q21d892fby66bdffc5b0199d32@mail.gmail.com>
References: <1252376822-6138-1-git-send-email-johan@herland.net> 
	<200909080512.34634.johan@herland.net> <7vd462qdeg.fsf@alter.siamese.dyndns.org> 
	<200909081054.02523.johan@herland.net> <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302> 
	<7vocplxjov.fsf@alter.siamese.dyndns.org> <20090908211046.GV1033@spearce.org> 
	<fabb9a1e0909081436x72c71b0bv51d8f198cd82f289@mail.gmail.com> 
	<20090908213944.GX1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:58:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml8hO-00057E-Nk
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbZIHV5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 17:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbZIHV5x
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:57:53 -0400
Received: from mail-ew0-f227.google.com ([209.85.219.227]:58461 "EHLO
	mail-ew0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbZIHV5w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 17:57:52 -0400
Received: by ewy27 with SMTP id 27so4085994ewy.40
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WAMV8uzRlf748AVTMMHJr+rQrlf4nI9FldsuLc7W/yU=;
        b=DlbOeRNC4hG60rnVeb5vt8KBJSbcajFUcV9PYZcQeYgfX6segYMzUvCasQbyxxgPRn
         PRVtucHM4T6ayODUC5lN4C2GmORdx4Yh1PUevtEHr8DBu2ct0qosRoYl4z+k517Y/V8Q
         iDzufd+1PytynII5xYnv5fPgsYVVaFwTG4er4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Vqe1sCG7/R7erITt7KAD0V0m6zprYpUWMulFQwD0ZfIAxQmu4ZhMjB3vnVo4HfUq37
         6gplnNCMvzVj//eEFFUn2u8RgpITrfygrif1gyHw/VJTp0xktBMR6OETkZ8XtPHZ2/qH
         Baam2+U7jB+xLXI2qjmyGjHv6pcvWHHmFgqBk=
Received: by 10.216.90.76 with SMTP id d54mr2127648wef.55.1252447074165; Tue, 
	08 Sep 2009 14:57:54 -0700 (PDT)
In-Reply-To: <20090908213944.GX1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128044>

Heya,

On Tue, Sep 8, 2009 at 23:39, Shawn O. Pearce<spearce@spearce.org> wrot=
e:
> Uh, but the natural way to index those is by commit, and each
> different revision of a change is a different commit. =A0Why delete
> the prior revision information and move it to the final commit note?

Ah, I didn't realize you would push the notes before the final revision=
 is made.

> Someone who has the prior revisions in their reflog and is doing
> `git log -g --notes` might want to see that annotation.

It would make more sense to have multiple notes then, but wouldn't you
want them to annotate the original commit, rather than the final one?

--=20
Cheers,

Sverre Rabbelier
