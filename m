From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/3] Make test-lib.sh emit valid TAP format
Date: Mon, 14 Jun 2010 15:01:55 -0700 (PDT)
Message-ID: <m31vc9p93t.fsf@localhost.localdomain>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
	<1276096943-32671-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 00:02:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOHjI-0007xm-71
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 00:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab0FNWB6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 18:01:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58259 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0FNWB6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 18:01:58 -0400
Received: by bwz7 with SMTP id 7so2355405bwz.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=zaPwvNUcePLk79HtBE5uM/+7vimKpMu/Qk3H3hfmdiU=;
        b=O+FUDIsbH3wdKJnM3sTP9x3msIyfCY7l/5riHtnmCuzx2KtXOlQI7puoJUPOEz/0xH
         Bwpag8IvNDj+fTPO/D6+6RWv4YBi/FgcyifJuuc/x3bENwgwwHiwjW4B4TCQ9nDKNVXd
         gVeVEuhu3u2GQMcALY6yA3wVYw8YOhdBbdG7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=FXYqHBeq6djodsQnP9hgQHYqy3bZaIBIhx2g/4dk1eyNpE3gntFrhFnvCbEJGpmuau
         U7Ko+gJR9hyW4i1TMwq1Lm2R65HEJrRs65SIr0nd7AyIddKwKdJmbLqQmqR8Aq4SDAdT
         sJgd1zO2bJFajzLCvVlUH+Zsk2zioSoLoFDAg=
Received: by 10.204.136.71 with SMTP id q7mr4725805bkt.156.1276552916693;
        Mon, 14 Jun 2010 15:01:56 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id z17sm21312805bkx.0.2010.06.14.15.01.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 15:01:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5EM1Qkm028087;
	Tue, 15 Jun 2010 00:01:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o5EM1B8k028080;
	Tue, 15 Jun 2010 00:01:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1276096943-32671-2-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149140>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> TAP, the Test Anything Protocol, is a simple text-based interface
> between testing modules in a test harness. test-lib.sh's output was
> already very close to being valid TAP. This change brings it all the
> way there. Before:
>=20
>    $ ./t0005-signals.sh
>    *   ok 1: sigchain works
>    * passed all 1 test(s)
>=20
> And after:
>=20
>    $ ./t0005-signals.sh
>    ok 1 - sigchain works
>    # passed all 1 test(s)
>    1..1

How failing test looks like before and after the change?

How test_expect_failure, i.e. known breakage (TODO test) looks like
(both in known broken, and in accidentally fixed version) before and
after the change?

How does '--verbose' and '--debug' output looks like before and after
the change?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
