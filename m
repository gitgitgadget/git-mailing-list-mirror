From: Anton Gyllenberg <anton@iki.fi>
Subject: Re: svn clone Checksum mismatch question
Date: Mon, 30 Mar 2009 10:26:40 +0300
Message-ID: <83dfc36c0903300026j2e3cb8acm86bb47b5ca7014e1@mail.gmail.com>
References: <22719363.post@talk.nabble.com>
	 <20090326130213.GC3114@atjola.homenet>
	 <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com>
	 <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com>
	 <20090329060858.GB15773@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 09:28:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBup-0007OD-A4
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 09:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbZC3H0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 03:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbZC3H0o
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 03:26:44 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:57625 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbZC3H0n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 03:26:43 -0400
Received: by ewy9 with SMTP id 9so1917839ewy.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 00:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=CS24oyChDLLrlcIOXeNYOuAmzSDDO/nSRAwY17JaWMY=;
        b=Aza6IUHz73YICsJX/Yb4L/cUfVSWqZSJwPJoYh3++g3Ri8l0Gf7I9LgEiRX6nMOCWc
         +qV2ORJ2GXqxWk/MqT5KLRdU9ufnlFvx1mZ7YY17T6mRv7+dAl+leS4kLtSpUR7B4PDu
         vyHXHs2FXRLtxW/loxBNT/4nDPfQrgPBAKCCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=kFhfrW2KLU3OfOCg9abuLUFLrpmLP83T2T4i/1YBVMHqdbk84Bq5P45ia9JAUi94XE
         +BDhctFaR+BPVOyVpIYGANs4sS/TaODlteb8FycfrcHqu/GqXfnjyI8G79ttGo2Fmr9w
         wOk1GJL4oM+azcNlxh0u1qQ1WI1ED8cnOfYBI=
Received: by 10.210.62.3 with SMTP id k3mr1001739eba.68.1238398000802; Mon, 30 
	Mar 2009 00:26:40 -0700 (PDT)
In-Reply-To: <20090329060858.GB15773@dcvr.yhbt.net>
X-Google-Sender-Auth: 729f54749fd93e9b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115095>

Makes perfect sense now that you explain it and I see the patch. I
actually tried debugging it a bit but got lost in the perl SVN code.
Thank you Eric for figuring this out and for all your work on git-svn
in general!

> I guess few folks in the UNIX world are crazy enough to make pathnames
> prefixed with dashes :)

I guess they wouldn't call the project Twisted without reason :-).

Anton
