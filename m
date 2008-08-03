From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Update to it.po
Date: Sun, 3 Aug 2008 14:16:46 +0200
Message-ID: <4d8e3fd30808030516g64f5cdb7r884632ac109063cb@mail.gmail.com>
References: <20080803121131.589e672b@paolo-desktop>
	 <200808031349.03170.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: "Michele Ballabio" <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 14:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPcX3-0004pC-IA
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 14:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612AbYHCMQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 08:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756590AbYHCMQt
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 08:16:49 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:26205 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756466AbYHCMQr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 08:16:47 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2562985wfd.4
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 05:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EFImzWfNIkG2xzzkGleLnJmW/ERMNkp0+qOnV6/QEkk=;
        b=Pna79GKjnZfLOXFc9xxnneqXPlUVar8k2y1dSuIAJku8lXD+dHmR2v0uBEyLBYeAsr
         +XTNKRiEKtujAn9bOGxFe98Re91OYeadQdfh4C5rbjsU4XPB/4TM7+fDz+VvJiiwysOe
         L6P5b7N+HKpUVV+Tisadts7XI+YdEgMLBJND4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kaZY0zPTvkA3kTxpdhVsvJIMKa4Hb4v9dc8QWszulBuKQik63kILmiPo9jNlNUtw4z
         Zkd3Pu7IJh0e+mFbW/7mSX2DnTQDwHAivv248HoW0aB/zy2jkAFWa1DHb7FpJ+kgnUMR
         oGcHp3SE+qjIAMJWT0dpy3MCXvMzA+RL2Wjg0=
Received: by 10.142.177.5 with SMTP id z5mr4527696wfe.248.1217765806514;
        Sun, 03 Aug 2008 05:16:46 -0700 (PDT)
Received: by 10.142.177.15 with HTTP; Sun, 3 Aug 2008 05:16:46 -0700 (PDT)
In-Reply-To: <200808031349.03170.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91236>

On Sun, Aug 3, 2008 at 1:49 PM, Michele Ballabio
<barra_cuda@katamail.com> wrote:
> On Sunday 03 August 2008, Paolo Ciarrocchi wrote:
>> Some fairly simply changes to it.po
>>
>>
>> Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
>> ---
>
> [...]
>
>>  po/it.po |   13 ++++++-------
>>  1 files changed, 6 insertions(+), 7 deletions(-)
>
> BTW, I think you posted a patch against git-gui-i18n.git, but that repo is
> way behind git-gui.git and not updated for a while.

Ops... I thought that was still the right process...

> Here is a patch against current master (attached to prevent encoding issues).
>
> The strings missing translation now is "Buckets". I know what
> it means but I can't came up with a translation that I like.

Confused. Even in the repo i used buckets was the only missing translation.
If you look at my patch:

 #: lib/choose_repository.tcl:628
 msgid "buckets"
-msgstr ""
+msgstr "buckets"

you'll notice that we agree on not translating that word :)

That said, I'd like too see the following hunk be part of your patch as well:
 #: lib/spellcheck.tcl:80
-#, fuzzy
 msgid "Unrecognized spell checker"
-msgstr "Correttore ortografico sconosciuto"
+msgstr "Correttore ortografico non riconosciuto"

Can you please clarify how you are working on the po file?
I was used to use gtransalator and I'm a bit confused by hunks like
the following:
-#: lib/option.tcl:192
+#: lib/option.tcl:194

Thanks.


-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
