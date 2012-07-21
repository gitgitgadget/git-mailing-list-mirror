From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Sat, 21 Jul 2012 18:26:19 +0200
Message-ID: <500AD82B.9010604@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com> <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com> <0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com> <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com> <941f7bd695e8a14c940a5b8e4214d2773ae82557.1342884459.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 18:26:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SscVk-0003QE-Ou
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 18:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab2GUQ00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 12:26:26 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61311 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab2GUQ00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 12:26:26 -0400
Received: by bkwj10 with SMTP id j10so4172065bkw.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=P8zKP6r81bMTIUc4Jki9eovb5yAyIDn5vEygMYIndOo=;
        b=ST30SnBCrgoKLcx4W6c8tdMzHKtw8hQQ0HEs6W+gwjSh7z6jYjrChS073hXObWnoI0
         2YkeXCBH42OYrRm3tsDZwDFHjGO/+kp+SjTflukqDENqmO1E0Y6QdvQL9mn0x6w+QyIb
         df+w6iIVoIcv3oGyb0kGWRKc5pwY0iMNSEV9GUi+63ulR+/j3y/zofGU5W9ylK76twx7
         IF8Hb7JIzbC74h6GmL6et/sHhr8n/dKA4JSJ0yU4SFX4MXN2zonnEWeEQChr/EAG8+iy
         N9gjQGlgw/oicb/gwSMJOgw2OXEcwloHu4hY28POSkt7nl9IDvriW08vZGlX5TOEitog
         PbdA==
Received: by 10.204.154.141 with SMTP id o13mr4824292bkw.72.1342887984729;
        Sat, 21 Jul 2012 09:26:24 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id fu8sm4262293bkc.5.2012.07.21.09.26.23
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 09:26:23 -0700 (PDT)
In-Reply-To: <941f7bd695e8a14c940a5b8e4214d2773ae82557.1342884459.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201825>

On 07/21/2012 05:50 PM, Jiang Xin wrote:
> The obsolete LONG_USAGE variable has the following message in it:
> 
>     A'\''--B'\''--C'\''
> 
> And such complex LONG_USAGE message will breaks xgettext when extract
>
s/extract/extracting/ I think.

> l10n messages. But if remove single quotes from the message,
>
s/remove/we remove/; or, if the passive voice is not a problem, you might
reformulate the sentence as follows:

   But if single quotes are removed from the message, ...

> xgettext works fine on 'git-rebase.sh'.
> 
> Since there is a mordern
>
s/mordern/modern/


> OPTIONS_SPEC variable in use in this script,
> it's safe to remove the obsolte
>
s/obsolte/obsolete/

> USAGE and LONG_USAGE variables.
> 

Regards,
  Stefano
