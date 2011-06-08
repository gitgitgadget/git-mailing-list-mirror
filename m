From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Wed, 8 Jun 2011 14:15:22 +0200
Message-ID: <BANLkTik6mi002mWArJiLcC4rnvmotf5+2A@mail.gmail.com>
References: <DAFDEB13CE4944C18AAF3F20994AEF2E@martinic.local>
 <BANLkTinTJh9oOTHi5js7n-sy8+pmMa_vtQ@mail.gmail.com> <187961B7EDE84635BD7B3C9A4EF688C3@martinic.local>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: Theo Niessink <theo@taletn.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 14:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUHgE-0001xl-4l
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 14:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab1FHMQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 08:16:04 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45227 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab1FHMQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 08:16:03 -0400
Received: by pwi15 with SMTP id 15so213015pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=du7uaqdlvehWg/30jMsK9ZjraJmlulqaUgk+Rtz3PGQ=;
        b=jNsS6GBIZLRMthOzfhhOVvuiMlJ/6Jgpu67OX05a4o8rdULbcX2B1M/RPA6+Mmg2ap
         1q/k8/NbQgQfif3CSxCrPGwzfpLl0hiPRjTBPO+XFkrSnhK/v7w3Q9aJwxUsNcxsFbWY
         cLEmcWi5x6aS/3AB34ipUY9X2NPmb58yUnU2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=TEz2HK9a9o7om0lJ9Suhj99HI8frTUPz1sktsVt2SEeKBKefl9NuL/fJLsXIvIl4uZ
         qz12WzOjSIwNrdg+j/ncvizNaALJv7DU1i3V0jqT3jQ6y6bgndFj09HqtM6aa0v/tuUo
         NDhevUo+xjY526vxa2IlaXO4m4Ldxr23I8FQc=
Received: by 10.68.68.106 with SMTP id v10mr731620pbt.115.1307535362170; Wed,
 08 Jun 2011 05:16:02 -0700 (PDT)
Received: by 10.68.50.231 with HTTP; Wed, 8 Jun 2011 05:15:22 -0700 (PDT)
In-Reply-To: <187961B7EDE84635BD7B3C9A4EF688C3@martinic.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175362>

On Wed, Jun 8, 2011 at 2:04 PM, Theo Niessink <theo@taletn.com> wrote:
> Erik Faye-Lund wrote:
>> This looks obviously correct to me. Thanks for spotting the problem.
>>
>> Would you mind writing up a commit-message and supply a sign-off?
>
> Like this you mean?

Just like that, indeed!

Junio, what do you think, is this OK? I'd be great if we could have
this applied upstream, and then rebase-merge our branch on top for the
next Git for Windows release.
