From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 19/23] http-push.c::fetch_symref(): use the new http API
Date: Sat, 6 Jun 2009 09:02:32 +0800
Message-ID: <be6fef0d0906051802n4f6d5df3g453b292787ed62d0@mail.gmail.com>
References: <20090606000559.483f22da.rctay89@gmail.com>
	 <m37hzq5rod.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCkIy-0004nu-2j
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 03:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbZFFBCc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 21:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbZFFBCb
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 21:02:31 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:62185 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZFFBCa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 21:02:30 -0400
Received: by pzk1 with SMTP id 1so1169471pzk.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 18:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=26Cb4YHj6BnruOtzw+wraFqscjYZj6L7Q5QAb1je5eI=;
        b=mDRfaWh3DMwG3G0tjWceWpsXFMDh7mFHuGzWA6To8lnN8vP6kr6WTnOKke1qpC5+nE
         +94iM7ApPjNMZsW6a/J3xgqHeOQmyN2hiPI0Bzkx399kVCGxUTJi0UKsiHeO5l1Egn2V
         oNz9Ry3rS5fFAauBZGBQ2mmnfkxw/ONFOvTFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qa/iHJGdvn5C2kcf48aJjxMolrtRssw+8y6hyoG/BHDTxO12x3sRe+bkc8wONBomwX
         dvRsgFTwiHUnMcuRT2hNyVIQtpt7dtfZOZyrs1B4WWYXTesZbXXaxmvGJAm0gUzqdV6a
         PfaCBlFjNuq0GAKLdECnnTImQbWWHf2sKN3zU=
Received: by 10.142.191.5 with SMTP id o5mr1385793wff.96.1244250152501; Fri, 
	05 Jun 2009 18:02:32 -0700 (PDT)
In-Reply-To: <m37hzq5rod.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120853>

Hi,

On Sat, Jun 6, 2009 at 4:54 AM, Jakub Narebski<jnareb@gmail.com> wrote:
>> From: Mike Hommey <mh@glandium.org>
>> Subject: [WIP Patch 09/12] Use the new http API in fetch_symref()
>
> What is the subject of this patch:
> =A0"http-push.c::fetch_symref(): use the new http API"
> or
> =A0"Use the new http API in fetch_symref()"
> [...]
> If you wanted to note old subject, it would be better to put it in
> comments (here).

Since the title of the patch differed from Mike's original, I was
afraid the attribution to the author's original patch was lost on the
reader of the commit message, thus I added the original subject, in
addition to the author and date, into the commit message.

I didn't add the subject line in Mike's other patches, like patch #11,
because the title of the original patch and the current one are the
same, so it's easy for readers to know what patch is being attributed
to.

--=20
Cheers,
Ray Chuan
