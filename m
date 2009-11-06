From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: gitk : french translation
Date: Fri, 6 Nov 2009 21:59:39 +0100
Message-ID: <9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com>
	 <b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Moulard <thomas.moulard@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 21:59:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6VuM-0006YQ-9l
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 21:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759820AbZKFU7f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 15:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759763AbZKFU7f
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 15:59:35 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:50240 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759719AbZKFU7e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 15:59:34 -0500
Received: by ewy3 with SMTP id 3so1472397ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 12:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oqF049XTu4MXhhlsD10ssvVZNeDe9F97pGlIXHaPA6M=;
        b=g9AwswO0ZO5oZEbLzlOiVkCv4XlWNavm1pmYYSu6s1tDMWKToXiU8jbjJ3LIWZGzqa
         7hIzblM77jUlZIOWATNglSs5geR19+O284KF44ziDGEe0x7QfRVyPsEflRj328PiB7fu
         Uuxwvr3ZyS79PVEhcbNYYZXEoDlA+qgvIXThQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cPsU7g81d+Ot1KtQXwZxI1Q7ke5EtP4Qv4DHWOqXaL/7q2jo6Vey9D6lrGx+C/fHWj
         IjL6qHsyT7ZUM5Obfxf21+6T3uPArNab8REdKP3iG/p8PF69ZIRnLXSXHqNncQKt7prp
         AzuI+FfV6GO/1GITSK4C9EuZx7F15oDNolDBY=
Received: by 10.216.87.80 with SMTP id x58mr1495461wee.92.1257541179458; Fri, 
	06 Nov 2009 12:59:39 -0800 (PST)
In-Reply-To: <b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132325>

> Here is an updated translation with the following changes:
> - translated strings which was still untranslated
> - fixed some fuzzy translations
> - make some consistency changes
> =C2=A0* s/diff/diff=C3=A9rences/
> =C2=A0* s/patch/correctif/ everywhere
> - fixed some spelling problems.
Thank you for your work!

> IMHO the most important should be to decide how to translate the git =
vocabulary.
> The Subversion project has guidelines concerning that issue:
> http://svn.collab.net/viewvc/svn/trunk/subversion/po/fr.po?revision=3D=
39920&view=3Dmarkup
> It may be a good idea to stick with what they are doing if possible.
> The only exception should their translation of ``commit'' by
> ``propagation'' which
> I find awkward. Especially in a Git context , ``git commit'' really
> does not propagate anything.
I just had a quick look at this file. I don't like "propagation"
either and I prefer to use the
terms "commit" and "commiter".

> BTW any reason to translate the GUIs (gitk / git-gui) but not the
> command line tools?
The command line tools are not internationalized.

Right now, I don't have time to look at your change and to discuss
about them, but tomorow I will.

Best regards

Emmanuel
