From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 03/13] Docs: send-email: Remove superfluous 
	information in CONFIGURATION
Date: Mon, 13 Apr 2009 17:30:59 -0500
Message-ID: <b4087cc50904131530p75cdc59cu57b6c0d697409d86@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
	 <7vljq4e10q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 00:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtUow-0008Qe-4V
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 00:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZDMWid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 18:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbZDMWic
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 18:38:32 -0400
Received: from mail-qy0-f117.google.com ([209.85.221.117]:62770 "EHLO
	mail-qy0-f117.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbZDMWib convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 18:38:31 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2009 18:38:30 EDT
Received: by qyk15 with SMTP id 15so193551qyk.33
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 15:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZvYGkJE/vtPehG8TlJYNTrII3kBUdloUiTc5x3hgcVw=;
        b=ZvzzvUb4motVd1+GdUNJkhjL58dKqpaGLyEWJifNh7r6xuOQMbSPNV/S5GFvpmbJwz
         lQean61OJ5ASBn+oYIzSLFhh3MtC6e2qtgkmapNE40rxSDDTStyGYFwe5SIZFAErBdBw
         loSt6nEZR0NKXcEs1etdRptLryTouwY3/ch6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a1+/OjP6mV7lVXAKG9jli/aza/xKWphUYuFJzu4eUOFC6PMX5p+qzs5JdZmG+BsJoQ
         Ni88OQ0u4mnW0N3ZT4kKqTRHAAxA+bPcn0GBiq2FlsrrpKZG+72z4WhqI3Q+QPOXFl71
         ORq8siTYuj0huKeL/5xMMr5nCElLO1UehxM6U=
Received: by 10.224.37.68 with SMTP id w4mr6738780qad.310.1239661859823; Mon, 
	13 Apr 2009 15:30:59 -0700 (PDT)
In-Reply-To: <7vljq4e10q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116498>

On Mon, Apr 13, 2009 at 15:45, Junio C Hamano <gitster@pobox.com> wrote=
:
> I am not sure if this is a good idea. =A0It may look "superfluous" fo=
r
> people who read the manual cover-to-cover.

People don't do this? How else are you supposed to know what's going on=
?

> However, a new person whose
> mentor allowed her to peek into his configuration to learn tricks fro=
m may
> find sendemail.confirm and would try to find an entry in the manual. =
=A0The
> change in this patch will make it inconvenient to go from variable to
> description.

Well, couldn't she search? I doubt she'd try to look in the CONFIGURATI=
ON
section anyway. I certainly wouldn't know about it without more experie=
nce.

Anyway, it's actually how this man page has been organized for a while;=
 you'll
notice that the CONFIGURATION section is pretty empty.

Perhaps the CONFIGURATION section should at least reference the associa=
ted
command line argument, where a description can be found.
