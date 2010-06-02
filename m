From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC v3 2/7] gettext: Add a Gettext interface for shell
 scripts
Date: Wed, 02 Jun 2010 08:32:15 +0200
Message-ID: <4C05FAEF.2040205@viscovery.net>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com> <1275435597-4017-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 08:32:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJhV2-00015P-QY
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 08:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab0FBGcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 02:32:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28963 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751799Ab0FBGcT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 02:32:19 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OJhUt-0005JJ-VA; Wed, 02 Jun 2010 08:32:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A391B1660F;
	Wed,  2 Jun 2010 08:32:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1275435597-4017-3-git-send-email-avarab@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148219>

[When you resend the series in such a manner that you collect a Cc list
manually, please do *not* include me. I'm not interested in this series=
=2E]

Am 6/2/2010 1:39, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> +    # Not everyone has echo -n
> +    case $(echo -n) in
> +        \-n)    Xn=3D   ; Xc=3D'\c' ;;
> +        *)      Xn=3D-n ; Xc=3D
> +    esac

Don't use 'echo'; use 'printf %s'.

> +
> +    gettext () {
> +        echo $Xn "$1" $Xc
> +    }
> +
> +    eval_gettext () {
> +        eval_gettext_var=3D"echo $1"
> +        echo $Xn `eval $eval_gettext_var` $Xc
> +    }

-- Hannes
