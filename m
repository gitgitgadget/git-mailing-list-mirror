From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/2 v2] mergetool--lib: Add Beyond Compare 3 as a tool
Date: Mon, 28 Feb 2011 07:25:32 +0100
Message-ID: <AANLkTimC2bE1fjr=+ys4YHyft5H7y-mknOMbuMdewJDQ@mail.gmail.com>
References: <4D6A355C.3000805@gmail.com>
	<4D6A365E.4030904@gmail.com>
	<4D6B3D6B.2010001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	charles@hashpling.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 07:26:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtwYY-0000Px-Jg
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 07:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab1B1G0C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 01:26:02 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52546 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab1B1G0A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 01:26:00 -0500
Received: by qwd7 with SMTP id 7so2589587qwd.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 22:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BL2kAUP/NsgO5xAQhdmDD6lFlSS7AvA4zz/sVfBmKC8=;
        b=uQFR7EoxkPjlbiQ0jmSn55CW4Um3lqFDfzdN5j6B604v85tOsvYfo5q3hxyZPoKpPT
         fF5XHJseY3qy6PeSU3B2CyqSFaQAaI/8EpQZ3PJQgpO/f5jqn92PvqivIP8poXQthkb4
         tmK6CZZ0vf1CcJJSzY4AoExaFCwsITV6h6Jrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CFuaK7A4l1eOukniovSsut/1ucdJnRcGWQXriGOhdq/8qk3Qj625vorvetB45FKb4H
         w3OxTOx0d+TWmQ86+C48HgCiXy7xy1XET/perLDkq1+ar32RPwForFBOY5I2Ny2sq90g
         vYQq5FNleE19nI5a9ZlYuCSlrWHBCmVn/aEDs=
Received: by 10.229.236.194 with SMTP id kl2mr3698886qcb.263.1298874332370;
 Sun, 27 Feb 2011 22:25:32 -0800 (PST)
Received: by 10.229.17.73 with HTTP; Sun, 27 Feb 2011 22:25:32 -0800 (PST)
In-Reply-To: <4D6B3D6B.2010001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168067>

On Mon, Feb 28, 2011 at 07:15, Chris Packham <judge.packham@gmail.com> =
wrote:

>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>> ---
>> =C2=A0Documentation/git-difftool.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A02 +-
>> =C2=A0Documentation/git-mergetool.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A02 +-
>> =C2=A0Documentation/merge-config.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A02 +-
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 =C2=A02 +-
>> =C2=A0git-gui/lib/mergetool.tcl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A07 +++++++
>> =C2=A0git-mergetool--lib.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 22 ++++++++++++++++++++--
>> =C2=A06 files changed, 31 insertions(+), 6 deletions(-)
>
> Works for me.
>
> Tested-by: Chris Packham <judge.packham@gmail.com>

Great, thanks for testing!

--=20
Sebastian Schuberth
