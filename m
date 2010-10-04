From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v4 3/4] Allow hiding renames of individual files involved
 in a directory rename.
Date: Mon, 4 Oct 2010 08:43:26 +0200
Message-ID: <AANLkTinw-ZH-RcqWaHY8pNJszc0oTrzdLarenn+FzMXw@mail.gmail.com>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org> <1286138529-6780-3-git-send-email-ydirson@altern.org>
 <1286138529-6780-4-git-send-email-ydirson@altern.org> <AANLkTi=S0AkNdajK5MM60HUxHPG1R=Tp_iL8S8Ds4P+j@mail.gmail.com>
 <7vr5g6etzf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	Yann Dirson <ydirson@free.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:43:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2emD-00042f-So
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab0JDGnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 02:43:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48028 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab0JDGnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 02:43:50 -0400
Received: by iwn5 with SMTP id 5so6527658iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=nw03fxeKAgf+lHCpmoJShhA/q52K2oKNdfcOYHx8ucU=;
        b=TZoKXANmlUWKVq8bv403TUYgRGRiipTZN8VzUslWNq0kVJQwRcdDMRqm1YB5jZIOIN
         0cDTE833J9K3Bm0CBUzqanf1bOmrejT1ntqUBU3OJKf12muwDRasDdYRwakECjW1ZnVK
         RGuUZ/yyMbZwSTl/fBlm+Xy2wBcH8u82ImpWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OYnJV+qScBolTCrijtIqfskVjbktSF1z5NDcWxJCQ/PNjSyxvcX9itw3N1iG0R4HvC
         IM733YyfKKGwK4TyawPaEQ73YLIQ/b0nteCQH6TBItCDNRc2PP7fCMZ+ku5YqENtF9Ca
         cFCgP1fu01s6g8RNBuBKGO7HT8BhL84RlgHps=
Received: by 10.231.174.136 with SMTP id t8mr9637901ibz.158.1286174627319;
 Sun, 03 Oct 2010 23:43:47 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sun, 3 Oct 2010 23:43:26 -0700 (PDT)
In-Reply-To: <7vr5g6etzf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157984>

Heya,

On Mon, Oct 4, 2010 at 01:28, Junio C Hamano <gitster@pobox.com> wrote:
> Having a configuration variable might be a good idea, as long as there is
> a provision to avoid breaking scripted porcelains when the option is set.

I agree... maybe we need a generic way to have a config that only
affects porcelain?

-- 
Cheers,

Sverre Rabbelier
