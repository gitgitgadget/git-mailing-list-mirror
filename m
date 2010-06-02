From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC v3 6/7] gettext: Basic sanity tests for Git's Gettext
 support
Date: Wed, 02 Jun 2010 08:32:47 +0200
Message-ID: <4C05FB0F.1060107@viscovery.net>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com> <1275435597-4017-7-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 08:32:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJhVV-0001Dn-Vw
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 08:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721Ab0FBGct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 02:32:49 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29552 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0FBGct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 02:32:49 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OJhVP-0002FW-DQ; Wed, 02 Jun 2010 08:32:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2F6111660F;
	Wed,  2 Jun 2010 08:32:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1275435597-4017-7-git-send-email-avarab@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148220>

[When you resend the series in such a manner that you collect a Cc list
manually, please do *not* include me. I'm not interested in this series=
=2E]

Am 6/2/2010 1:39, schrieb =C6var Arnfj=F6r=F0 Bjarmason:
> +test_expect_success 'sanity: $TEXTDOMAIN is git' '
> +	test $TEXTDOMAIN =3D "git"
> +'
> +
> +test_expect_success 'sanity: $TEXTDOMAINDIR exists' '
> +	test -d $TEXTDOMAINDIR=20
> +'
> +
> +test_expect_success 'sanity: Icelandic locale was compiled' '
> +    test -f $TEXTDOMAINDIR/is/LC_MESSAGES/git.mo
> +'

3 times: put "$foo" in double-quotes.

> +test_expect_success 'sanity: gettext(unknown) is passed through' '
> +    gettext "" > expect &&
> +    > actual &&
> +    test_cmp expect actual &&
> +    printf "This is not a translation string"  > expect
> +	gettext "This is not a translation string" > actual &&

Strange indentation and you break the && chain.

-- Hannes
