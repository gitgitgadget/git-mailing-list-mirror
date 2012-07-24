From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v3 2/7] i18n: rebase: mark strings for translation
Date: Tue, 24 Jul 2012 11:43:27 +0200
Message-ID: <500E6E3F.5090706@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com> <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com> <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:43:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StbeU-0003hs-68
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 11:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab2GXJnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 05:43:33 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50031 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab2GXJnc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 05:43:32 -0400
Received: by lbbgm6 with SMTP id gm6so8882651lbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=8TwtwN7+2FawbaxzfbdvPHxTZChRbV+QaBT071X5fS4=;
        b=FSFVFYght7N7TbtTVPPJANBWIEMVB999m5jLD7s+kc9DNvuJXgDSomrpdnrYkF1MLu
         dzpqd4mByqiabKpvv4UZpb87rLBoxNKZERT3bcPVewhE07p1NI3QMYaA3WUbpZmCuxca
         G2ksyjakSHKn0pYqmZCTmBXbtkzlVKGZaS0Kk/9nxSdk/5Gpii9P6re+NcHJH4scHpjU
         JV2mNzW2iZshpKI1QfHQZe/57tLl20uKDMCaO1yw0VsreGndZ+k0/8o8YYik8zU8ZnIr
         SG2Hgme67BL/wtHePGMMtB3tq1vIzGBLsoq5vf8A5+wzHDQKYxm+rfBpSIoJf68WEfZ+
         2GoQ==
Received: by 10.152.144.168 with SMTP id sn8mr20887016lab.1.1343123010807;
        Tue, 24 Jul 2012 02:43:30 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id u10sm3691202lbm.14.2012.07.24.02.43.28
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 02:43:29 -0700 (PDT)
In-Reply-To: <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202023>

On 07/24/2012 08:59 AM, Jiang Xin wrote:
> Mark strings in git-rebase.sh for translation.
> 
> Some test scripts are affected by this update, and would fail if are
>
s/if are/if/

> tested with GETTEXT_POISON switch turned on. Use i18n-specific test
>
s/Use/Using/, or s/Use/Use of/

> functions, such as test_i18ngrep
>
Missing comma after 'test_i18ngrep' here.

> in the related test scripts will fix these issues.
> 

Regards,
  Stefano
