From: =?UTF-8?B?RnLDqWTDqXJpYyBEZWxhbm95?= <frederic.delanoy@gmail.com>
Subject: Re: Using really empty start prefixes for git-format-patch numbered patches?
Date: Mon, 30 May 2011 15:04:13 +0200
Message-ID: <BANLkTikUECxikNKmYX1qoXvz1xmYRRtfUg@mail.gmail.com>
References: <BANLkTikVQWN2kZ4gc8kd-kJWZhLXgkvTAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 15:04:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR29J-0000f9-UW
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 15:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab1E3NEp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 09:04:45 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39604 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab1E3NEo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 09:04:44 -0400
Received: by ewy4 with SMTP id 4so1309955ewy.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=4VIEUGnOOcNt6X1KiyWAZvtwznXS4qGghSN3Cd7y4NM=;
        b=exgd++X0fA+pZKCeEJQpA5I/Weq716rHUQuivsm4fvsd7He3GOt9pApRm3JvvpvDND
         8q9nBcpS+haBY0FJRg5a5DlANj/t2i2QzdykdQvjszIlTjcpuel/TxBpgU55lK7VNv4G
         Wk9aZGjBBh07LmMDlQNLsUdnTsyehiC+8k7Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=Rj5AD245yvHf7vrWJe7t4GE9eZED6+jwZgqMR9qgTUI91LCu8Ox++So5E8Bd0dEnDD
         HlZw3WQ0nZOTjVUMQWBah//8+rYYiCkT5DtUEiKRSTN+gQjkS44DQO6CF2OO6O/+9kQs
         A1nmqfV/BFteCaXnUSlrRfXN3aAbF7qt4lGfg=
Received: by 10.14.119.9 with SMTP id m9mr1715473eeh.143.1306760683151; Mon,
 30 May 2011 06:04:43 -0700 (PDT)
Received: by 10.14.100.16 with HTTP; Mon, 30 May 2011 06:04:13 -0700 (PDT)
In-Reply-To: <BANLkTikVQWN2kZ4gc8kd-kJWZhLXgkvTAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174744>

Is this a bug or a feature?

2011/5/28 Fr=C3=A9d=C3=A9ric Delanoy <frederic.delanoy@gmail.com>:
> Hi,
>
> I'm trying to generate numbered patches using git-format-patch such
> that I get e.g. [1/2] instead of [PATCH 1/2]
>
> However, if I use an empty string as prefix, for instance in
>
> git-format-patch --subject-prefix=3D"" -2
>
> an extraneous space is inserted, and I get [ 1/2] instead of desired
> [1/2] in the Subject line
>
> (I also tried using a single backspace char as prefix, but that didn'=
t
> change anything, as might have been expected)
>
> Is there a way to get rid of this space? IMO the space should only be
> added if the prefix is non-empty
>
> Fr=C3=A9d=C3=A9ric Delanoy
>
