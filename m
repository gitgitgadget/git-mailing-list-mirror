From: j6t@kdbg.org
Subject: =?utf-8?Q?Re=3A_=5BPATCH_5/5=5D_autoconf=3A_don=27t_use_platf?=
 =?utf-8?Q?orm_regex_if_it_lacks_REG=5FSTARTEND?=
Date: Tue, 17 Aug 2010 14:50:38 +0200 (CEST)
Message-ID: <mtranet.20100817145038.1501455151@telekom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?utf-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 14:50:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlLd2-0004mg-BK
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 14:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab0HQMuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 08:50:46 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:11398 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129Ab0HQMuq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 08:50:46 -0400
Received: from telekom.at (lbmbmn03.lix.bon.at [172.18.12.177])
	by bsmtp.bon.at (Postfix) with SMTP id F3365A7EC1;
	Tue, 17 Aug 2010 14:50:38 +0200 (CEST)
Content-ID: <mtranet.1282049438.1600102394@telekom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153749>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason schrieb:
> +[#ifdef REG_STARTEND
> +yippeeyeswehaveit
> +#endif
> +]),
> +	[ac_cv_c_excellent_regex=3Dyes],
> +	[ac_cv_c_excellent_regex=3Dyes])
> +])

Do you have REG_STARTEND?

  o Yes
  o Yes

Choose wisely! :)

-- Hannes
