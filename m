From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 00/46] nd/setup remainder for convenient reference
Date: Wed, 14 Apr 2010 09:59:55 +0200
Message-ID: <y2vfcaeb9bf1004140059j1a93bb72mb8feb33f25d9e3a7@mail.gmail.com>
References: <20100413021153.GA3978@progeny.tock> <20100413030853.GJ4118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 10:06:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1xcF-0001j8-BA
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 10:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab0DNIGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 04:06:08 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:49735 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0DNIGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 04:06:04 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2010 04:06:04 EDT
Received: by qyk34 with SMTP id 34so537974qyk.22
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=lftPUTlGQn4UHrHO6YtcYJPmcQ9P1r+N3TJVtJ0iTn8=;
        b=Vyyo3AxirHKgntonKa4rgJAGnAnuWwMulZCNXgg9SvMjgaE7cbCc5/7eEZswovvBv8
         1psPkK0t9DjKswvrnf9qM92k1vV/6xcFVSST+SVTTEBLozu8nSItbFh95HCfVJ1X2G/g
         bPeAM8IELIrh1VEGhwLmDf7y0TSUl3DUDU1WM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kxgZ5EnW8uIcJYPJ7swtaDgpMadb4l8XCPuj5kiglQk2Y9HYjhjGJT8tk6wBk4vQ+A
         LoThEl5QkasojL6H9pJ05Fxh0eTOBdhNq/otW5wQNeUhCiUZrOntj+z6ceqCtOZuPk6P
         8Q61TWEPtqGKImyqCx2bfULdpS45NzeAvrNcA=
Received: by 10.224.2.76 with HTTP; Wed, 14 Apr 2010 00:59:55 -0700 (PDT)
In-Reply-To: <20100413030853.GJ4118@progeny.tock>
Received: by 10.224.50.80 with SMTP id y16mr2501103qaf.375.1271232015203; Wed, 
	14 Apr 2010 01:00:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144857>

2010/4/13 Jonathan Nieder <jrnieder@gmail.com>:
> I was thinking of sending the remainder of nd/setup after this to save
> others the trouble of rebasing, but I fear the traffic would be too
> disruptive.  So I am putting it up by git.
>
> Caveats: maybe these patches make no sense.  After I last rebased
> them, I walked away without looking.  Still, maybe they can save
> you some time.

Will go through them, but not now.

> are available in the git repository at:
>
>  git://repo.or.cz/git/jrn.git/ nd/setup

I took your tree (5d46d95), dropped "builtin: USE_PAGER should not be
used without RUN_SETUP*" (it's useless), lightly modified "alias: keep
repository found while collecting aliases as long as possible" and
replaced "Guard unallowed access to repository when it's not set up".
Available at:

git://repo.or.cz/git/pclouds.git tp/setup

I will split the "Guard..." patch for easier review, later today. I
couldn't because it was a die() patch. Now all it does is warning(),
so it's safe to split up. One more good point of warning().
-- 
Duy
