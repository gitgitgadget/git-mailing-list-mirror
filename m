From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git repository mesh?
Date: Wed, 25 Nov 2009 19:16:38 +0700
Message-ID: <fcaeb9bf0911250416u7e363ab2yf9334bad09f957fb@mail.gmail.com>
References: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com>
	 <vpqaaybf37f.fsf@bauges.imag.fr>
	 <fcaeb9bf0911250000u395c0153q43c8c7a60ca9b876@mail.gmail.com>
	 <vpqy6lues5j.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 25 13:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDGnf-000331-Sy
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 13:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934121AbZKYMQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 07:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758688AbZKYMQd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 07:16:33 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:48094 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758706AbZKYMQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 07:16:32 -0500
Received: by pzk1 with SMTP id 1so5567671pzk.33
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 04:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=mi+x14rkSDyVE2rNm0HghcrF9gfBCBuKlDZC55emMEs=;
        b=gMEkck1TZNmaUdn2R7hJ4TRJrvkBQDmClQSKjgwkvu3azcuh7NiZ021IfIpaXTivfZ
         EPkzDPLWX38HpWdG0sTTVCax42nv3KvSS0AVJ9THGGaB7CSHjMMjagTJLW50nOmv7qkr
         Pu8sg9PmKOzSwb50WmuTCGlMoObCNrvwZFafM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mi470lgr/Dn6Rrs4FTifX/H0aoqfI4TUr9nX4qgqnnR4pW0TGMOLGqcKhGznlAotPX
         v+l9oZJpWy/8szs383o+AAt0+7Dpy2xLwkj+oFi0Rv8Vjkf6w+5WO/HgC1J6haQg8rhs
         +V7/jz+1wcrSjU1Z7R/3rz/6+PnY/3MihYPiE=
Received: by 10.115.99.11 with SMTP id b11mr15479275wam.17.1259151398514; Wed, 
	25 Nov 2009 04:16:38 -0800 (PST)
In-Reply-To: <vpqy6lues5j.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133634>

On 11/25/09, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Then, fetch from all of them and:
>
>   git log ^HEAD repo1/master repo2/master repo3/master

Very nice. Thanks I did not know about "^HEAD". Now I need to think of
how to avoid typing all "repo*/master" stuff..
-- 
Duy
