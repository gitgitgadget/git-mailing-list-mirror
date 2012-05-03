From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull git-po master branch
Date: Thu, 3 May 2012 18:19:30 +0800
Message-ID: <CANYiYbGvfXFLK4AMGGUWyGd1YXEF_scES4mR--mbuZ1t2PdsEQ@mail.gmail.com>
References: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
	<87d36n2f2r.fsf@thomas.inf.ethz.ch>
	<7vtxzyilid.fsf@alter.siamese.dyndns.org>
	<CANYiYbH+N3k_=FWyeS_HfBWSBeBdOUqW5qrHFe=qV4ECtYABpA@mail.gmail.com>
	<7vaa1phica.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 03 12:20:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPt8u-00065O-6q
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 12:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab2ECKTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 06:19:32 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:34353 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751525Ab2ECKTb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 06:19:31 -0400
Received: by ghrr11 with SMTP id r11so1566747ghr.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ev2wWKE4p0wGEjwHaaBwftpN5Cuts85oyfeHtX3fnbY=;
        b=KWnLSaOjhqrDVGul/WfnBfXcDcys5kD5yibI0J+eUNwoLRpZV/wU4HOj40FhNBGrYL
         e4sBgS7DH1NYZpno3Hbyshz2buZFaPNL2LmYeMVg7UdTO2lAuZ6/bdyzGDO6oGHleiOF
         ufBELJ7E1kuYCfnLoJuiDDwIu5GGIKrtZ1hJOppxNmWiziEom8CTCfnQLDTJSwHNvRbF
         lTHRqUu0u0KoJVuZjiA5isYwdTZX27P9C0IJzsl+xd9/nGvSofroeh9C48/xjHy/xCAo
         irZaQMb9WxLQwXKqlD05mKg71ixCXkE3i+UsiWqMpg/ZNsqnYz4ZExul5UZOfwE4DWis
         0D/w==
Received: by 10.50.154.132 with SMTP id vo4mr364950igb.27.1336040370732; Thu,
 03 May 2012 03:19:30 -0700 (PDT)
Received: by 10.50.207.40 with HTTP; Thu, 3 May 2012 03:19:30 -0700 (PDT)
In-Reply-To: <7vaa1phica.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196894>

2012/5/3 Junio C Hamano <gitster@pobox.com>:
> I am not sure if writing down bureaucratic-sounding and rigid rules is the
> best first response to this kind of incident.

I think a WIP/XX branch is nessary in the early phase of new language XX.
If a contributor sent a pull request with a untranslated XX.po, and said,
"Please pull this initial commit to master branch, so that other contributors
may notice a team of XX already exists, and won't translate it twice."
It does make sense, but what if this contributor gives up at last for some
reasons, and left a zero translated XX.po in po/ directory?

Create a WIP/XX branch and merge it back to master branch when the
translation is 100% (or 90%) completed. The WIP/XX branch will be deleted
after that. The overall workflow does not changed, no extra work for l10n
teams, and leave po/README unchanged is OK.

> the first response should be to admit it, i.e. "Sorry, there
> was a miscommunication and gap in understanding among us. I as the i18n
> coordinator should have double checked before responding to pull requests
> to see if there was a consensus within the l10n team for the particular
> language. I'll try to be more careful until we nail the procedure down and
> everybody gets more comfortable with the process."

Yes. I'm sorry about that. I think disallow new l10n support to the maint
branch and later rc phase will solve this problem.


-- 
Jiang Xin
