From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Whitespace and '&nbsp'
Date: Thu, 26 May 2011 15:08:44 -0700
Message-ID: <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com> <7vzkm9unu0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 00:09:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPijy-0006CD-QE
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 00:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210Ab1EZWJJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 18:09:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50624 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755301Ab1EZWJI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 18:09:08 -0400
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4QM96c8025681
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 26 May 2011 15:09:07 -0700
Received: by ewy4 with SMTP id 4so421197ewy.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 15:09:04 -0700 (PDT)
Received: by 10.14.50.3 with SMTP id y3mr472921eeb.225.1306447744147; Thu, 26
 May 2011 15:09:04 -0700 (PDT)
Received: by 10.14.127.70 with HTTP; Thu, 26 May 2011 15:08:44 -0700 (PDT)
In-Reply-To: <7vzkm9unu0.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-102.98 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174583>

On Thu, May 26, 2011 at 2:57 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> But in the longer term, I think we should find what MUA causes this
> breakage and yell at them. It might be some mail relays, but I am not=
 sure
> where these come from. =A0I often see alternating real whitespace and=
 nbsp
> in "> " indented quotes.

In this case, it was

  Content-Type: text/plain; charset=3Dutf-8
  Content-Disposition: inline
  Content-Transfer-Encoding: 8bit
  User-Agent: Mutt/1.5.21 (2010-09-15)

so there was nothing odd in the MUA. And everything I have (gmail in
web browser, less, gnome-terminal) treats the nbsp as a regular space,
so it doesn't show up as any inverted block or anything like that for
me until I tried to compile it.

It could easily have been there in the patch originally and wasn't
compile-tested. On some keyboard layouts, AltGr+space gives a nbsp.

                        Linus
