From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] sha1_name: allow to add @{...} alias via config
Date: Wed, 8 Sep 2010 20:12:49 +1000
Message-ID: <AANLkTimR35gKwXg9Ve5y2SqaxyxcM410h3p=eM9cHWY2@mail.gmail.com>
References: <1283918641-3662-1-git-send-email-pclouds@gmail.com>
 <AANLkTimK6MwJHYafAAYNn+h3HD1f0H-BHsQYph4qbCrJ@mail.gmail.com> <AANLkTin83BQ0YhWHuDqkY4HYWP9+bUso1BDNbFtRskDp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Sep 08 12:16:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtHhQ-0002LJ-3q
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 12:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451Ab0IHKQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 06:16:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49571 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab0IHKQK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 06:16:10 -0400
Received: by wwj40 with SMTP id 40so9667572wwj.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 03:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lC0p+bNHECelTYrNY7D+Ao3bM6GZI0tphZBnMEsks+g=;
        b=dVuZbsgRu5QI9ZgZbI0iRNZe05mvR7V0jenzWdDiaHhDQXwyQKy0V3+lQJJoCJl7SS
         ZdIelbLQzfSFDbG7wF53RRNj3lsGLiAAJF+TBLR4yQPYl9rioHHsQ23WkV6/6z6DWCke
         OvN+Nc0XqpeGYKPTypJ976onpikkCDSh5LkQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=K4s6DF2FbxuaRWbhXkQPss2pZ7L9ApqztWiiFIp+mCY1lHF+IAB3sb4fmh+V1aq55A
         Dw0QJTqPgjNcN1e/0gzRM/LaZ+F7CQZjMZUxzVhAN+D7yARrlgddKFEY0eI/Fm5zIi3j
         tUXJGJjIO7wiAOy/bqUMAAYqK8phda/DvzBG0=
Received: by 10.216.157.72 with SMTP id n50mr31465wek.4.1283940789445; Wed, 08
 Sep 2010 03:13:09 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 8 Sep 2010 03:12:49 -0700 (PDT)
In-Reply-To: <AANLkTin83BQ0YhWHuDqkY4HYWP9+bUso1BDNbFtRskDp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155780>

2010/9/8 Santi B=C3=A9jar <santi@agolina.net>:
> 2010/9/8 Santi B=C3=A9jar <santi@agolina.net>:
>> 2010/9/8 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>>> This allows users to add new @{..} alias via ref-at.* config
>>> variables. The rewrite rule is printf-alike.
>>
>> Another issue is that it can shadow builtin @{}s, like @{upstream}.
>
> In fact this patch breaks @{upstream}.

My fault. There should not be an equal in

if (substitute_ref_at(&new_str, str) >=3D 0)
--=20
Duy
