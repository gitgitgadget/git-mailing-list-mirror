From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Mon, 25 Aug 2008 14:17:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808251415010.3893@vixen.sonytel.be>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
 <1219664940.9583.42.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-1218310624-1219666664=:3893"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	users@kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 14:19:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXb23-0004Qe-3n
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 14:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbYHYMRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 08:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbYHYMRq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 08:17:46 -0400
Received: from vervifontaine.sonytel.be ([80.88.33.193]:46414 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753434AbYHYMRp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 08:17:45 -0400
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 3012758AE0;
	Mon, 25 Aug 2008 14:17:44 +0200 (MEST)
In-Reply-To: <1219664940.9583.42.camel@pmac.infradead.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93615>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1218310624-1219666664=:3893
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 25 Aug 2008, David Woodhouse wrote:
> On Sat, 2008-08-23 at 20:33 -0700, Junio C Hamano wrote:
> > There is one alternative, and one augmentation:
> > 
> >  (A) We do not do anything.
> > 
> >  (B) In addition to the main transition plan, outside git, prepare an
> >      optional "git-old-style" package that installs many "git-foo"
> >      wrappers in $PATH (i.e. /usr/bin).  Each of them exec "git foo".
> >      People who like the dashed form can keep typing "git-foo", even
> >      though that will cost them two exec()s.
> 
>   (C) Just don't do it. Leave the git-foo commands as they were. They
>       weren't actually hurting anyone, and you don't actually _gain_
>       anything by removing them. For those occasional nutters who
>       _really_ care about the size of /usr/bin, give them the _option_
>       of a 'make install' without installing the aliases.

Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

BTW, now we have man pages for deprecated commands that are not in the default
PATH, which are showing examples for deprecated commands that are not in the
default PATH?

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-1218310624-1219666664=:3893--
