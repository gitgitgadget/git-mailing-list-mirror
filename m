From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Sat, 10 Apr 2010 01:33:47 +0200
Message-ID: <i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 01:39:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0NnT-0007q9-C3
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 01:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab0DIXjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 19:39:31 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:64215 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab0DIXja convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 19:39:30 -0400
Received: by gxk9 with SMTP id 9so2250081gxk.8
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DN7F84bgxiRxvenVJj45BU3L9ZQWpKgOr+pbRyYqyhA=;
        b=bm8fJPutBrJcFzhzEobyg7OiUVLDWYyoMcWDX00mbgatXCvTMaDwXqwJdXAdHu0KDu
         lFssOk1HbLLlIcC4mTAtfm33lECQcT04LVqo21ehiHPspw4H+bqAzgRKdTO/inpxwW3K
         QMkblWkTAqBCURQisSrWAuyXUPiKj3aipblb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iarqt0I9lgLefCVcbmDPYOw0YU9F97OPJBe/cyDEUtHI90eZ2fsvs8h+9WEAwwyRTA
         cQKRFbF62U9yfH5oEXEQpVpNide987p+ERGrIU23ZsJN8ym5A1IkcWBwKVXbUnjaP1kR
         tGEffi9ZkROI6NRiM6aqkLaAzywJ1fUWSBw6Y=
Received: by 10.100.206.13 with HTTP; Fri, 9 Apr 2010 16:33:47 -0700 (PDT)
In-Reply-To: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
Received: by 10.101.109.20 with SMTP id l20mr1443440anm.37.1270856369371; Fri, 
	09 Apr 2010 16:39:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144489>

Heya,

On Sat, Apr 10, 2010 at 01:24, Aghiles <aghilesk@gmail.com> wrote:
> If I type:
>
> =C2=A0 =C2=A0git log FETCH_HEAD~4..HEAD
>
> I get something. But if I type:
>
> =C2=A0 =C2=A0git log HEAD..FETCH_HEAD~4
>
> I get nothing. Is there a good reason for that ?

Yes, read up on the documentation as to what ".." means. Hint, a \ b
is not the same as b \ a [0].

[0] http://en.wikipedia.org/wiki/Intersection_(set_theory)

--=20
Cheers,

Sverre Rabbelier
