From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: ks/precompute-completion
Date: Fri, 23 Oct 2009 14:16:59 -0500
Message-ID: <fabb9a1e0910231216j2a024ac5mf5b5ccb5322722f8@mail.gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <4AE0190E.8020803@gmail.com> 
	<fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com> 
	<4AE0DAB3.1030103@gmail.com> <fabb9a1e0910221555k287b45ebwb15ac97851b845f9@mail.gmail.com> 
	<fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com> 
	<4AE0E542.8010501@gmail.com> <fabb9a1e0910231127i3ab469qebdc17168a58f22a@mail.gmail.com> 
	<7vd44eaqc5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 21:17:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Pdm-0000Yi-Sg
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 21:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbZJWTRQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 15:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbZJWTRQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 15:17:16 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:52030 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbZJWTRP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 15:17:15 -0400
Received: by ewy4 with SMTP id 4so1941863ewy.37
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6+T0tTZ+6xzXKc543wOQoWZuN4oO7xqIsnxnHpFJhXA=;
        b=XeO4tTebRQldaj86E5hmYKkSw1iVKq2oCrvwQSrKFhkvxIdMoKGXalgTauifK3rZ+8
         DSG3cD2Q96hGS+2O12hizwf3LSQHFY1INIEzyw3lVtIfijPOBsgveVfRF2PR5DI13QA4
         I+C4OgER4kOBQNS2DqiDkDQFPNI+ssftNzkgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UmCG+hn6kpg0wbKRcJYbO4p2KPzPrRlHdcotU5ESLumZlAB0ZEm/KoO6STrrQBHRU7
         vqdGT5LwUelcsIyYdS2N7MmFKVLnLSZ5wZNYZX9vlb4XQHkgE59h2ppuArfvWzajCUqo
         pSIL+RM7QF3J/f7C90tusnVRCvjiMHEFGYhaM=
Received: by 10.216.85.210 with SMTP id u60mr3985484wee.226.1256325439381; 
	Fri, 23 Oct 2009 12:17:19 -0700 (PDT)
In-Reply-To: <7vd44eaqc5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131119>

Heya,

On Fri, Oct 23, 2009 at 13:59, Junio C Hamano <gitster@pobox.com> wrote=
:
> =A01. The series will break your rc script (either $HOME/.bashrc, or
> =A0 =A0system-side) that sources $git/contrib/completion/git-completi=
on.bash
> =A0 =A0because it has to be built; having "make" generate it may alle=
viate
> =A0 =A0the issue, but "make clean" will break it again, so it is not
> =A0 =A0something you can solve in any way other than changing your se=
tting.

This is my main concern, adding 'bash_completion' as a target to all:
would be ok; why would 'make clean' break it? As long as you don't add
"make -C contrib/completion clean' to the main clean target there's no
problem?

--=20
Cheers,

Sverre Rabbelier
