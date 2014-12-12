From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] create gpg homedir on the fly
Date: Fri, 12 Dec 2014 03:52:19 -0500
Message-ID: <CAPig+cTEY4fbNuVv0S-jOk7CKouh5aRKSR=KejJQD3a9bhcOKQ@mail.gmail.com>
References: <20141212094753.160a0fb5@leda.localdomain>
	<1418374214-8241-1-git-send-email-mail@eworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Christian Hesse <mail@eworm.de>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:52:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzLxa-0005ED-6z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934041AbaLLIwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:52:20 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33936 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127AbaLLIwT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 03:52:19 -0500
Received: by mail-yk0-f176.google.com with SMTP id q200so2932440ykb.21
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 00:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jyTIZXupdB1SKe/FLhGahHRp+eqrN6CEAbPJOX94ZDk=;
        b=OpBMIL91ZNyNCLtUL0mXFdYhX4Tn5hKiRsHeC21Df9ouMAmGvubrFtQC83o5dmMzcQ
         icTke22izNkCz0TYnadXm4/nQYhdS9gT2GputkbXE5vr0zt5DGRkBOFm+TE/BN358Xh8
         NjJW0yNtofQC9jlJjR2UWicFtsPHew0KRlePg083RI36aIlStJEzB3NkNzR+I796obD6
         B6Yd4/xnHnv1ie2YbMNzQw2vxwAuRa8A2Qt0cekwsdwBSyhiBPGP4GSpewEPOwr6qav3
         tmxJ5SfAMlPUSt8KN5CRSuelBF1sUiNpOWIAFAotZPWRoh39HoAYc9TF4UkG/qIyDjS7
         VqmQ==
X-Received: by 10.236.53.69 with SMTP id f45mr10448864yhc.65.1418374339231;
 Fri, 12 Dec 2014 00:52:19 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Fri, 12 Dec 2014 00:52:19 -0800 (PST)
In-Reply-To: <1418374214-8241-1-git-send-email-mail@eworm.de>
X-Google-Sender-Auth: KpO7E-Q6nJAmNOVOo1xF0jdlCd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261318>

On Fri, Dec 12, 2014 at 3:50 AM, Christian Hesse <mail@eworm.de> wrote:
> GnuPG 2.1 homedir looks different, so just creat it on the fly by

s/creat/create/

> importing needed private and public keys and ownertrust.
> This solves an issue with gnupg 2.1 running interactive pinentry when
> old secret key is present.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>
