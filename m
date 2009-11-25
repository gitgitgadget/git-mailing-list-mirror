From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git repository mesh?
Date: Wed, 25 Nov 2009 05:26:54 -0800 (PST)
Message-ID: <m3d436burx.fsf@localhost.localdomain>
References: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com>
	<vpqaaybf37f.fsf@bauges.imag.fr>
	<fcaeb9bf0911250000u395c0153q43c8c7a60ca9b876@mail.gmail.com>
	<vpqy6lues5j.fsf@bauges.imag.fr>
	<fcaeb9bf0911250416u7e363ab2yf9334bad09f957fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 14:27:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDHtf-0006Y0-E0
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 14:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbZKYN0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 08:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbZKYN0v
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 08:26:51 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:45831 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbZKYN0u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 08:26:50 -0500
Received: by fxm5 with SMTP id 5so6943147fxm.28
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=uLFi+BpbM+qAmZ2mfj0hC8i+KLGuH7hnn/8cGY1x7f4=;
        b=MJawsbp2MX6L8oQ5Dk5tgwTaZ9mQ2AYCjUmCaD1QWNo2nD7ZIX1aBumeDUKADrTxM8
         fOH2stdnki9tunWEwJh7Sb4TKGZcR0FqiMRVtybAhPdcvc1o4Boc9s9UcbSdAN/SAkRX
         IFehvH+x2MWo+svnI/ermx2Zb7+Gm/6dxY5Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dQwIqS/O7Fda9rGYC339mAqzjHORCr7UAAqrlhbpi2Vh1KKHc2ILCvCUWTVHvYZbAB
         Tj/ngV9Br3y6/8+hrilW05OWKmhv5h+doMdKTREe5bgJjJi9Ymzh1ozbcEnTd6CZ9rCm
         W4pWW9pAVr5bLQdIDyuHYGVFzHXOh5qmHtmdg=
Received: by 10.103.80.25 with SMTP id h25mr3298679mul.15.1259155616440;
        Wed, 25 Nov 2009 05:26:56 -0800 (PST)
Received: from localhost.localdomain (abvf67.neoplus.adsl.tpnet.pl [83.8.203.67])
        by mx.google.com with ESMTPS id s10sm508520mue.51.2009.11.25.05.26.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 05:26:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAPDQQfV010401;
	Wed, 25 Nov 2009 14:26:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAPDQAF1010394;
	Wed, 25 Nov 2009 14:26:10 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <fcaeb9bf0911250416u7e363ab2yf9334bad09f957fb@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133639>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On 11/25/09, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> > Then, fetch from all of them and:
> >
> >   git log ^HEAD repo1/master repo2/master repo3/master
> 
> Very nice. Thanks I did not know about "^HEAD". Now I need to think of
> how to avoid typing all "repo*/master" stuff..

Hmmm... shouldn't 'repo1' expand to 'repo1/HEAD', which is 'repo1/master'?
I mean shouldn't simply

  git log ^HEAD repo1 repo2 repo3

work?

Also, git aliases (so you would be able to just say "git in").

-- 
Jakub Narebski
Poland
