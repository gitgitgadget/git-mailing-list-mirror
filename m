From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: branch --set-upstream considered harmful
Date: Mon, 7 Jun 2010 13:10:07 +0800
Message-ID: <AANLkTikUkkWQl7cYuPiKGaJFYL_JlIGFCXXf7En8t0FN@mail.gmail.com>
References: <AANLkTiln_xxnF-e33YA7kkfbBBcBMd40xag8JTW0eqws@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 07:10:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLUbV-00056c-7y
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 07:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab0FGFKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 01:10:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40097 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab0FGFKJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 01:10:09 -0400
Received: by iwn37 with SMTP id 37so3001501iwn.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 22:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/KZaaFJS+eNklvbpz8gRjdyGIUB5+54ipLKAOMscnq0=;
        b=Ignbjo+C3FbOCoQUSzz3zQYRObmEjBFJDUrp7vYNIViOUOd8pvW9QynX+0iFnbrj+g
         vgkB/i7XnjCNfLjtjXR8oV7+SIc9DQrHrwInBDkto1/E372Zlcu1Vt+4Oomi+3SkfcLT
         FEoV1DoQIMOGpbtDJ235EWw+vl5SiobSl9D8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NsHUQVUFrBPYYlu/9SwZd83Y9iknLbi6r000sHt0bwuu5hBxzjmYVgnWT0mGJ9mUrE
         pyOkqGpSqSW+H3W6idagoMIi/vzf+4wiVyJXeYzCqvHt0CKbNxmDZIWhGZ2x8yzV7yXD
         uE7Na0G+0H/PDBEn/k9ALl6QcRncZEDmictpQ=
Received: by 10.231.124.77 with SMTP id t13mr3975803ibr.175.1275887407565; 
	Sun, 06 Jun 2010 22:10:07 -0700 (PDT)
Received: by 10.231.14.199 with HTTP; Sun, 6 Jun 2010 22:10:07 -0700 (PDT)
In-Reply-To: <AANLkTiln_xxnF-e33YA7kkfbBBcBMd40xag8JTW0eqws@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148570>

Hi,

On Mon, Jun 7, 2010 at 3:21 AM, Jay Soffian <jaysoffian@gmail.com> wrot=
e:
> Say I have an existing branch and it doesn't have a tracking config.
> (My local users often just do "checkout -b topic" instead of "checkou=
t
> -b topic origin/master".)
>
> I would naively expect this to work, while on that branch:
>
> =A0(topic)$ git branch --set-upstream origin/master

Hmm, I can see where the confusion is coming from - you're treating
git-branch as a "branch modifier", when it really is a "branch
creator" - unless you use -f, of course.

> [snip]
> So here's how I'm thinking about fixing it, but maybe I'm just making
> it even more confusing. What say you:
>
> =A0(topic)$ git branch --set-upstream=3Dorigin/master
> =A0Branch topic set up to track remote branch master from origin.

I was under the impression that long-style options took "=3D".

--=20
Cheers,
Ray Chuan
