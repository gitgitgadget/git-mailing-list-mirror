From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3] trace: omit repository discovery report
Date: Wed, 26 Jan 2011 02:19:21 +0100
Message-ID: <AANLkTinyVKQOVHgdVhB3PhQOp9FbdNNHLqYny6i=_qKw@mail.gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-2-git-send-email-pclouds@gmail.com> <20110126004915.GA11230@burratino>
 <20110126005916.GC11230@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 02:19:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phu31-0002Ss-27
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 02:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab1AZBTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 20:19:42 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:34414 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab1AZBTl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 20:19:41 -0500
Received: by yib18 with SMTP id 18so1961574yib.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 17:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=8LugcGpZ4VP7hdCgVeKFjlVCLhMAjjAQQMtRzvLWIIQ=;
        b=r1qh8695vSMZiOSnawSXvM20hZImQPiRkdeTC0oKbfbzer3l9mqPbB37P7C1Gi1tfE
         goUbpvPseHeaSDqno+OgTWKYvXOqlOD8wVKMIjEOB0BNe3WdHxi0TMZ6aVPwyTZu9cDd
         kA1w15DAsy4B/MuSvIyFlHT7q80Vb+lDJtKnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ex2euBkKjQboEOYSf1mBmUwGFDi2S390yTo644vi7gV6PP08TduqJXCBUV6GUEwd++
         u2hJvrIjNjnRtM/sp9hHYlrh77PWnyjA8vfEcd0m/uoLMO1q5ypgmMMl8oaah9CkA1nG
         0beDGqTnhLoJ1eMBSeYdWbLUR8uINlZkGXEAs=
Received: by 10.150.203.19 with SMTP id a19mr381680ybg.328.1296004781176; Tue,
 25 Jan 2011 17:19:41 -0800 (PST)
Received: by 10.151.6.10 with HTTP; Tue, 25 Jan 2011 17:19:21 -0800 (PST)
In-Reply-To: <20110126005916.GC11230@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165495>

Heya,

2011/1/26 Jonathan Nieder <jrnieder@gmail.com>:
> In practice, four extra lines of trace output per git process is too
> much noise. =C2=A0So stop printing repository discovery info except w=
hen
> running tests.

Doesn't this disable _all_ discovery debugging aids? So doesn't this
make it more difficult to figure out what's going on in the
not-many-child case?

--=20
Cheers,

Sverre Rabbelier
