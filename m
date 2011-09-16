From: Frederic Heitzmann <frederic.heitzmann@gmail.com>
Subject: Re: [PATCH] Disambiguate duplicate t9160* tests
Date: Fri, 16 Sep 2011 23:16:54 +0200
Message-ID: <4E73BCC6.2030303@gmail.com>
References: <1316202903-5085-1-git-send-email-frederic.heitzmann@gmail.com> <7vty8cdxun.fsf@alter.siamese.dyndns.org> <7viposdwos.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bjacobs@woti.com, rchen@cs.umd.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 23:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4fmc-0005Yy-Hi
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 23:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234Ab1IPVRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 17:17:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43680 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174Ab1IPVRI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 17:17:08 -0400
Received: by wwf22 with SMTP id 22so5596556wwf.1
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=PlB+MRRhaDICR1O08/soeeyV8esuASwQ0O3TmrO19Pc=;
        b=HRoKBF88oUvHNHiTg2YnAkMzxbbWBJz1j61a3c8u0EMB5edqrEL5spTOtk4hDQQ10v
         8drVKqRLgGSjMI4Wv1g/dNFdXO8ntMdQbccdjrkS+UNJ/xANI/S5rnnBkW+39MnLMwv1
         g16sOLtV6O7S85HIHpIqrdsA+1pRe1A/fJGvI=
Received: by 10.216.220.216 with SMTP id o66mr1574524wep.52.1316207825888;
        Fri, 16 Sep 2011 14:17:05 -0700 (PDT)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net. [88.179.84.80])
        by mx.google.com with ESMTPS id gd6sm14239565wbb.1.2011.09.16.14.17.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Sep 2011 14:17:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7viposdwos.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181560>

Le 16/09/2011 23:06, Junio C Hamano a =E9crit :
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> Thanks.
>
> Heh, I spoke too early. It still refers to contents of t/t9160/ direc=
tory.
> We would need this squashed into your patch (no need to resend).
>
>   t/t9161-git-svn-mergeinfo-push.sh |    2 +-
>   t/{t9160 =3D>  t9161}/branches.dump  |    0
>   2 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t9161-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-merg=
einfo-push.sh
> index 216f3d7..6ef0c0b 100755
> --- a/t/t9161-git-svn-mergeinfo-push.sh
> +++ b/t/t9161-git-svn-mergeinfo-push.sh
> @@ -10,7 +10,7 @@ test_description=3D'git-svn svn mergeinfo propagati=
on'
>
>   test_expect_success 'load svn dump' "
>   	svnadmin load -q '$rawsvnrepo' \
> -	<  '$TEST_DIRECTORY/t9160/branches.dump'&&
> +	<  '$TEST_DIRECTORY/t9161/branches.dump'&&
>   	git svn init --minimize-url -R svnmerge \
>   	  -T trunk -b branches '$svnrepo'&&
>   	git svn fetch --all
> diff --git a/t/t9160/branches.dump b/t/t9161/branches.dump
> similarity index 100%
> rename from t/t9160/branches.dump
> rename to t/t9161/branches.dump

Ooops ! I checked 'make test', but missed the most obvious change.
Sorry for this.

--
=46red
