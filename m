From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH] Document ls-files -t as obsolete.
Date: Wed, 14 Apr 2010 16:47:45 +0200
Message-ID: <z2hd2d39d861004140747u5980eeach66b58102cd5ede25@mail.gmail.com>
References: <1271252704-21739-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 16:48:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O23sk-0001O9-0v
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 16:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab0DNOrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 10:47:49 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:52475 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab0DNOrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 10:47:48 -0400
Received: by bwz25 with SMTP id 25so254722bwz.28
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=HYKVbDs4i7/ehaiAEiY4FCX2WTWt4GsGk2LKFNOkyKI=;
        b=UNcnsacGqX+KTRC+n8jART2Fk3V0wNJGDnsvHCFVW48ZxJGPvm434k7eGB0qJUqbqx
         FMC2eT6G9taIWXHXCN48eB4fnYvQqfTZepWKolCpmw3w4nkLE5XlbstXdGsrAMxkpqnM
         7vuZyV7fcsn3hAA95wreO5ENp95hD9lmPiQF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Dp06xpBS+zRtK/d5Y2R6FxfmLiSfCKZmGJrPCHdIrO6tVu7zq8VOXCUffvo2GjuV/h
         AKlc5kM2R4mJgLXgeXwbLszhc2OrECydMOy6rBHm+UDMkFKUpRbKucj3nIxfjgsiFwnu
         nQicqCvbL4YhsaF3oYBV8IHyEAQZg+h8GVT6k=
Received: by 10.239.179.197 with HTTP; Wed, 14 Apr 2010 07:47:45 -0700 (PDT)
In-Reply-To: <1271252704-21739-1-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: ff460534ac5001b0
Received: by 10.239.174.15 with SMTP id h15mr447694hbf.46.1271256465246; Wed, 
	14 Apr 2010 07:47:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144879>

Sorry for being stupid and a bit off-topic, but..

> =A0-t::
> + =A0 =A0 =A0 This feature is deprecated. Authors of scripts should u=
se
> + =A0 =A0 =A0 linkgit:git-status[1] `--porcelain`, [...]

I've always understood 'porcelain' as for users, and 'plumbing' for
scripts.. so, if the option is meant for scripting (as opposed to
--short), why wasn't it called --plumbing? There's obviously something
I'm not getting here! -:)

-Tor
