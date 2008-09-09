From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: git apply vs. renamed files index mismatch
Date: Tue, 9 Sep 2008 11:06:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0809091105010.27142@vixen.sonytel.be>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
 <1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
 <48C57A92.6060608@freescale.com> <20080908212717.GA21338@oksana.dev.rtsoft.ru>
 <48C59B71.3040902@freescale.com> <20080908215441.GA924@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-517155090-1220951215=:27142"
Cc: Scott Wood <scottwood@freescale.com>, git@vger.kernel.org,
	linuxppc-dev@ozlabs.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 11:08:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KczCo-0007Be-6o
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 11:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbYIIJHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 05:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbYIIJHF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 05:07:05 -0400
Received: from vervifontaine.sonytel.be ([80.88.33.193]:40767 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754661AbYIIJHD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 05:07:03 -0400
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id C812258ADF;
	Tue,  9 Sep 2008 11:06:55 +0200 (MEST)
In-Reply-To: <20080908215441.GA924@oksana.dev.rtsoft.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95363>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-517155090-1220951215=:27142
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 9 Sep 2008, Anton Vorontsov wrote:
> On Mon, Sep 08, 2008 at 04:38:57PM -0500, Scott Wood wrote:
> > Anton Vorontsov wrote:
> >> I always thought that posting "-M" patches to the public lists is
> >> discouraged since it is quite difficult to apply them via patch(1).
> >> Also think of non-git users...
> >
> > I think the substantially enhanced reviewability trumps non-git-users  
> > who can follow the rename instructions manually (or fix up their patch  
> > utility) if they insist on shunning tools that would make their life 
> > easier.
> 
> Can't disagree, I myself use git. ;-) But I'm also using standard
> patch(1) to test occasional patches... And sometimes linux-X tree
> isn't tracked by git (e.g. -mm otm snapshots).
> 
> >> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> >> new file mode 100644
> >> index 0000000..ae5708e
> >> [...]
> >> diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
> >> deleted file mode 100644
> >> index ae5708e..0000000
> >>
> >> That is, if hashes match then it was pure rename.
> >
> > I suppose, though it's not as easy to spot, and won't help in showing  
> > what the differences are if there are any.
> 
> ..rename and changes ideally go in separate patches.

Except if the rename also requires some small changes (cfr. the move of
include/asm-*). But if no changes are required to fix breakage caused by the
rename, then make the changes separate.

> IIRC this also helps git to track renames (it can easily compare
> hashes instead of guessing).

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
---584349381-517155090-1220951215=:27142--
