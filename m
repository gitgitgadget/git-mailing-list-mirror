From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/remote-helpers: explain capabilities first
Date: Fri, 18 Mar 2011 19:07:35 +0100
Message-ID: <AANLkTimfZM6muiU3vPMgx3NnRdb4H0t4E2DMXt1233LP@mail.gmail.com>
References: <20110318174504.GA22332@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 19:08:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0e62-0005eK-0z
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 19:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534Ab1CRSIR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 14:08:17 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:57625 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab1CRSIP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 14:08:15 -0400
Received: by yia27 with SMTP id 27so1684766yia.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KX1MTEapSwamHopWfLI2yp82vQQ0piGpS818jZQid1s=;
        b=Og+kWQ894gYOvSDqgbkCkuhyDLuDw9oYRvzxbqCj9T3cxBxrWe96SMxEfm6M03PIZ8
         dL/siqGksGyaG0PRMcHKb40BpgsQbBF2LKWmNXxcFIv0Nefu2qBUzQVpJ1YlCY6+rNSM
         vi27lGFb1LyWQ74PEZLDZ7Sjz+3JbFwiEDnqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=n6u8v5CxEwa/2refyw/RO2kesXiOfUXPS7P78wa03DfI9yLVfhEBkwOd3pcawiGJox
         ydkqoMqxYDdzna3KDa2rAqk/MisvUxw3CEMfI8JkfTYodyKhaFs4QtLkSj8GfSPXYWDY
         h3CV8w56a23XLvtB0DXt5s2z9DQ+yBAfx/jDo=
Received: by 10.151.88.32 with SMTP id q32mr1107569ybl.145.1300471695126; Fri,
 18 Mar 2011 11:08:15 -0700 (PDT)
Received: by 10.151.44.10 with HTTP; Fri, 18 Mar 2011 11:07:35 -0700 (PDT)
In-Reply-To: <20110318174504.GA22332@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169344>

Heya,

On Fri, Mar 18, 2011 at 18:45, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> No documentation for "export" ... yet

Which is for the better, since I think the current interface is
broken. It'll be easier to justify changing it if it's not documented
;).

> (by the way: would it
> make sense to export the GIT_DIR environment variable so a round trip
> for the 'gitdir' capability would eventually be unnecessary?).

Yes, that makes a lot of sense.

> The current documentation left me lost, so I wrote this (which still
> probably leaves one lost). =C2=A0Thoughts?

I think it makes sense.

--=20
Cheers,

Sverre Rabbelier
