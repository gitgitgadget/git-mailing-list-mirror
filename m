From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH v6] Add infrastructure for translating Git with gettext
Date: Sun, 11 Jul 2010 09:55:43 +0800
Message-ID: <AANLkTilHE02RUBAnyZReB9zRkmQ2oJXRyspUlx3I9KZH@mail.gmail.com>
References: <1278794867-32438-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 03:55:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXllu-0003MQ-8i
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 03:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab0GKBzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 21:55:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45107 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab0GKBzp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jul 2010 21:55:45 -0400
Received: by wyf23 with SMTP id 23so2598490wyf.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 18:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nB05QG+ZXuHGYtkrK4n/2tqayGXti33FqNYOeJwXSJ4=;
        b=pIG9RsbalvaEL5RWwYJ6lSjmW+h8TO35Gt3jO1HCAac+VU3iEjUmBINACzY1Hv7VZa
         mfL/YwrubEBzfKecihShxLGBI7ivhn0FtM4VBtdNu7zHtq+rwiFE8x5kzduD1Z5xuHJs
         NirB70N586dEI1zs7/bLXC6RWlJ2l0Nz0Jkn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hSL+zidWAZGcd/BRf3lmM5Qytx0UZTzsut+cDtdboVDm+U8Pvj5kpR8WeU+UFT9sbo
         xprC2djnMANugq2gVatIHx16PvX3r0uUNtxxzJlfXL050NisAHavhqLHaj23Y4zJIsJ/
         mFaqrFTBC+Y8oP/rIHMD/+9WIVxhbHewJqvpE=
Received: by 10.216.132.86 with SMTP id n64mr1824155wei.11.1278813343304; Sat, 
	10 Jul 2010 18:55:43 -0700 (PDT)
Received: by 10.216.163.142 with HTTP; Sat, 10 Jul 2010 18:55:43 -0700 (PDT)
In-Reply-To: <1278794867-32438-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150739>

On Sun, Jul 11, 2010 at 4:47 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> For Shell and Perl programs we rely on the git message
> catalog not being available. That's a reasonable assumption since the=
n
> the message catalog won't be installed on the system during make
> install.

Would a "stale" message catalog (from a previous installation of git
with gettext
enabled, via make install) be deleted upon new installation (via make
install) with
NO_GETTEXT=3DYesPlease?

nazri
