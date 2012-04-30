From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Glossary for bootstrapping Git translations
Date: Mon, 30 Apr 2012 21:17:34 +0800
Message-ID: <CANYiYbH7g5JRvEQ_b9sEP72zR+yrAj+cQbemi_nsFTSa+QRgEw@mail.gmail.com>
References: <CACBZZX7H8qB05qc+ovaeFJ_qR3bF7=uWq6bjOHq8+_YNDLTu2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?Hinrik_=D6rn_Sigur=F0sson?= <hinrik.sig@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 15:17:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOqUB-0000VI-Vb
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 15:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab2D3NRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 09:17:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59371 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425Ab2D3NRf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 09:17:35 -0400
Received: by ghrr11 with SMTP id r11so1339368ghr.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+RcvFSjqzIoiLQ82XWgUGLMuxWv7XMmyP+3LYX6felQ=;
        b=Dj58sCugdtWCsEqHSpCkoza9rUlX9j0fFKPJO1HGoigU2K6nEZkGZieEEvliwKzgkI
         gFrOsuN2S6nvLwL2WBZGR40caMvPRz7qIST4fvUPEjUu05yMbAxIdjXt4Aesz1AOyVVz
         uyhsex88ZrVizlpSN99acgRK5xSFcNVrSJGx6G9xQ/3e2lDL6VUAqwRCijC7ECMygSLh
         M0zwnvwd1tcIfIM59cWLFjWn16+YzDq10P6NG/PgJ7BFmI+f5HkRPJYFSVskDmy9ppvk
         gxKdiHR7wj5xT89k7tm0nCGdtMKlIoBmXXhNBgbVTIFR8NF91wwVWEUnPQAt2LVhNgk8
         qcvg==
Received: by 10.50.36.195 with SMTP id s3mr10366444igj.27.1335791855221; Mon,
 30 Apr 2012 06:17:35 -0700 (PDT)
Received: by 10.50.207.40 with HTTP; Mon, 30 Apr 2012 06:17:34 -0700 (PDT)
In-Reply-To: <CACBZZX7H8qB05qc+ovaeFJ_qR3bF7=uWq6bjOHq8+_YNDLTu2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196559>

2012/4/30 =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>:
> Over the weekend I started the Icelandic translation of Git beyond th=
e
> current test messages that are there in po/is.po already.

I just created new branch 'maint' in git-po repository on GitHub,
and generated two different 'git.pot' files yesterday. The
recommended workflow for a new language:

1. After fork the git-l10n/git-po on GitHub, checkout the 'maint'
    branch, or create a new tracking branch based on it.

2. Create your initial XX.po file, tranlate, commit, and push to
    your own fork.

3. Send a GitHub pull request to the 'maint' branch of git-l10n/git-po.

4. The l10n coordinator merge your commit to the 'maint' branch,
    so your translation may appear in git next maintainence version,
    i. e. 1.7.10.1.

5. The l10n coordinator will do a second merge, so new commit in
    'maint' branch will merge back to the 'master' branch.

6. Update your XX.po in 'master' branch, translate, commit, and
     send new pull request.

7. The l10n coordinator will merge your updates to 'master' branch,
     and your translations will come with git 1.7.11.

L10N team leaders may already noticed these changes, as I @ all
team leaders in the commit comments.

* https://github.com/git-l10n/git-po/commit/cd1e74874049c8ba8e510f2fae0=
64e510cccd32b#commitcomment-1271645
* https://github.com/git-l10n/git-po/commit/df3ef6fb98a276fa62bbcf129d4=
0307b00253588#commitcomment-1271639

--
Jiang Xin
