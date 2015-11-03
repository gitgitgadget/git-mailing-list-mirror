From: David Turner <dturner@twopensource.com>
Subject: Re: Strange diff-index output
Date: Mon, 02 Nov 2015 19:27:49 -0500
Organization: Twitter
Message-ID: <1446510469.4131.35.camel@twopensource.com>
References: <CABxGUTj-5vdmyVGkKuoMdBAG2EAQvLJNYLLA++T2hNFvGRmb0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ch'Gans <chgans@gna.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 01:28:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtPSE-0000Pc-AF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 01:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbbKCA1x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 19:27:53 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33225 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbbKCA1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 19:27:52 -0500
Received: by qgeo38 with SMTP id o38so860453qge.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 16:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=BP+yOTcW0rVEGPeT/CDeYEw/Fq3pv8Q1dfWqtN7WkCQ=;
        b=Nb5ZD3Qk1As686zpv6XlsJ/fAq1qCGsLdDpoha3mxuxcLJfyMOXC64SEu2HKND96NZ
         cltSXtwmmfd6u3oIv2NcvyuMmTt5QZYpS1ZjilUAky3pfQvdXxaZv3P0HdxtQ803hjku
         gq09iBg3PIJwfGilMF/JrW7ws/I4nFe/Wg9GjIeZqLXCo4phw/mGI9pSdGZ0hT30LkAV
         aPJk6+ynshK5JLVJGjFaBAcSWEWbaYeATbOn6SFdIsydbnr7WsFpGbpSWHK63VRaFNWf
         ins7FpoSvQELxbP/Ml9ak/u0LQK/JC6DqRTP+szpqnOafpw+rN7DKpx112uj/zUrK63g
         pvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=BP+yOTcW0rVEGPeT/CDeYEw/Fq3pv8Q1dfWqtN7WkCQ=;
        b=SqH4bYh3YooNpwGwsWJS5ZQQYV3tuGZhhWsmtv+fTLV6m0ZbgGVYbm7KRh29Kxmhv5
         GezTdh5xIzI1UfDJPSkjDuEOeghzkYM3w+ae62TNa13I8IFQcQUJc4O09sMqjjQH6mQ1
         LU7TV9M1y3F3sMztxV7EbhKVoFyZHa2aEiFR1SxgJC1vOa2hL+q0GN4uCpxc4rd0VnT0
         +xXAWK0dVOA7gIxXEx3fOjLBqXsmozx9E1pTDxHv6GIZTffZvv+9jiJZcWV+VCmHX9AL
         Y9BZh+5rZKNCUQ7n1iQrExSaZftUjDxL8i7Pbh6gESvr0GhLZCkRFZGZQ+8Yi2ApyeAv
         oAog==
X-Gm-Message-State: ALoCoQnNk1hJ/wggBzt7LVq4Nz+FSqC8/qS2MOq3iAICmP8BYfl8j0dblk+IhXvvO09dSKdYxuej
X-Received: by 10.140.25.166 with SMTP id 35mr34197383qgt.96.1446510471475;
        Mon, 02 Nov 2015 16:27:51 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id s68sm8850589qge.42.2015.11.02.16.27.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 16:27:50 -0800 (PST)
In-Reply-To: <CABxGUTj-5vdmyVGkKuoMdBAG2EAQvLJNYLLA++T2hNFvGRmb0w@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280739>

On Tue, 2015-11-03 at 12:59 +1300, Ch'Gans wrote:
> Hi there,
>=20
> We're using a script to verify that what we are building is clean
> against our git repository, for this we're using "git rev-parse
> --short HEAD" to get the current hash and "git diff-index --quiet
> HEAD" to check for local modification.

See this note from the git diff-index man page:
           Note
           As with other commands of this type, git diff-index does not
           actually look at the contents of the file at all. So maybe
           kernel/sched.c hasn=E2=80=99t actually changed, and it=E2=80=
=99s just that
you
           touched it. In either case, it=E2=80=99s a note that you nee=
d to git
           update-index it to make the index be in sync.

You can either add an update-index to your script, or use git status
--porcelain.
