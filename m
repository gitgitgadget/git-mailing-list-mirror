From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 40/45] parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
Date: Fri, 15 Mar 2013 18:00:56 -0400
Message-ID: <CAPig+cSbb7hz2PMyOegqGRofQ8nUsVL7JboWobVviyy0spy=9w@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
	<1363327620-29017-41-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 23:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGcgo-00016g-Hu
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 23:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab3COWA6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 18:00:58 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:60946 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab3COWA6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 18:00:58 -0400
Received: by mail-lb0-f181.google.com with SMTP id gm6so3138561lbb.40
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 15:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kVT1Lfi9wmGZexo0BeOLxcz9YSEmHNdeNhh9wVWS4rA=;
        b=YwlsOphbAvQC9eVQovQpm0Dpek0RPLaeEGTLr2OpdCygS83U9Uza9hc+8ZdRsZR7GX
         nGBxPzdFpGyDqkVm43l2IlP0+WEDNUoRRGGm11fBpZ7fxVlNloo2xCkRBs6XA5Lu0R8Q
         KfQ2xA6yYb6UOVr40KGlt7nxCKPMuO/NP8ipUP6aB2si4sslwMVde0J024UjbsnDjIn7
         6AEk1Kdin9+Uzr8zU6i3RxgGCaeC9HHOh8PAg5aTau8qBu3KOdXhEKweS/KHgEEzhheF
         djmp6DrGzLLgtSm3Crf8PPZojrXfyfzoLsq/H3HrqYGSsN+rkQusmS/QzxcuP9CD08Ln
         EOcQ==
X-Received: by 10.112.30.104 with SMTP id r8mr3268739lbh.82.1363384856422;
 Fri, 15 Mar 2013 15:00:56 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Fri, 15 Mar 2013 15:00:56 -0700 (PDT)
In-Reply-To: <1363327620-29017-41-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: dbib7L5n1nBjPE5iCEPBJKSb2TM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218264>

On Fri, Mar 15, 2013 at 2:06 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Prefix length is not preserved across commands when --literal-pathspe=
cs
> is specified (no magic is allowed, including 'prefix'). That's OK
> because we all paths are literal. No magic, no special treatment

s/we all/we know all/
=2E..or...
s/we all/all/

> We could also preserve 'prefix' across commands is quote the prefix
> part, then dequote on receiving. But it may not be 100% accurate, we

s/is quote/by quoting/
s/dequote/dequoting/

> may dequote longer than the original prefix part, for example. That
> may be good or not, but it's not the purpose.
