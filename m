From: Pat Notz <patnotz@gmail.com>
Subject: Re: get-upstream
Date: Wed, 22 Sep 2010 22:15:00 -0600
Message-ID: <AANLkTikYnj_00Pdsm+QM1=kvqMpeKDCeOOqOS0XEwMXg@mail.gmail.com>
References: <AANLkTikqJmsUo53dRngXcWsoEfcFzLQ-J1V5oZOGUL03@mail.gmail.com> <AANLkTikQ8sHrp+sSZ8e8u7L+6=NHVY3cD9DwChAzLEk0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ramana Kumar <ramana.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 06:15:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OydDU-0006BP-Ez
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 06:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab0IWEPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 00:15:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55376 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0IWEPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 00:15:21 -0400
Received: by fxm12 with SMTP id 12so538560fxm.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 21:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=l3Pdi7QyhpSu7V4dM84ogdFsprjjcvj9BdtvAJ0p4ZA=;
        b=qr8ZJVTgIHF7655TdY6WidMQCH1zQ49ONjyW/bkVA7SM2VtKU9MiWtsobg4Hm334ml
         Rryrg2cYFwgO+0b0BRGPVgLnRt0H+QYjEcu2WrbJid1fhnNJE8okv0fEltmLvzqQTuit
         4PRaAcLM4uCWlJu5HtIheD3DG8gM1Mt5xz3x8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JlOJ654GMZjuIvRQ6wMqtHakBIai0En71TNAEXaLnBdjzloi/jCrNsMRNAts/Jd7CV
         Q0DvuZ9Sh4PWArvt4NsbtBn/WV+pNLMZ2/7s8QCDVAamnuWhOj/P3lXXqxFFALgy8WJj
         bC9UA/92aHZ5rmxGMUt9doLM2OgmCTMGzsLNY=
Received: by 10.239.185.209 with SMTP id d17mr67495hbh.189.1285215320605; Wed,
 22 Sep 2010 21:15:20 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Wed, 22 Sep 2010 21:15:00 -0700 (PDT)
In-Reply-To: <AANLkTikQ8sHrp+sSZ8e8u7L+6=NHVY3cD9DwChAzLEk0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156846>

On Wed, Sep 22, 2010 at 10:05 PM, Pat Notz <patnotz@gmail.com> wrote:
> $ git rev-parse --symbolic-full-name @{upstream}

In all fairness, the @{upstream} syntax requires git >= 1.7.0

http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.7.0.txt
