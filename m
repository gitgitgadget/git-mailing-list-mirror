From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 14/18] git notes merge: Manual conflict resolution, part 2/2
Date: Wed, 29 Sep 2010 16:19:30 +0000
Message-ID: <AANLkTimzii1TEqRY40idz_i8qXHGFnoCZa29eH31U6n7@mail.gmail.com>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
	<1285719811-10871-15-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 18:19:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0zNZ-0007M9-7O
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 18:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab0I2QTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 12:19:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40611 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0I2QTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 12:19:30 -0400
Received: by iwn5 with SMTP id 5so1205278iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yUhdtvvtiis3557Kjth19+vYINsTk4BwsWEgzBVxIVg=;
        b=HyDQ0Uu2VFyj/lVRBwD0ys7c16HO5Jdq6IXUkXlVn0aTDa5zSIpDf0dFwRAvrekQjz
         i2rvOqjGdacoAxxd7KD1mGmgrFQloVgLyItcIXwqgl0/cXW8t3C1TedFwNyDPaQiYqfI
         tWzunhcGuTPGDUYXVx051ZDz0H1AKucpKF5Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jvTmAmKLi2tKmuSvccGyo0MG0SjBZhKPD7J/4iZ7PPnP3cqO3FqEJUqSLrqWH5724P
         88s2CJpRFHQAH7QWLTY2ynl70rSpHtgsXoOeHmQJRdx/c/KoGAqTySObkniJkhxFmDVf
         rcU1ef+5v8U3tYZ16MhsPZ6pRh5C5LkKWoFVg=
Received: by 10.231.174.84 with SMTP id s20mr2035693ibz.94.1285777170277; Wed,
 29 Sep 2010 09:19:30 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 29 Sep 2010 09:19:30 -0700 (PDT)
In-Reply-To: <1285719811-10871-15-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157583>

On Wed, Sep 29, 2010 at 00:23, Johan Herland <johan@herland.net> wrote:

> +--commit::
> + =C2=A0 =C2=A0 =C2=A0 Finalize an in-progress 'git notes merge', i.e=
=2E a notes merge with
> + =C2=A0 =C2=A0 =C2=A0 conflicts. When 'git notes merge' encounters c=
onflicts, it s
> + =C2=A0 =C2=A0 =C2=A0 which returned one or more conflicts (that you=
 have now resolved)

This "it s ..." sentence doesn't make sense.
