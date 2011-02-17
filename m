From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3 1/4] Introduce CHERRY_PICK_HEAD
Date: Thu, 17 Feb 2011 17:42:52 -0500
Message-ID: <AANLkTinWCZqb=C5qbiGpwq4=PQCUswfyxekTDD6scNbm@mail.gmail.com>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-2-git-send-email-jaysoffian@gmail.com> <7v39nm9vgv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 23:43:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqCZO-0006X0-SQ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 23:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab1BQWnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 17:43:24 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58021 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab1BQWnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 17:43:23 -0500
Received: by iwn9 with SMTP id 9so3006663iwn.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=DIJa1IMQhsYGFKEvb1dEqTupiyiWawUuoMz8VwhpJgQ=;
        b=aQ+sM53Y5fuM6nDaZhdubJA7bmwuuXlUzI5HoHvtuG47giL971wDhBoHWRwagKOIs2
         BA59nGLzUrC+dedVMUZ9pRlavXVis+EKmLzjW1BJpxOPncAC6P42/A0qHDgqPorAbfOE
         qu6xCHOhYwEv/iELqe8F3PkhiDM25Bjbk3OXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HGDYmZcZc02/JyXnOgWEqe0ITiM9MLGKejpWtWSHDd0plANe11N4LBnVbfTZLby0KS
         U77y98anhqLzlce+E6v4OmVFQA8ARV/j4D45Jo/EiHHqxP1ohkNAPhVG///6ttb4lKM2
         uWUkhI3aGqXUDwr6ErRa8fNczKorGgpJTutjc=
Received: by 10.231.14.8 with SMTP id e8mr2069745iba.117.1297982602696; Thu,
 17 Feb 2011 14:43:22 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Thu, 17 Feb 2011 14:42:52 -0800 (PST)
In-Reply-To: <7v39nm9vgv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167131>

On Thu, Feb 17, 2011 at 4:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This series in 'pu' seems to break t3404#16.

Sorry for the breakage, I was running the test suite piecemeal and
must've not run that test (which was dumb of me). I'll figure out
what's going on and re-roll with Jonathan's t3507 improvements as
well.

Thank you for your patience.

j.
