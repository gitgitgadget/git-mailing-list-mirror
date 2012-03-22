From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 13:55:02 -0700
Message-ID: <CAJsNXTkEDr_bg3tCo-OOOzAe_5AVgoGV_9b0b3GOREzPE4Pg_Q@mail.gmail.com>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
	<4F6ACB67.1080503@viscovery.net>
	<4F6B0C3E.8090501@in.waw.pl>
	<20120322141245.GB8803@sigill.intra.peff.net>
	<7vbonozi8c.fsf@alter.siamese.dyndns.org>
	<20120322173701.GA11928@sigill.intra.peff.net>
	<7viphwxyp1.fsf@alter.siamese.dyndns.org>
	<4F6B84DF.8040806@in.waw.pl>
	<7vk42cwew5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:55:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAp2L-0006Uu-UV
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 21:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759916Ab2CVUzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 16:55:05 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:55374 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892Ab2CVUzD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 16:55:03 -0400
Received: by wejx9 with SMTP id x9so2177951wej.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5AjRJVIZiTzAmehORtLF+b1T5bhz02ic5EFajq8BcnY=;
        b=xO7EM609DctOm+6RDCOwU/Xg//Emt6UNUkVVi5KKF2yNsdn4HTBHkC2HCG7XBYvKa5
         X9pG9+LBGsC+ifGsVIyOTeVuiydsiX1M/5RXZ54Vb8cku9L8KSMFe8b/P7WKQ+fWVh8i
         bylBhcRCcFhJ5QG+VVMTSJ/3alt0I8Ga03gvRVrv7eeCw0rH4b2BPwOAhWLEQ8KH9tlO
         nI3/dqLJ+3o0mxqB4cOhTabU9LCxlygOzEJlc6q2RDzUvQQC8j8zJbjwzchL6ibKAbLz
         21a0ePzYZT0j7WRjNSRUwRUbcKP2W+lb748hLG9XrUN98xU4JR+nEMZNI+giMh8RrKIH
         wv1g==
Received: by 10.180.105.194 with SMTP id go2mr642634wib.22.1332449702437; Thu,
 22 Mar 2012 13:55:02 -0700 (PDT)
Received: by 10.223.160.1 with HTTP; Thu, 22 Mar 2012 13:55:02 -0700 (PDT)
In-Reply-To: <7vk42cwew5.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 2hL8uluGkmackASIauwpLIHhriQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193717>

2012/3/22 Junio C Hamano <gitster@pobox.com>:
> Zbigniew J=C4=99drzejewski-Szmek =C2=A0<zbyszek@in.waw.pl> writes:
>
>> Even this updated text does not say _what_ happens when
>> core.ignorecase is set on a case-insensitive filesystem.
>
> That was very much on purpose. We tell users not to do that, because =
it is
> calling for an undefined behaviour. And leaving it undefined gives us=
 a
> wiggle room to later do something better if we choose to.

Where do you tell users not to do that?  Nothing on the man page
actually says that the behavior is undefined, but it does seem to be
weird.  Rename default.asp to Default.asp, and Git reports that
default.asp was deleted, but doesn't mention Default.asp.  (Presumably
it sees Default.asp and decides that it's the same as default.asp,
which it already determined was deleted.  Like I said, weird.)

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
