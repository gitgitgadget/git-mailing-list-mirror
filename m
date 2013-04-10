From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH] glossary: extend "detached HEAD" description
Date: Wed, 10 Apr 2013 14:59:40 +0200
Message-ID: <5165623C.703@gmail.com>
References: <7vwqshc8ec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 14:59:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPucv-0008CF-E8
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 14:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762735Ab3DJM7p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 08:59:45 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37273 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab3DJM7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 08:59:44 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi18so431768wib.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ktUesWUPhUlevmmqnAeHvsEYHIPqwF+QQsSwO4AlLeI=;
        b=qzNZjGDDS2nLpF+SdXozGRP/tRHSBgwQVplm68P7VmBTEtqBo2Tct3Xei+pzTTVwnW
         /wxCN+WJ4IeJ+VbI7mjFC508OJffOhdzOos+L+rdeYv0/qS5RtPz01hNTEvTjYzjyiLr
         Rg6VevEc04Tce68jRf3IMRl5Bkl+YW0SkcBBnxZkaLV2L9fzIv2/pzzEIGUPn+5Yz2iS
         FWBHSYcdmmq5jQZ1xAjpByL89c3XCSNf1Teond6CLKjbeqwqC4LeWhuiLGhVKHKeT4f4
         l9Xzzt7jMRX2ch4+0e+XRK5SO+ebCVXb4IQuNSDl48goV6jmgtdIb/fUy5fyxj1OpWOK
         OhgA==
X-Received: by 10.180.39.207 with SMTP id r15mr3314207wik.16.1365598783313;
        Wed, 10 Apr 2013 05:59:43 -0700 (PDT)
Received: from [10.10.249.223] ([158.75.64.98])
        by mx.google.com with ESMTPS id dm9sm31684530wib.3.2013.04.10.05.59.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 05:59:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vwqshc8ec.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220685>

Junio C Hamano wrote:

> diff --git a/Documentation/glossary-content.txt b/Documentation/gloss=
ary-content.txt
> index f928b57..69c90d1 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -100,9 +100,22 @@ to point at the new commit.
> =20
>  [[def_detached_HEAD]]detached HEAD::
>  	Normally the <<def_HEAD,HEAD>> stores the name of a
> -	<<def_branch,branch>>.  However, git also allows you to <<def_check=
out,check out>>
> -	an arbitrary <<def_commit,commit>> that isn't necessarily the tip o=
f any
> -	particular branch.  In this case HEAD is said to be "detached".
> +	<<def_branch,branch>>, and commands that operate on the
> +	history HEAD represents operate on the history leading to the
> +	tip of the branch the HEAD points at.  However, Git also
> +	allows you to <<def_checkout,check out>> an arbitrary
> +	<<def_commit,commit>> that isn't necessarily the tip of any
> +	particular branch.  The HEAD in such a state is called
> +	"detached".

Should we also add that "git branch" output shows this situation
as "(no branch)"?

Nb. this is not documented in git-branch(1) manpage either...

--=20
Jakub Nar=C4=99bski
