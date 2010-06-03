From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] branch: don't fail listing branches if one of the 
	commits wasn't found
Date: Thu, 3 Jun 2010 19:42:01 +0200
Message-ID: <AANLkTinD2OLZllialwyAwuEroCDo9w56Zu_3bhKbf-gg@mail.gmail.com>
References: <20100603065527.GA23439@progeny.tock> <1275551282-21557-2-git-send-email-simo.melenius@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Simo Melenius <simo.melenius@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jun 03 19:51:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKEZI-0001Uq-9m
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 19:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071Ab0FCRug convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 13:50:36 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36694 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079Ab0FCRuf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 13:50:35 -0400
Received: by yxl31 with SMTP id 31so171179yxl.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=G9phGn++Uumdaz911TkrMCEOsg34PGTxypx50GIX34Q=;
        b=OCQtBEUtIcUKMYOJff9RTdCSYFh++at8ClpgS9RvvPtXCP6zaLCbB7oL7eBCTlUVfW
         13q5J1pAx9EQp7gtPo3F+5aUP0JLV3AZ4K3xnTOo+P4qW+eEWmpJRK0ZyENzTXiNywaA
         cjH2n1eJWh1rJPSBM4LnyR0cQDtabvU4JNnhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=w5ru0UpZzSm+hsImtiYG3Wj6Uu6kVVV9ZrUTw0Ra99MyXyl3woigmkaZW3tYVP78iv
         n3V8/544JOEHDemMRMVlo7Apuq0OhC30thZM8DFmIHTY6KxcmgdxDZnwepWm3LGZUPmO
         b55Fvr0p7QMBnPlKjTJ+fdh2hDTlLyqcfzYLc=
Received: by 10.151.61.13 with SMTP id o13mr9336774ybk.401.1275586942617; Thu, 
	03 Jun 2010 10:42:22 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Thu, 3 Jun 2010 10:42:01 -0700 (PDT)
In-Reply-To: <1275551282-21557-2-git-send-email-simo.melenius@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148350>

Heya,

On Thu, Jun 3, 2010 at 09:48, Simo Melenius <simo.melenius@iki.fi> wrot=
e:
> + =C2=A0 =C2=A0 =C2=A0 if (cb.ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("some refs c=
ould not be read, review stderr");

I don't think there's any precedence for an error message like this,
perhaps in git-svn's "the above error message is nothing to worry
about, move along", which I think is silly as well. I think it's best
to just s/, review stderr// here.

--=20
Cheers,

Sverre Rabbelier
