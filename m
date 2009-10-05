From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Mon, 5 Oct 2009 15:18:48 -0400
Message-ID: <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com>
References: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> 
	<20091005152504.GE9261@spearce.org> <20091005165802.GA24402@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:29:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MutFL-0007dx-Eb
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 21:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbZJETTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 15:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbZJETTl
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 15:19:41 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:50153 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbZJETTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 15:19:41 -0400
Received: by bwz6 with SMTP id 6so2744949bwz.37
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=a9YPi+ozL/A4H6SkZPHuKc03TrUyjzwckZ2HIyn0i+c=;
        b=mEC5LFK1exjX0aEIjlO8x5NtMuiwE1OzwJ9Pkpu3zfASu69sLUMvkrz6CQOeDjlgik
         5PD6+4nFLdZGDWzRUZe4xAZi8ejZujWqsYj77QOCEMc72RbsaufGjQPiz6hNgc3aQxNu
         uF9UQyhxniBP0Jm/XyWz1/uAehZrQalJaEzrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=krUdaVLllASLKMl/74S0NUfxjwgxJRuOitY0I/rzao9NcbobTViBWkaer7ijIcZg1r
         7BFmknT4mrGWaab0uhqhZeNIs0qO86M2qbu6ckaUXMdFBTExqn30xrz65V6W2FThP9al
         qe4LomRRuGoPahuCvFuoZtullbgFBn+eHK1Ig=
Received: by 10.223.23.74 with SMTP id q10mr211714fab.14.1254770343558; Mon, 
	05 Oct 2009 12:19:03 -0700 (PDT)
In-Reply-To: <20091005165802.GA24402@tugrik.mns.mnsspb.ru>
X-Google-Sender-Auth: 546e3e3bb76bfacd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129580>

> The other possibility is to pregenerate all these lists at git build time, but
> are we going to do it for things under contrib/ ?

IIRC, that's what StGIT does with its completion script. As a
consequence, StGIT completion is substantially faster than git
completion.

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>
